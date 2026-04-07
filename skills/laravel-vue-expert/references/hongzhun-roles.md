# 🛡️ Hongzhun RBAC & Permission Specification

This document defines the Role-Based Access Control (RBAC) model for the Hongzhun project.

## 1. Role Definitions

| Role Name | Technical Identifier | Description |
| :--- | :--- | :--- |
| **Administrator** | `admin` | Full system access. Manages users, settings, and global logs. |
| **Manager** | `manager` | Departmental authority. Approves plans, repairs, and manages personnel assignments. |
| **Technician** | `technician` | Field execution. Performs maintenance and repairs. Records technical data. |
| **Operator** | `operator` | Daily user. Performs routine checks, submits repair requests, and provides feedback. |
| **QC** | `qc` | Quality control. Verifies repair quality and inspects completed maintenance. |

## 2. Permission Matrix (Action-to-Role Mapping)

This matrix defines which roles can perform specific actions. Use this to implement Laravel Policies.

| Action | Admin | Manager | Technician | Operator | QC |
| :--- | :---: | :---: | :---: | :---: | :---: |
| `create-maintenance-plan` | ✅ | ✅ | ❌ | ❌ | ❌ |
| `assign-personnel` | ✅ | ✅ | ❌ | ❌ | ❌ |
| `execute-maintenance` | ✅ | ❌ | ✅ | ✅ | ❌ |
| `approve-maintenance` | ✅ | ✅ | ❌ | ❌ | ❌ |
| `create-repair-request` | ✅ | ❌ | ❌ | ✅ | ❌ |
| `approve-repair-request` | ✅ | ✅ | ❌ | ❌ | ❌ |
| `execute-repair` | ✅ | ❌ | ✅ | ❌ | ❌ |
| `verify-repair-quality` | ✅ | ❌ | ❌ | ❌ | ✅ |
| `manage-users` | ✅ | ❌ | ❌ | ❌ | ❌ |

## 3. Implementation Strategy (Laravel)

### A. Middleware Approach
Use a custom `RoleMiddleware` to protect routes based on the user's role stored in the `users.role` column.

\`\`\`php
// Example: Route protection
Route::middleware(['auth:sanctum', 'role:manager,admin'])->group(function () {
    Route::post('/maintenance/plans', [MaintenancePlanController::class, 'store']);
});
\`\`\`

### B. Policy Approach (Recommended)
For fine-grained control (e.g., "Can this user approve *this specific* repair?"), always use Laravel Policies.

\`\`\`php
// Example: RepairPolicy.php
public function approve(User \$user, Repair \$repair)
{
    // Only managers or admins can approve repairs
    return in_array(\$user->role, ['manager', 'admin']);
}
\`\`\`

### C. Database Design for RBAC
The `users` table contains a `role` column. For more complex systems, consider a `roles` and `permissions` table, but for the current Hongzhun scope, the `role` column is sufficient.
