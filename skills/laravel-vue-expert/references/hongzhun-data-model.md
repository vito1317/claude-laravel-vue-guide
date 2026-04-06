# 鴻準專案：核心資料模型設計指南

本文件定義了專案中關鍵實體的欄位與關聯規範。

## 1. 模具主檔 (Mold Master)
- **關鍵欄位**:
  -  (String): 模具編號 (唯一識別碼)
  -  (String): 模具品名 (支援多語系)
  -  (String): 客戶代碼 (2位字母)
  -  (Enum): 壓鑄模 / 沖模 / 其他
  -  (Enum): Active / Idle / Scrap / Under Repair
- **關聯**: 
  - 一對多 $\rightarrow$ 模具保養計畫
  - 一對多 $\rightarrow$ 模具維修單

## 2. 用戶主檔 (User Master)
- **關鍵欄位**:
  -  (String): 工號 (登入帳號)
  -  (String): 中文姓名
  -  (String): 英文姓名
  -  (Enum): 權限主管 / 制工 / 產工 / 品工 / 品管 / 模修
  -  (Enum): 一般操作員 / 維修人員 / 部門主管 / 管理員

## 3. 保養計畫 (Maintenance Plan)
- **關鍵欄位**:
  -  (String): 計畫編號
  -  (Enum): Level 1 / Level 2 / Level 3
  -  (String): 週期 (日/週/月/半年/年)
  -  (String): 版次 (A, B, C...)
