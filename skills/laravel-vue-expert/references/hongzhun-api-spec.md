# 📜 Hongzhun API Specification (v1.0)

This document defines the mandatory structure for all API communications within the Hongzhun project.

## 1. Global Response Protocol

All API endpoints **MUST** return a JSON object with a consistent top-level structure.

### 1.1 Success Response (HTTP 200/201)
Used for successful GET, POST, PUT, or DELETE operations.

**Structure:**
- `code` (Integer): A custom application-level status code (e.g., 200 for success).
- `message` (String): A human-readable description of the result.
- `data` (Mixed): The payload. For collections, this must be an array or an object containing a list.

**Example (Single Resource):**
\`\`\`json
{
  "code": 200,
  "message": "Mold retrieved successfully",
  "data": {
    "id": 5,
    "mold_code": "M-001",
    "status": "active"
  }
}
\`\`\`

**Example (Collection):**
\`\`\`json
{
  "code": 200,
  "message": "Molds listed successfully",
  "data": [
    { "id": 1, "mold_code": "M-001" },
    { "id": 2, "mold_code": "M-002" }
  ]
}
\`\`\`

### 1.2 Error Response (HTTP 4xx/5xx)
Used for validation errors, authorization failures, or server errors.

**Structure:**
- `code` (Integer): The HTTP status code or a specific error code.
- `message` (String): A clear, actionable error message.
- `errors` (Object, Optional): A key-value map of field-specific validation errors.

**Example (Validation Error - HTTP 422):**
\`\`\`json
{
  "code": 422,
  "message": "The given data was invalid.",
  "errors": {
    "mold_code": ["The mold code field is required."],
    "quantity": ["The quantity must be a number."]
  }
}
\`\`\`

**Example (Authorization Error - HTTP 403):**
\`\`\`json
{
  "code": 403,
  "message": "You do not have permission to perform this action."
}
\`\`\`

## 2. Data Transformation Rules

To prevent leaking database internals, **never** return raw Eloquent models. Always use **Laravel API Resources**.

### 2.1 Standard Field Mapping
| Database Field | API Key (CamelCase/SnakeCase) | Type |
| :--- | :--- | :--- |
| `id` | `id` | Integer |
| `mold_code` | `moldCode` | String |
| `created_at` | `createdAt` | ISO 8601 String |

## 3. HTTP Method Usage

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/molds` | List all molds (supports pagination) |
| `POST` | `/api/v1/molds` | Create a new mold |
| `GET` | `/api/v1/molds/{id}` | Retrieve a specific mold |
| `PUT` | `/api/v1/molds/{id}` | Full update of a mold |
| `PATCH` | `/api/v1/molds/{id}` | Partial update of a mold |
| `DELETE` | `/api/v1/molds/{id}` | Soft delete a mold |
