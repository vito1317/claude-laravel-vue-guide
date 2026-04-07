---
name: laravel-vue-expert
description: "Advanced development engine for Laravel 13 and Vue.js, specifically engineered for the Hongzhun Mold Maintenance Project. This skill provides deep domain expertise, enforcing strict adherence to Hongzhun-specific API standards, database schemas, business workflows, and UI/UX guidelines."
---

# 🛠️ Laravel 13 + Vue.js Expert (Hongzhun Project Engine)

This is not just a reference skill; it is a **Development Engine**. It provides the reasoning logic, standard operating procedures (SOPs), and deep domain knowledge required to build production-ready code for the Hongzhun Mold Maintenance Project.

## 🧠 Reasoning & Decision Logic (The "Brain")

When a user provides a task, this skill must follow this cognitive process before generating any output:

1.  **Context Identification**: 
    - Is the task **Backend (Laravel)**, **Frontend (Vue.js)**, or **Full-Stack**?
    - Which business domain does it belong to? (Maintenance, Repair, User Management, or Inventory?)

2.  **Requirement Mapping**:
    - **If Backend**: Consult `references/hongzhun-api-spec.md` (for response format) AND `references/hongzhun-data-model.md` (for schema/types).
    - **If Frontend**: Consult `references/hongzhun-frontend-standards.md` (for iPad UX) AND `references/vue_standards.md` (for Composition API patterns).
    - **If Workflow-related**: Consult `references/hongzhun-workflow.md` (for state machine logic) AND `references/hongzhun-roles.md` (for permission logic).

3.  **Constraint Validation**:
    - Does the proposed solution violate the Hongzhun Service-Repository pattern?
    - Does the API response include `code`, `message`, and `data`?
    - Is the Vue component using `<script setup>`?

## 📋 Standard Operating Procedures (SOPs)

### SOP-01: Creating a New API Resource (Backend)
**Goal**: Implement a new backend endpoint that adheres to Hongzhun standards.
1.  **Schema Definition**: Review `references/hongzhun-data-model.md` to identify required fields and types.
2.  **Model & Migration**: Create/Update the Eloquent model and migration with appropriate constraints.
3.  **Business Logic**: Implement the logic within a `Service` class (to keep Controllers thin).
4.  **Data Transformation**: Create a `Resource` class (e.g., `MoldResource`) following the patterns in `references/hongzhun-api-spec.md`.
5.  **Controller Implementation**:
    - Use `FormRequest` for validation.
    - Return `JsonResponse` with the standard structure.
6.  **Routing**: Register the route in `routes/api.php`.

### SOP-02: Creating a Vue.js Component (Frontend)
**Goal**: Build a reusable, touch-optimized component for the iPad interface.
1.  **Component Type**: Determine if it's a `Base` component (stateless) or a `Feature` component (stateful).
2.  **Structure**: Use `<script setup>` and the Composition API.
3.  **UX/UI Audit**: Ensure compliance with `references/hongzhun-frontend-standards.md`:
    - Minimum touch target: 48px.
    - Use appropriate spacing and high-contrast colors.
4.  **State Management**: Use `Pinia` for shared state or `ref`/`reactive` for local state.
5.  **API Integration**: Use the standardized Axios instance for data fetching.

### SOP-03: Implementing a Business Workflow
**Goal**: Implement a multi-step process (e.g., Repair Request $\rightarrow$ Approval).
1.  **State Machine Analysis**: Refer to `references/hongzhun-workflow.md` to identify the current state and valid next states.
2.  **Permission Check**: Refer to `references/hongzhun-roles.md` to ensure the user has the correct role for the requested action.
3.  **Transition Logic**: Implement the state change in the Service layer, ensuring all side effects (e.g., notifications, logs) are triggered.

## 📚 Reference Knowledge Base

| Category | File Path | Purpose |
| :--- | :--- | :--- |
| **API Standards** | `references/hongzhun-api-spec.md` | Response structure, error mapping, and Resource patterns. |
| **Database Schema** | `references/hongzhun-data-model.md` | Entity definitions, field types, and relations. |
| **Workflow Logic** | `references/hongzhun-workflow.md` | State machine transitions and business rules. |
| **Access Control** | `references/hongzhun-roles.md` | RBAC matrix and Laravel Policy guidelines. |
| **Frontend UX** | `references/hongzhun-frontend-standards.md` | iPad-specific touch targets and UI guidelines. |
| **Architecture** | `references/laravel_best_practices.md` | Service-Repository and Clean Code patterns. |
| **Vue Standards** | `references/vue_standards.md` | Composition API and component architecture. |

## 🛠️ Implementation Templates

*When generating code, always lean towards these structures:*

### [Template] Standard API Response (Laravel)
\`\`\`php
return response()->json([
    'code' => 200,
    'message' => 'Success',
    'data' => \$transformedData
], 200);
\`\`\`

### [Template] Standard Vue Component (Composition API)
\`\`\`vue
<script setup>
import { ref, onMounted } from 'vue';
// Props, Emits, and Logic here
</script>

<template>
  <div class="hongzhun-component">
    <!-- UI Content -->
  </div>
</template>
\`\`\`
