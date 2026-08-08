
# 🔄 Day 9 — Data Flow Architecture

<p align="center">
  <strong>Student Placement Portal</strong><br>
  <em>Tracing data movement between the LWC interface, Apex layer, services, and Salesforce</em>
</p>

<p align="center">

![Salesforce](https://img.shields.io/badge/Salesforce-LWC-00A1E0?style=for-the-badge\&logo=salesforce)
![Apex](https://img.shields.io/badge/Apex-Backend-1798C1?style=for-the-badge)
![Architecture](https://img.shields.io/badge/Architecture-Layered-6C63FF?style=for-the-badge)
![Status](https://img.shields.io/badge/Day%209-Completed-2EA44F?style=for-the-badge)

</p>

---

## 📌 Architecture Overview

The Student Placement Portal uses a **layered data-flow architecture** in which the Lightning Web Components manage the user interface, while Apex and service logic handle communication with Salesforce data.

The separation between the frontend and backend makes the application easier to maintain, validate, and extend.

The overall interaction can be viewed as two primary paths:

* **Read Flow** — retrieves information from Salesforce and displays it in the LWC.
* **Write Flow** — sends user actions from the LWC to Apex and ultimately updates Salesforce.

---

# 🧭 Data Flow at a Glance

```text
                    ┌─────────────────────┐
                    │     Salesforce      │
                    │   Data / Objects    │
                    └──────────┬──────────┘
                               │
                         Read / Retrieve
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Apex / Service    │
                    │       Layer         │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │        LWC          │
                    │    JavaScript       │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │  Component State    │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   HTML Template     │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │    User Interface   │
                    └─────────────────────┘
```

---

# 🔵 1. Read Data Flow

The read flow is responsible for retrieving Salesforce records and presenting them to the user.

```text
Salesforce
    ↓
Apex / Wire Service
    ↓
LWC JavaScript
    ↓
Component State
    ↓
HTML Template
    ↓
User Interface
```

### How It Works

**Salesforce**

Stores the placement portal data such as students, jobs, applications, and other related records.

**Apex / Wire Service**

Retrieves the required records from Salesforce and makes the data available to the Lightning Web Component.

**LWC JavaScript**

Receives the returned data and processes it according to the component's requirements.

**Component State**

The processed information is stored in JavaScript properties that represent the current state of the component.

**HTML Template**

The template uses the component state to dynamically render the required information.

**User Interface**

The final data is displayed to the user through tables, cards, forms, lists, or other UI elements.

---

# 🟢 2. User Interaction Flow

The user interface can also trigger changes within the component.

```text
User Interaction
       ↓
HTML Template
       ↓
LWC Event Handler
       ↓
Component State
       ↓
UI Update
```

For example, when a user selects a placement opportunity, clicks an action button, or changes a form value, the corresponding event is handled by the LWC JavaScript.

The component then updates its state, causing the interface to reflect the latest information.

---

# 🟠 3. Write Data Flow

When the user performs an operation that modifies Salesforce data, the request travels from the frontend toward the backend.

```text
User Action
    ↓
LWC HTML
    ↓
LWC JavaScript
    ↓
Apex Method
    ↓
Business Validation
    ↓
Salesforce Database
    ↓
Response
    ↓
LWC
    ↓
Updated UI
```

### Example

When a student submits a placement application:

1. The user selects a job.
2. The LWC collects the required information.
3. JavaScript invokes the appropriate Apex method.
4. Apex performs the required business validations.
5. Salesforce creates or updates the required record.
6. Apex returns the result to the LWC.
7. The component processes the response.
8. The application data is refreshed.
9. The updated information appears in the interface.

---

# 🔁 4. Complete Request-Response Cycle

The complete architecture can be represented as:

```text
                  USER
                   │
                   ▼
            ┌─────────────┐
            │     LWC     │
            │ HTML + JS   │
            └──────┬──────┘
                   │
          Request / User Action
                   │
                   ▼
            ┌─────────────┐
            │ Apex Layer  │
            │  Services   │
            └──────┬──────┘
                   │
          Business Processing
                   │
                   ▼
            ┌─────────────┐
            │ Salesforce  │
            │  Database   │
            └──────┬──────┘
                   │
             Data / Response
                   │
                   ▼
            ┌─────────────┐
            │     LWC     │
            │ State Update│
            └──────┬──────┘
                   │
                   ▼
            ┌─────────────┐
            │     UI      │
            └─────────────┘
```

---

# 🧩 5. Role of Each Layer

| Layer                   | Responsibility                                    |
| ----------------------- | ------------------------------------------------- |
| **HTML Template**       | Displays data and captures user interactions      |
| **LWC JavaScript**      | Controls component behavior and state             |
| **Apex / Services**     | Handles server-side processing and business logic |
| **Salesforce Database** | Stores and retrieves application data             |
| **Response Layer**      | Returns processing results to the LWC             |
| **UI State**            | Reflects the latest application data              |

---

# 🎯 Why This Architecture Matters

This layered approach keeps different responsibilities separated.

### Better Maintainability

UI logic and backend business logic remain independent, making changes easier to manage.

### Centralized Business Rules

Important validations can be handled within Apex instead of relying only on frontend checks.

### Reliable Data Processing

Salesforce remains the central source of truth for placement and application records.

### Responsive User Experience

Once the component receives updated data, its state and template can automatically reflect the latest information.

### Easier Debugging

Because data moves through defined layers, issues can be traced from the UI to JavaScript, Apex, and finally Salesforce.

---

# 🚀 Final Architecture

The Student Placement Portal follows a clear **request → processing → response → UI update** pattern:

```text
Salesforce
    ↕
Apex / Services
    ↕
LWC JavaScript
    ↕
Component State
    ↕
HTML Template
    ↕
User Interface
```

The architecture ensures that Salesforce remains the central data layer while LWC provides the interactive frontend and Apex manages server-side processing and business rules.

This creates a structured and scalable foundation for features such as **job listings, student management, placement applications, eligibility validation, and application tracking**.
