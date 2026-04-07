# 鴻準專案：核心資料模型設計指南 (Data Model Schema)

本文件定義了系統中關鍵實體的資料庫欄位、型態與關聯規則。

## 1. 模具主檔 (molds)
用於存放所有模具的基礎資訊。

| 欄位名稱 | 資料型態 | 限制 (Constraints) | 說明 |
| :--- | :--- | :--- | :--- |
| uid=1000(intellitrust) gid=1000(intellitrust) groups=1000(intellitrust),4(adm),27(sudo),29(audio),30(dip),46(plugdev),100(users),122(lpadmin),988(docker) | BIGINT | Primary Key, Auto Increment | 內部唯一識別碼 |
|  | VARCHAR(50) | Unique, Not Null | **業務編號 (如: MOLD-2024-001)** |
|  | VARCHAR(255) | Not Null | 模具品名 |
| | VARCHAR(10) | Not Null | 客戶代碼 (2位字母) |
|  | ENUM | 'casting', 'stamping', 'other' | 模具類型 |
|  | ENUM | 'active', 'idle', 'scrap', 'repair'| 目前狀態 |
|  | TIMESTAMP | Not Null | 建立時間 |

## 2. 用戶主檔 (users)
用於身份驗證與權限控管。

| 欄位名稱 | 資料型態 | 限制 (Constraints) | 說明 |
| :--- | :--- | :--- | :--- |
| uid=1000(intellitrust) gid=1000(intellitrust) groups=1000(intellitrust),4(adm),27(sudo),29(audio),30(dip),46(plugdev),100(users),122(lpadmin),988(docker) | BIGINT | Primary Key | 內部唯一識別碼 |
|  | VARCHAR(20) | Unique, Not Null | **工號 (登入帳號)** |
|  | VARCHAR(100) | Not Null | 中文姓名 |
|  | VARCHAR(20) | Not Null | 角色 (admin, manager, technician, operator, qc) |
|  | VARCHAR(50) | Not Null | 所屬部門 |

## 3. 維修單 (repairs)
用於紀錄設備故障與維修過程。

| 欄位名稱 | 資料型態 | 限制 (Constraints) | 說明 |
| :--- | :--- | :--- | :--- |
| uid=1000(intellitrust) gid=1000(intellitrust) groups=1000(intellitrust),4(adm),27(sudo),29(audio),30(dip),46(plugdev),100(users),122(lpadmin),988(docker) | BIGINT | Primary Key | 內部唯一識別碼 |
|  | BIGINT | Foreign Key (molds.id) | 關聯模具 |
|  | BIGINT | Foreign Key (users.id) | 報修人員 |
| | TEXT | Not Null | 故障描述 |
|  | VARCHAR(20) | Default: 'requested' | 流程狀態 |
|  | TEXT | Nullable | 維修完成後填寫內容 |

## 4. 關聯關係總結 (Relationships)
- **Mold $\rightarrow$ MaintenancePlans**: One-to-Many
- **Mold $\rightarrow$ Repairs**: One-to-Many
- **User $\rightarrow$ Repairs (as Reporter)**: One-to-Many
- **User $\rightarrow$ Repairs (as Technician)**: One-to-Many
