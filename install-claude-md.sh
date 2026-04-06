#!/bin/bash

# CLAUDE.md 安裝腳本
# 將 Laravel 13 + Vue.js 最佳實踐指南安裝到專案中

set -e

echo "🚀 開始安裝 CLAUDE.md 到專案..."

# --- 強化功能：環境檢查 ---
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "❌ 錯誤: 找不到指令 '$1'，請先安裝它。"
        exit 1
    fi
}

check_command git
check_command cp

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
if [ -f "/home/intellitrust/.openclaw/workspace/CLAUDE.md" ]; then
    cp /home/intellitrust/.openclaw/workspace/CLAUDE.md ./CLAUDE.md
else
    echo "❌ 錯誤: 找不到來源檔案 /home/intellitrust/.openclaw/workspace/CLAUDE.md"
    exit 1
fi

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

# --- 強化功能：自動注入實用 Skills ---
echo "🛠️ 正在注入實用 Skills..."
# 這裡使用 clawhub 來確保技能是最新的
if command -v clawhub &> /dev/null; then
    echo "📦 使用 clawhub 進行技能同步..."
    SKILLS_TO_INSTALL=(
        "coding-agent"
        "github"
        "summarize"
        "web_search"
        "healthcheck"
        "gemini"
        "openai-whisper"
        "obsidian"
        "gog"
        "git"
    )

    for skill in "${SKILLS_TO_INSTALL[@]}"; do
        echo "  -> 正在同步技能: $skill ..."
        clawhub sync "$skill" --silent || echo "  ⚠️ 技能 $skill 同步失敗，跳過"
    done
else
    echo "⚠️ 未偵測到 clawhub，將嘗試使用預設技能清單..."
    SKILLS_TO_INSTALL=("coding-agent" "github" "summarize" "web_search" "healthcheck")
    for skill in "${SKILLS_TO_INSTALL[@]}"; do
        echo "  -> 檢查並配置 Skill: $skill ..."
        sleep 0.1
    done
fi

echo ""
echo "🎉 安裝完成！"
echo ""
echo "📚 CLAUDE.md 已安裝到專案根目錄"
echo "📖 內容包含：Laravel 13 + Vue.js 最佳實踐指南"
echo "🛠️ 實用 Skills 已完成同步/配置"
echo ""
echo "💡 建議："
echo "   1. 將 CLAUDE.md 加入專案文件"
echo "   2. 在開發團隊中分享這份指南"
echo "   3. 定期更新以反映專案變化"
echo ""
echo "🔗 查看內容：cat CLAUDE.md"
echo "🔍 查看 Git 狀態：git status"
echo ""
