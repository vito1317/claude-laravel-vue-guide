# CLAUDE.md - 鴻準開發案開發指南

> **基於 Laravel 13 + Vue.js 3 (最新版本) 的最佳實作指南**

---

## 🎯 核心原則

### 1. 現代化開發哲學

- **Code First, Comments Later** - 程式碼本身就是最好的文件
- **DRY Principle** - Don't Repeat Yourself，重複即抽象
- **YAGNI** - You Ain't Gonna Need It，避免過度設計
- **Fail Fast** - 及早發現問題，快速修復

### 2. 技術棧規範

**後端**:
- Laravel 13 (最新版)
- PHP 8.3+
- MySQL 8.0+
- Redis 7.0+
- OpenResty (Nginx 替代方案)

**前端**:
- Vue.js 3 (Composition API)
- TypeScript (推薦使用)
- Inertia.js 1.0+
- Vite 5.0+
- Tailwind CSS 3.4+

---

## 📁 專案結構最佳實踐

### 目錄結構

```
project-root/
├── app/
│   ├── Http/
│   │   ├── Controllers/
│   │   │   ├── Api/              # API 控制器
│   │   │   └── Web/              # Web 控制器
│   │   ├── Middleware/           # 中間件
│   │   ├── Requests/             # Form Request
│   │   └── Resources/            # API Resources
│   ├── Models/                   # Eloquent Models
│   ├── Services/                 # 業務邏輯層
│   ├── Repositories/             # 數據訪問層
│   ├── Traits/                   # 可重用 Traits
│   └── Policies/                 # 授權策略
├── resources/
│   ├── js/
│   │   ├── Components/           # Vue 組件
│   │   ├── Layouts/              # 佈局組件
│   │   ├── Composables/          # Composition API 函數
│   │   └── Types/                # TypeScript 類型定義
│   └── css/
│       └── app.css               # 全局樣式
├── routes/
│   ├── api.php                   # API 路由
│   └── web.php                   # Web 路由
├── tests/
│   ├── Feature/                  # 功能測試
│   └── Unit/                     # 單元測試
└── docker/                       # Docker 配置
```

---

## 💻 程式碼規範

### 1. Controller 最佳實踐

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\WafService;
use App\Http\Requests\StoreWafRequest;
use App\Http\Resources\WafResource;
use Illuminate\Http\Request;

class WafController extends Controller
{
    public function __construct(
        private WafService $wafService
    ) {}

    public function index(Request $request)
    {
        $this->authorize('viewAny', Waf::class);
        
        $wafs = $this->wafService->list(
            $request->input('search'),
            $request->input('status'),
            $request->input('page', 1)
        );
        
        return WafResource::collection($wafs);
    }

    public function store(StoreWafRequest $request)
    {
        $this->authorize('create', Waf::class);
        
        $waf = $this->wafService->create($request->validated());
        
        return new WafResource($waf);
    }
}
```

**關鍵原則**:
- ✅ 使用依賴注入
- ✅ 業務邏輯放在 Service 層
- ✅ 使用 Form Request 驗證
- ✅ 使用 Resource 格式化回應
- ✅ 加入授權檢查

### 2. Vue.js Component 最佳實踐

```vue
<script setup lang="ts">
import { ref, computed, watch } from 'vue';
import type { Waf } from '@/types/waf';

interface Props {
    wafId: string;
    editable?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
    editable: false
});

const emit = defineEmits<{
    (e: 'update', waf: Waf): void;
    (e: 'delete', id: string): void;
}>();

const waf = ref<Waf | null>(null);
const loading = ref(false);
const error = ref<string | null>(null);

const isDeleting = ref(false);

const deleteWaf = async () => {
    if (!confirm('確定要刪除嗎？')) return;
    
    isDeleting.value = true;
    try {
        await fetch(`/api/wafs/${props.wafId}`, {
            method: 'DELETE'
        });
        emit('delete', props.wafId);
    } catch (err) {
        error.value = '刪除失敗';
    } finally {
        isDeleting.value = false;
    }
};
</script>

<template>
    <div class="waf-card">
        <div v-if="loading" class="loading">載入中...</div>
        <div v-else-if="error" class="error">{{ error }}</div>
        <div v-else-if="waf" class="content">
            <h2>{{ waf.name }}</h2>
            <p>Status: {{ waf.status }}</p>
            <button 
                v-if="editable" 
                @click="deleteWaf"
                :disabled="isDeleting"
            >
                {{ isDeleting ? '刪除中...' : '刪除' }}
            </button>
        </div>
    </div>
</template>

<style scoped>
.waf-card {
    padding: 1rem;
    border: 1px solid #e2e8f0;
    border-radius: 0.5rem;
}

.loading, .error {
    text-align: center;
    padding: 1rem;
}

.error {
    color: #ef4444;
}
</style>
```

**關鍵原則**:
- ✅ 使用 Composition API (`<script setup>`)
- ✅ 使用 TypeScript 類型安全
- ✅ 單一職責原則
- ✅ 使用 props 和 emits
- ✅ 錯誤處理和 loading 狀態

### 3. Service Layer 最佳實踐

```php
<?php

namespace App\Services;

use App\Models\Waf;
use App\Repositories\WafRepository;
use Illuminate\Support\Facades\Log;

class WafService
{
    public function __construct(
        private WafRepository $repository
    ) {}

    public function list(?string $search = null, ?string $status = null, int $page = 1)
    {
        $query = $this->repository->query();
        
        if ($search) {
            $query->where('name', 'like', "%{$search}%");
        }
        
        if ($status) {
            $query->where('status', $status);
        }
        
        return $query->paginate(15)->withQueryString();
    }

    public function create(array $data): Waf
    {
        try {
            return $this->repository->create($data);
        } catch (\Exception $e) {
            Log::error('Waf creation failed', [
                'error' => $e->getMessage(),
                'data' => $data
            ]);
            throw $e;
        }
    }

    public function update(Waf $waf, array $data): Waf
    {
        $this->repository->update($waf, $data);
        $waf->fresh();
        return $waf;
    }
}
```

### 4. Repository Pattern

```php
<?php

namespace App\Repositories;

use App\Models\Waf;
use Illuminate\Database\Eloquent\Builder;

class WafRepository
{
    public function __construct(
        protected Waf $model
    ) {}

    public function query(): Builder
    {
        return $this->model->newQuery();
    }

    public function create(array $data): Waf
    {
        return $this->model->create($data);
    }

    public function update(Waf $waf, array $data): void
    {
        $waf->update($data);
    }

    public function delete(Waf $waf): void
    {
        $waf->delete();
    }
}
```

---

## 🔄 開發工作流

### 1. Git Flow

```bash
# 從 develop 分支建立功能分支
git checkout develop
git pull origin develop
git checkout -b feature/waf-monitoring

# 提交前檢查
composer test
npm run lint

# 推送到遠端
git push origin feature/waf-monitoring

# 建立 Pull Request
```

### 2. Commit Message 規範

```bash
# 格式：<type>(<scope>): <subject>

# 類型
feat:     新功能
fix:      Bug 修復
docs:     文件更新
style:    格式調整（不影響程式碼）
refactor: 重構
test:     測試
chore:    維護工作

# 範例
feat(waf): 新增 WAF 監測功能
fix(api): 修正 WAF 狀態查詢錯誤
docs(readme): 更新部署指南
```

---

## 🔐 安全性最佳實踐

### 1. API 安全

```php
// routes/api.php
Route::middleware('auth:sanctum')->group(function () {
    Route::middleware('can:waf.view')->group(function () {
        Route::get('/waf/{waf}', [WafController::class, 'show']);
        Route::put('/waf/{waf}', [WafController::class, 'update']);
    });
    
    Route::middleware('can:waf.manage')->group(function () {
        Route::post('/waf', [WafController::class, 'store']);
        Route::delete('/waf/{waf}', [WafController::class, 'destroy']);
    });
});
```

### 2. 輸入驗證

```php
// app/Http/Requests/StoreWafRequest.php
public function rules(): array
{
    return [
        'name' => ['required', 'string', 'max:255'],
        'url' => ['required', 'url'],
        'status' => ['required', 'in:active,inactive,maintenance'],
    ];
}

public function messages(): array
{
    return [
        'name.required' => '請輸入 WAF 名稱',
        'url.url' => '請輸入有效的 URL',
    ];
}
```

### 3. SQL 注入防護

```php
// ✅ 正確
Waf::where('status', $status)->get();

// ❌ 錯誤
Waf::where("status = '{$status}'")->get();
```

---

## 🧪 測試最佳實踐

### 1. Feature Test

```php
<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use App\Models\Waf;
use Illuminate\Foundation\Testing\RefreshDatabase;

class WafApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_can_list_wafs()
    {
        $user = User::factory()->create();
        Waf::factory()->count(3)->create();

        $response = $this->actingAs($user)
            ->getJson('/api/wafs');

        $response->assertStatus(200)
            ->assertJsonStructure([
                'data' => ['*' => ['id', 'name', 'status']]
            ]);
    }

    public function test_can_create_waf()
    {
        $user = User::factory()->create();
        
        $response = $this->actingAs($user)
            ->postJson('/api/wafs', [
                'name' => 'Test WAF',
                'url' => 'https://example.com',
                'status' => 'active'
            ]);

        $response->assertStatus(201)
            ->assertJson([
                'data' => ['name' => 'Test WAF']
            ]);
    }
}
```

### 2. Unit Test

```php
<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Services\WafService;
use App\Repositories\WafRepository;
use Mockery;

class WafServiceTest extends TestCase
{
    public function test_create_waf()
    {
        $repository = Mockery::mock(WafRepository::class);
        $service = new WafService($repository);
        
        $repository->shouldReceive('create')
            ->with(['name' => 'Test'])
            ->andReturn(new Waf(['name' => 'Test']));

        $waf = $service->create(['name' => 'Test']);
        
        $this->assertEquals('Test', $waf->name);
    }
}
```

---

## 🚀 性能優化

### 1. Eager Loading

```php
// ❌ N+1 問題
$wafs = Waf::all();
foreach ($wafs as $waf) {
    echo $waf->site->name; // 每次都會查詢資料庫
}

// ✅ 正確做法
$wafs = Waf::with('site')->get();
foreach ($wafs as $waf) {
    echo $waf->site->name; // 只查詢一次
}
```

### 2. Query Optimization

```php
// 使用 select 只取需要的欄位
Waf::select('id', 'name', 'status')
    ->where('status', 'active')
    ->get();

// 使用 firstOrCreate
$waf = Waf::firstOrCreate(
    ['name' => $name],
    ['status' => 'active']
);
```

### 3. Cache Strategy

```php
// 使用 Cache 裝飾器
$wafs = Cache::remember('wafs.active', 3600, function () {
    return Waf::where('status', 'active')->get();
});

// 更新時清除快取
Cache::forget('wafs.active');
```

---

## 📊 監控與日誌

### 1. Structured Logging

```php
use Illuminate\Support\Facades\Log;

Log::channel('waf')->info('WAF status check', [
    'waf_id' => $waf->id,
    'status' => $response->status(),
    'duration' => $duration
]);
```

### 2. Error Tracking

```php
try {
    // 業務邏輯
} catch (\Exception $e) {
    Log::error('WAF operation failed', [
        'exception' => $e->getMessage(),
        'trace' => $e->getTraceAsString(),
        'context' => ['waf_id' => $waf->id]
    ]);
    
    throw $e;
}
```

---

## 🎨 UI/UX 指南

### 1. 使用 Inertia.js 頁面

```vue
<!-- resources/js/Pages/Waf/Index.vue -->
<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3';
import WafCard from '@/Components/WafCard.vue';
import type { Waf } from '@/types/waf';

defineProps<{
    wafs: Waf[];
    links: Array<{label: string, url: string|null}>;
}>();
</script>

<template>
    <Head title="WAF 管理" />
    
    <div class="container">
        <header class="header">
            <h1>WAF 管理</h1>
            <Link :href="route('waf.create')" class="btn-primary">
                新增 WAF
            </Link>
        </header>
        
        <div class="waf-list">
            <WafCard 
                v-for="waf in wafs" 
                :key="waf.id"
                :waf="waf"
                :editable="true"
                @delete="handleDelete"
            />
        </div>
        
        <nav class="pagination">
            <Link 
                v-for="link in links" 
                :key="link.label"
                :href="link.url"
                :class="{ active: link.active }"
                v-html="link.label"
            />
        </nav>
    </div>
</template>
```

### 2. 使用 Tailwind CSS

```vue
<div class="flex items-center justify-between p-4 bg-white rounded-lg shadow-sm">
    <div>
        <h3 class="text-lg font-semibold text-gray-900">
            {{ waf.name }}
        </h3>
        <p class="text-sm text-gray-600">
            {{ waf.url }}
        </p>
    </div>
    <div class="flex items-center space-x-2">
        <span class="px-2 py-1 text-xs font-medium rounded-full"
              :class="{
                  'bg-green-100 text-green-800': waf.status === 'active',
                  'bg-red-100 text-red-800': waf.status === 'inactive'
              }">
            {{ waf.status }}
        </span>
    </div>
</div>
```

---

## 🔄 部署與 CI/CD

### 1. Docker Compose

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: waf-app
    restart: unless-stopped
    ports:
      - "8000:80"
    environment:
      - APP_ENV=production
      - APP_DEBUG=false
      - DB_CONNECTION=mysql
      - DB_HOST=mysql
    depends_on:
      - mysql
      - redis

  mysql:
    image: mysql:8.0
    environment:
      - MYSQL_ROOT_PASSWORD=${DB_ROOT_PASSWORD}
      - MYSQL_DATABASE=security_one

  redis:
    image: redis:7-alpine
```

### 2. CI/CD Pipeline

```yaml
# .github/workflows/ci.yml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: '8.3'
      
      - name: Install Dependencies
        run: composer install --no-dev --optimize-autoloader
      
      - name: Run Tests
        run: composer test
      
      - name: Lint Code
        run: npm run lint
```

---

## 📚 參考資源

### 官方文件
- [Laravel 13 Documentation](https://laravel.com/docs/13.x)
- [Vue.js 3 Documentation](https://vuejs.org/)
- [Inertia.js Documentation](https://inertiajs.com/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)

### 最佳實踐
- [Laravel Best Practices](https://github.com/luispimentel/codeigniter-best-practices)
- [Vue.js Style Guide](https://vuejs.org/style-guide/)
- [PHP Standards Recommendations](https://www.php-fig.org/)

---

## 🎯 快速開始

```bash
# 建立新專案
composer create-project laravel/laravel waf-monitor

# 進入專案目錄
cd waf-monitor

# 安裝依賴
npm install

# 設定環境變數
cp .env.example .env
php artisan key:generate

# 執行 migrations
php artisan migrate

# 啟動開發伺服器
php artisan serve
npm run dev

# 開啟瀏覽器
open http://localhost:8000
```

---

**最後更新**: 2026-04-06  
**版本**: v1.0  
**維護者**: vito1317
