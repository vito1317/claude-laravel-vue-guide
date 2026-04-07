# 📊 Hongzhun Data Model Specification

This document serves as the "Source of Truth" for the database schema used in the Hongzhun project.

## 1. Entity: Molds (`molds` table)
Represents the core asset being maintained.

| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK, AI | Internal identifier |
| `mold_code` | VARCHAR(50) | UNIQUE, NOT NULL | Business identifier (e.g., M-2024-001) |
| `name` | VARCHAR(255) | NOT NULL | Human-readable name |
| `customer_code`| VARCHAR(10) | NOT NULL | Reference to customer |
| `mold_type` | ENUM | 'casting', 'stamping', 'other' | Classification |
| `status` | ENUM | 'active', 'idle', 'scrap', 'repair'| Current lifecycle state |
| `last_maintained_at`| TIMESTAMP | NULLABLE | Last successful maintenance date |

## 2. Entity: Users (`users` table)
Handles authentication and RBAC.

| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK, AI | Internal identifier |
| `employee_id` | VARCHAR(20) | UNIQUE, NOT NULL | Employee ID (Login Username) |
| `name_cn` | VARCHAR(100) | NOT NULL | Full name in Chinese |
| `role` | VARCHAR(20) | NOT NULL | Role: `admin`, `manager`, `technician`, `operator`, `qc` |
| `department` | VARCHAR(50) | NOT NULL | Department name |

## 3. Entity: Repairs (`repairs` table)
Tracks breakdown and repair events.

| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK, AI | Internal identifier |
| `mold_id` | BIGINT | FK (molds.id) | Linked mold |
| `reporter_id` | BIGINT | FK (users.id) | Person who reported the issue |
| `issue_desc` | TEXT | NOT NULL | Description of the fault |
| `status` | VARCHAR(20) | DEFAULT 'requested' | State in the Repair Workflow |
| `repair_content`| TEXT | NULLABLE | Details entered by Technician |
| `resolved_at` | TIMESTAMP | NULLABLE | Timestamp of resolution |

## 4. Entity: Maintenance Plans (`maintenance_plans` table)
Schedules preventive maintenance.

| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK, AI | Internal identifier |
| `mold_id` | BIGINT | FK (molds.id) | Target mold |
| `plan_type` | ENUM | 'daily', 'weekly', 'monthly', 'yearly'| Frequency |
| `next_due_date` | DATE | NOT NULL | Next scheduled date |
| `status` | ENUM | 'planned', 'assigned', 'completed' | Plan status |

## 5. Key Relationships (ERD Logic)
- **One-to-Many**: `User` $\rightarrow$ `Repairs` (as Reporter)
- **One-to-Many**: `User` $\rightarrow$ `Repairs` (as Technician)
- **One-to-Many**: `Mold` $\rightarrow$ `Repairs`
- **One-to-Many**: `Mold` $\rightarrow$ `MaintenancePlans`
- **One-to-Many**: `Mold` $\rightarrow$ `MaintenanceLogs` (for history)
