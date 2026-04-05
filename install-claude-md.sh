#!/bin/bash

# CLAUDE.md 安裝腳本
# 將 Laravel 13 + Vue.js 最佳實踐指南安裝到專案中

set -e

echo "🚀 開始安裝 CLAUDE.md 到專案..."

# 1. 初始化 Git (如果還沒有)
if [ ! -d ".git" ]; then
    echo "📦 初始化 Git 倉庫..."
    git init
fi

# 2. 設定 Git 使用者資訊
echo "⚙️ 設定 Git 使用者資訊..."
git config user.name "vito1317"
git config user.email "service@vito1317.com"

# 3. 複製 CLAUDE.md 到專案根目錄
echo "📄 複製 CLAUDE.md..."
cp /home/intellitrust/.openclaw/workspace/CLAUDE.md ./CLAUDE.md

# 4. 新增檔案到 Git
echo "✅ 新增檔案到 Git..."
git add CLAUDE.md

# 5. 提交更改
echo "💾 提交更改..."
git commit -m "docs(claude): 新增 Laravel 13 + Vue.js 最佳實踐指南"

# 6. 推送到遠端 (如果已經有遠端)
if git remote get-url origin > /dev/null 2>&1; then
    echo "🌐 推送到遠端..."
    git push origin main 2>/dev/null || git push origin master 2>/dev/null || echo "⚠️ 遠端推送上傳失敗，請檢查網路"
else
    echo "⚠️ 沒有設定遠端倉庫"
    echo "   設定遠端：git remote add origin <your-repo-url>"
    echo "   推送：git push -u origin main"
fi

echo ""
echo "🎉 安裝完成！"
echo ""
echo "📚 CLAUDE.md 已安裝到專案根目錄"
echo "📖 內容包含：Laravel 13 + Vue.js 最佳實踐指南"
echo ""
echo "💡 建議："
echo "   1. 將 CLAUDE.md 加入專案文件"
echo "   2. 在開發團隊中分享這份指南"
echo "   3. 定期更新以反映專案變化"
echo ""
echo "🔗 查看內容：cat CLAUDE.md"
echo "🔍 查看 Git 狀態：git status"
echo ""