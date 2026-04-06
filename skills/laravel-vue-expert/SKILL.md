---
name: laravel-vue-expert
description: "Comprehensive guidance for Laravel 13 and Vue.js development following Hongzhun project standards. Use when Codex needs to: (1) Create new Laravel controllers, models, or migrations, (2) Design Vue.js components using Composition API, (3) Integrate Laravel backend with Vue frontend, (4) Implement modern API patterns, or (5) Apply industry-standard coding patterns for Laravel/Vue projects."
---

# Laravel 13 + Vue.js Expert (Hongzhun Project Edition)

This skill provides specialized knowledge and procedural guidance for building robust, scalable applications using the Laravel 13 and Vue.js stack, specifically tailored for the Hongzhun Mold Maintenance Project.

## Core Development Patterns

### Backend: Laravel 13
When working with the backend, adhere to these standards:
- **Architecture**: Use a Service-Repository pattern for complex business logic to keep Controllers thin.
- **API Design**: Always return `JsonResponse`. Use API Resources for transforming models to JSON.
- **Validation**: Use Form Request classes for all incoming request validation.
- **Migrations**: Always write descriptive migration files.

### Frontend: Vue.js
When working with the frontend, adhere to these standards:
- **Composition API**: Always use `<script setup>` and the Composition API.
- **Component Design**: Keep components small and single-purpose. Use props for data down and emits for events up.
- **State Management**: Prefer Pinia for global state, but use local `ref`/`reactive` for component-specific state.
- **Styling**: Follow the project's CSS framework (e.g., Tailwind CSS) consistently.

## Integration Guide

### Connecting Backend to Frontend
- **Axios/Fetch**: Use a centralized Axios instance configured with the base URL and CSRF token handling.
- **Data Flow**: Fetch data in `onMounted` or via TanStack Query (if available) and pass it to reactive variables.

## Reference Material

For detailed implementation details, refer to the following:
- **API Patterns**: See [references/hongzhun-api-spec.md](references/hongzhun-api-spec.md) for standard response structures and error handling.
- **Laravel Best Practices**: See [references/laravel_best_practices.md](references/laravel_best_practices.md) (to be created) for detailed architectural guidance.
- **Vue Component Standards**: See [references/vue_standards.md](references/vue_standards.md) (to be created) for component structure and naming conventions.
- **Hongzhun Workflow**: See [references/hongzhun-workflow.md](references/hongzhun-workflow.md) for business logic and state transitions.
- **Hongzhun Roles**: See [references/hongzhun-roles.md](references/hongzhun-roles.md) for permission matrices.
- **Hongzhun Data Model**: See [references/hongzhun-data-model.md](references/hongzhun-data-model.md) for schema definitions.
- **Hongzhun Frontend Standards**: See [references/hongzhun-frontend-standards.md](references/hongzhun-frontend-standards.md) for iPad UI/UX guidelines.

## Example Workflows

### 1. Creating a New Resource (CRUD)
1. Generate Migration: `php artisan make:migration create_xxx_table`
2. Generate Model: `php artisan make:model Xxx`
3. Generate Controller: `php artisan make:controller XxxController --api`
4. Create API Resource: `php artisan make:resource XxxResource`
5. Generate Vue Component: `npm run generate:component Xxx` (if using a generator)
6. Implement logic in Service/Repository.
7. Register routes in `routes/api.php`.
