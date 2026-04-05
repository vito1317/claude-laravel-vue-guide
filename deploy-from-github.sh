#!/bin/bash

# GitHub 專案一鍵部署腳本
# 從 vito1317/claude-laravel-vue-guide 克隆並設置 Laravel 13 + Vue.js 專案

set -e

echo "🚀 開始從 GitHub 克隆專案..."

# 專案資訊
REPO_URL="https://github.com/vito1317/claude-laravel-vue-guide.git"
PROJECT_NAME="claude-laravel-vue-guide"
TARGET_DIR="${PROJECT_NAME}"

# 1. 克隆專案
if [ -d "$TARGET_DIR" ]; then
    echo "⚠️ 目標目錄已存在，是否覆蓋？(y/n)"
    read -r response
    if [ "$response" != "y" ]; then
        echo "❌ 取消部署"
        exit 1
    fi
    rm -rf "$TARGET_DIR"
fi

echo "📥 克隆專案中..."
git clone "$REPO_DIR" "$TARGET_DIR" || {
    echo "❌ 克隆失敗，請檢查網路或 Repo URL"
    exit 1
}

cd "$TARGET_DIR"

# 2. 安裝依賴
echo "📦 安裝 PHP 依賴..."
composer install --no-dev --optimize-autoloader

echo "📦 安裝 NPM 依賴..."
npm install

# 3. 設定環境變數
echo "⚙️ 設定環境變數..."
if [ ! -f .env ]; then
    cp .env.example .env
    echo "✅ 已從 .env.example 創建 .env"
else
    echo "ℹ️ .env 已存在，跳過"
fi

# 生成應用密鑰
php artisan key:generate --ansi

# 4. 資料庫設置
echo "🗄️ 資料庫設置..."
read -p "是否執行資料庫遷移？(y/n): " migrate_response
if [ "$migrate_response" = "y" ]; then
    php artisan migrate --force
    echo "✅ 資料庫遷移完成"
else
    echo "⏭️ 跳過資料庫遷移"
fi

# 5. 編譯前端資源
echo "🎨 編譯前端資源..."
npm run build

# 6. 設置權限
echo "🔐 設置權限..."
chmod -R 755 storage bootstrap/cache
chmod +x artisan

# 7. 創建符號連結 (如果需要)
php artisan storage:link

# 8. 清除快取
echo "🧹 清除快取..."
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

echo ""
echo "🎉 部署完成！"
echo ""
echo "📋 接下來步驟："
echo "1. 訪問專案：http://localhost/$PROJECT_NAME"
echo "2. 啟動開發伺服器：php artisan serve"
echo "3. 啟動前端：npm run dev"
echo ""
echo "🔗 GitHub Repository: https://github.com/vito1317/claude-laravel-vue-guide"
echo ""