# 鴻準專案：角色與權限矩陣 (RBAC Specification)

本文件定義了系統的權限模型，用於開發 Laravel Middleware 與 Policy 時的邏輯判定。

## 1. 角色定義與權限範圍

| 角色 (Role) | 核心權限描述 | 實作建議 (Laravel Policy) |
| :--- | :--- | :--- |
| **Admin (管理員)** | 擁有系統最高權限，包含所有設定與用戶管理。 |  |
| **Manager (部門主管)** | 負責計畫審核、報表查看、人員排配與所有流程的最終簽核。 | ,  |
| **Technician (維修人員)** | 負責執行月/半年/年保養與維修作業，可填寫維修紀錄。 | ,  |
| **Operator (一般操作員)** | 負責日常/週保養、設備叫修申請與填寫滿意度。 | ,  |
| **QC (品管)** | 負責驗收維修結果，確保模具品質符合標準。 |  |

## 2. 權限實作指南 (Implementation Guide)

### Laravel Middleware 策略
所有 API 請求必須透過  驗證，並根據  欄位進行權限檢查。

### 範例：維修單審核權限 (RepairPolicy.php)
```php
public function approve(User , RepairRequest $request)
{
    // 只有部門主管或現場主管可以審核
    return in_array(->role, ['manager', 'supervisor']);
}
```

### 範例：保養計畫建立權限
```php
public function create(User )
{
    // 只有管理員或部門主管可以建立新的保養計畫
    return in_array(->role, ['admin', 'manager']);
}
```
