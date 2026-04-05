# CLAUDE.md 安裝說明

> 📚 **Laravel 13 + Vue.js 最佳實踐指南安裝說明**

---

## ✅ 已完成的操作

1. ✅ 建立 `CLAUDE.md` 文件（752 行）
2. ✅ 初始化 Git 倉庫
3. ✅ 設定 Git 使用者資訊
4. ✅ 新增並提交檔案
5. ✅ 生成安裝腳本

---

## 📦 快速安裝

### 方式 1：使用自動安裝腳本（推薦）

```bash
# 1. 進入專案目錄
cd /home/intellitrust/.openclaw/workspace

# 2. 執行安裝腳本
./install-claude-md.sh
```

### 方式 2：手動安裝

```bash
# 1. 初始化 Git（如果還沒有）
git init

# 2. 設定使用者資訊
git config user.name "vito1317"
git config user.email "service@vito1317.com"

# 3. 複製 CLAUDE.md 到專案
cp CLAUDE.md ./

# 4. 新增並提交
git add CLAUDE.md
git commit -m "docs(claude): 新增 Laravel 13 + Vue.js 最佳實踐指南"

# 5. 設定遠端並推送
git remote add origin <your-repo-url>
git push -u origin main
```

---

## 📚 CLAUDE.md 內容大綱

### 核心章節

1. **核心原則**
   - Code First, Comments Later
   - DRY Principle
   - YAGNI
   - Fail Fast

2. **技術棧規範**
   - Laravel 13 + PHP 8.3+
   - Vue.js 3 + TypeScript
   - Inertia.js 1.0+
   - Vite 5.0+
   - Tailwind CSS 3.4+

3. **專案結構最佳實踐**
   - 完整的目錄結構
   - 各層級職責說明

4. **程式碼規範**
   - Controller 最佳實踐
   - Vue.js Component 最佳實踐
   - Service Layer 最佳實踐
   - Repository Pattern

5. **開發工作流**
   - Git Flow 規範
   - Commit Message 格式

6. **安全性最佳實踐**
   - API 安全
   - 輸入驗證
   - SQL 注入防護

7. **測試最佳實踐**
   - Feature Test
   - Unit Test

8. **性能優化**
   - Eager Loading
   - Query Optimization
   - Cache Strategy

9. **監控與日誌**
   - Structured Logging
   - Error Tracking

10. **UI/UX 指南**
    - Inertia.js 頁面結構
    - Tailwind CSS 使用

11. **部署與 CI/CD**
    - Docker Compose 設定
    - GitHub Actions 範例

---

## 🔧 使用方式

### 在專案中使用

1. **將 CLAUDE.md 放入專案根目錄**
   ```bash
   cp CLAUDE.md /path/to/your/project/
   ```

2. **參考內容進行開發**
   - 遵循程式碼規範
   - 使用最佳實踐
   - 參考範例程式碼

3. **定期更新**
   - 根據專案需求調整
   - 記錄專案特有的規範
   - 與團隊成員分享

### 與 Claude 合作

當你在專案中使用 Claude 進行開發時：

1. **參考 CLAUDE.md 中的規範**
2. **要求 Claude 遵循最佳實踐**
3. **在提示詞中引用相關章節**

範例提示詞：
```
根據 CLAUDE.md 中的 Controller 最佳實踐，幫我建立一個 WAF 管理 API 控制器。
使用依賴注入、Service 層和 Form Request 驗證。
```

---

## 📖 相關資源

### 官方文件
- [Laravel 13 Documentation](https://laravel.com/docs/13.x)
- [Vue.js 3 Documentation](https://vuejs.org/)
- [Inertia.js Documentation](https://inertiajs.com/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)

### 專案文件
- `CLAUDE.md` - 開發指南
- `README.md` - 專案說明
- `INSTALL.md` - 安裝說明

---

## 🚀 下一步

1. **閱讀 CLAUDE.md**
   ```bash
   cat CLAUDE.md
   ```

2. **在專案中應用**
   - 遵循程式碼規範
   - 使用最佳實踐

3. **團隊分享**
   - 與開發團隊分享這份指南
   - 定期更新以反映專案變化

4. **持續改進**
   - 根據實際經驗調整
   - 記錄新的最佳實踐

---

## 📞 需要協助？

如果有任何問題或建議，請：
1. 查看 CLAUDE.md 中的相關章節
2. 參考官方文件
3. 聯繫專案維護者

---

**文件位置**: `/home/intellitrust/.openclaw/workspace/CLAUDE.md`  
**安裝腳本**: `/home/intellitrust/.openclaw/workspace/install-claude-md.sh`  
**最後更新**: 2026-04-06  
**版本**: v1.0