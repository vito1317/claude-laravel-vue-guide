# 鴻準專案：API 響應與錯誤處理規範

為確保前端 (Vue.js) 與電子簽核系統能穩定解析，所有 API 必須遵循此標準格式。

## 1. 標準回應結構 (Standard Response Structure)

### 成功回應 (Success)
所有成功的 API 必須包含  且  欄位包含實際內容。

```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1024,
    "mold_name": "模具A-01",
    "status": "active"
  }
}
```

### 錯誤回應 (Error)
當發生業務錯誤或驗證失敗時，必須回傳對應的 HTTP 狀態碼與錯誤訊息。

```json
{
  "code": 422,
  "message": "驗證失敗",
  "errors": {
    "mold_id": ["該欄位為必填"],
    "quantity": ["數量必須大於 0"]
  }
}
```

## 2. 常用 HTTP 狀態碼定義

| 狀態碼 | 意義 | 適用場景 |
| :--- | :--- | :--- |
| **200** | OK | 一般查詢或更新成功 |
| **201** | Created | 新增資源成功 |
| **400** | Bad Request | 請求格式錯誤 |
| **401** | Unauthorized | 未登入或 Token 失效 |
| **403** | Forbidden | 已登入但權限不足 (RBAC 攔截) |
| **404** | Not Found | 資源不存在 |
| **422** | Unprocessable Entity | 資料驗證失敗 (Validation Error) |
| **500** | Internal Server Error | 伺服器內部邏輯錯誤 |

## 3. Laravel API Resource 實作範例

在  中定義轉換邏輯，確保  欄位的一致性。

```php
// MoldResource.php
public function toArray(Request $request): array
{
    return [
        'id' => $this->id,
        'mold_name' => $this->name,
        'status' => $this->status,
        'created_at' => $this->created_at->toDateTimeString(),
    ];
}
```
