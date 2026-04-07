# 🔄 Hongzhun Business Workflow & State Machine

This document defines the legal transitions for the two primary business processes in the system.

## 1. Maintenance Workflow (Preventive)
*Goal: Ensure assets are serviced before failure.*

### State Transitions
| From State | Event/Action | To State | Required Role |
| :--- | :--- | :--- | :--- |
| (None) | System/Admin creates plan | **Planned** | Admin/Manager |
| **Planned** | Assign personnel | **Assigned** | Admin/Manager |
| **Assigned** | Technician starts task | **In Progress** | Technician |
| **In Progress** | Technician submits form | **Pending Approval**| Technician |
| **Pending Approval**| Manager approves | **Completed** | Manager |
| **Pending Approval**| Manager rejects | **In Progress** | Manager |

### Business Rules
- **Rule M-1**: A plan cannot be `Assigned` without a `technician_id`.
- **Rule M-2**: `In Progress` tasks must include a timestamp of start and end.
- **Rule M-3**: Transition to `Completed` requires a digital signature/approval from the `Manager`.

---

## 2. Repair Workflow (Reactive)
*Goal: Resolve unexpected equipment failures.*

### State Transitions
| From State | Event/Action | To State | Required Role |
| :--- | :--- | :--- | :--- |
| (None) | Operator submits request | **Requested** | Operator |
| **Requested** | Manager approves request | **Under Review** | Manager |
| **Under Review** | Technician accepts/starts | **Repairing** | Technician |
| **Repairing** | Technician submits resolution| **Pending Satisfaction**| Technician |
| **Pending Satisfaction**| Operator submits feedback | **Pending Archiving**| Operator |
| **Pending Archiving**| Manager finalizes | **Closed** | Manager |

### Business Rules
- **Rule R-1**: A repair request MUST be linked to an active `mold_id`.
- **Rule R-2**: Transition to `Repairing` requires an inspection of the fault by a `Technician`.
- **Rule R-3**: The workflow cannot reach `Closed` until the `satisfaction_score` (1-5) is recorded.

## 3. Role-to-Action Mapping Matrix

| Action | Operator | Technician | Manager | Admin |
| :--- | :---: | :---: | :---: | :---: |
| Create Maintenance Plan | ❌ | ❌ | ✅ | ✅ |
| Execute Daily Maintenance | ✅ | ✅ | ❌ | ❌ |
| Create Repair Request | ✅ | ❌ | ❌ | ❌ |
| Approve Repair Request | ❌ | ❌ | ✅ | ✅ |
| Complete Repair Task | ❌ | ✅ | ❌ | ❌ |
| Full System Config | ❌ | ❌ | ❌ | ✅ |
