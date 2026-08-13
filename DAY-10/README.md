# 📚 Chapter 10 — Building Components That Think Together

## 📌 Overview

Chapter 10 focuses on building **connected Lightning Web Components (LWC)** that work together as a complete Salesforce application.

In real-world Salesforce development, applications are rarely made from a single component. Multiple components are responsible for different parts of the user interface, data handling, user interactions, and business processes.

This chapter explains how LWCs can:

* Communicate with each other
* Share data
* Handle user actions
* Work with Lightning Data Service (LDS)
* Communicate with Apex
* Manage UI state
* Handle errors
* Refresh data
* Maintain reusable architecture
* Improve application performance
* Follow Salesforce security practices

The main idea is:

> **Build small, focused components that communicate efficiently and work together as one complete application.**

---

# 🎯 1. Learning Objectives

After completing this chapter, you should be able to:

* Understand component-based architecture in LWC.
* Design components with clear responsibilities.
* Implement parent-to-child communication.
* Implement child-to-parent communication.
* Understand communication between unrelated components.
* Use Lightning Message Service when appropriate.
* Work with Salesforce records using LDS.
* Call Apex methods from LWC.
* Understand when to use LDS and when to use Apex.
* Manage component and application state.
* Handle loading, success, error, and empty states.
* Refresh UI data after record changes.
* Build reusable and maintainable components.
* Apply performance optimization techniques.
* Follow Salesforce security principles.
* Design scalable LWC applications.

---

# 🏗️ 2. Component-Based Architecture

LWC follows a **component-based architecture**, where an application is divided into multiple smaller components.

Instead of creating one large component containing all functionality, responsibilities are distributed across multiple components.

### Example

```text
Account Management Application
│
├── accountSearch
├── accountList
├── accountDetails
├── accountForm
└── accountSummary
```

Each component has a specific responsibility.

For example:

* `accountSearch` → Handles search input.
* `accountList` → Displays account records.
* `accountDetails` → Displays selected account information.
* `accountForm` → Creates or updates accounts.
* `accountSummary` → Displays account-related summary information.

### Benefits

* Better maintainability
* Easier debugging
* Code reusability
* Better testing
* Clear responsibilities
* Improved scalability

---

# 🧩 3. Component Responsibilities

Every component should have a **clear and focused responsibility**.

A component should not try to handle the entire application.

### Example

```text
Parent Component
│
├── Search Component
│      └── Handles search input
│
├── List Component
│      └── Displays records
│
├── Details Component
│      └── Displays selected record
│
└── Form Component
       └── Creates/Updates records
```

### Good Component Design

A good component should:

* Perform a focused task.
* Have clearly defined inputs.
* Produce predictable outputs.
* Avoid unnecessary dependencies.
* Be reusable where appropriate.
* Communicate through standard LWC mechanisms.

### Key Principle

> **One component should have one clear responsibility whenever possible.**

---

# 🔗 4. Component Communication

Components need to communicate when they work together.

For example, a parent may send data to a child, while a child may notify the parent about a user action.

The major communication patterns are:

```text
Parent → Child
       @api

Child → Parent
       Custom Event

Unrelated Components
       Lightning Message Service
```

Communication should be predictable and should avoid unnecessary coupling between components.

---

# 👨‍👩‍👧 5. Parent-to-Child Communication

Parent-to-child communication allows a parent component to pass information to a child component.

LWC commonly uses the `@api` decorator for public properties and methods.

### Example

```javascript
import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api accountName;
}
```

Parent component:

```html
<c-child-component
    account-name={selectedAccountName}>
</c-child-component>
```

The child receives the value from the parent.

### Flow

```text
Parent Component
      │
      │ @api property
      ▼
Child Component
      │
      ▼
Display Data
```

### Use Cases

Parent-to-child communication is useful for:

* Passing selected record information
* Passing configuration values
* Controlling child component behavior
* Sharing display information

---

# 📢 6. Child-to-Parent Communication

A child component can communicate with its parent using **Custom Events**.

The child dispatches an event when an important action occurs.

### Example

```javascript
handleAccountSelection() {
    this.dispatchEvent(
        new CustomEvent('accountselected', {
            detail: this.selectedAccount
        })
    );
}
```

The parent listens for the event:

```html
<c-account-list
    onaccountselected={handleAccountSelected}>
</c-account-list>
```

The parent handles the event:

```javascript
handleAccountSelected(event) {
    this.selectedAccount = event.detail;
}
```

### Communication Flow

```text
Child Component
      │
      │ dispatchEvent()
      ▼
Custom Event
      │
      ▼
Parent Component
      │
      ▼
Update State
      │
      ▼
Update UI
```

### Important Point

Custom events allow the child to communicate without directly controlling the parent component.

---

# 👥 7. Communication Between Sibling Components

Sibling components share the same parent.

```text
          Parent
         /      \
        /        \
    Child A     Child B
```

Child A should generally not directly access Child B.

Instead, communication should pass through the parent.

```text
Child A
   │
   │ Event
   ▼
Parent
   │
   │ Data
   ▼
Child B
```

### Example

```text
Account List
     │
     │ Selected Account
     ▼
Parent Component
     │
     │ Selected Account
     ▼
Account Details
```

This approach keeps components loosely coupled and easier to maintain.

---

# 📡 8. Lightning Message Service

When components are not directly related through a parent-child hierarchy, **Lightning Message Service (LMS)** can be used.

### Architecture

```text
Component A
     │
     ▼
Lightning Message Service
     │
     ├──────────► Component B
     │
     └──────────► Component C
```

LMS allows components to communicate through a shared message channel.

### Useful For

* Communication between unrelated LWCs
* Communication across different parts of an application
* Record selection notifications
* Application-wide refresh events
* Cross-component coordination

### Benefit

Components do not need to know the internal implementation of other components.

---

# 🗄️ 9. Lightning Data Service (LDS)

**Lightning Data Service** provides Salesforce-supported mechanisms for working with records from Lightning components.

LDS can be used for common record operations such as:

* Retrieving records
* Creating records
* Updating records
* Deleting records
* Working with record data
* Managing record-level data synchronization

### Basic Flow

```text
LWC
 │
 ▼
Lightning Data Service
 │
 ▼
Salesforce Records
 │
 ▼
LWC
 │
 ▼
UI
```

### Benefits

* Reduces unnecessary Apex code.
* Provides Salesforce-managed data access.
* Supports efficient record interaction.
* Helps maintain consistent record data.
* Simplifies common CRUD operations.

---

# ⚖️ 10. LDS vs Apex

Choosing between LDS and Apex is an important architectural decision.

## Use LDS When

* Standard record operations are sufficient.
* You need standard record data.
* You need to create, update, or delete records.
* You want to avoid unnecessary custom server-side code.

## Use Apex When

* Complex business logic is required.
* Complex SOQL queries are required.
* Multiple objects need to be processed.
* Server-side calculations are required.
* Custom transactions are required.
* LDS does not provide the required functionality.

### Decision Flow

```text
Need Salesforce Data?
        │
        ▼
Can LDS solve the requirement?
        │
    ┌───┴───┐
   YES      NO
    │        │
    ▼        ▼
   LDS      Apex
```

### Key Principle

> **Use the simplest Salesforce-supported solution that satisfies the requirement.**

---

# ☁️ 11. Apex Integration with LWC

Apex is Salesforce's server-side programming language.

LWC can call Apex when server-side processing is required.

### Application Flow

```text
LWC
 │
 ▼
Apex Method
 │
 ▼
SOQL / Business Logic
 │
 ▼
Salesforce Database
 │
 ▼
Apex Response
 │
 ▼
LWC
 │
 ▼
UI Update
```

### Apex Responsibilities

Apex can handle:

* Complex queries
* Business rules
* Data processing
* Server-side calculations
* Multiple-record operations
* Transactions

### LWC Responsibilities

LWC should primarily handle:

* User interaction
* UI rendering
* Component state
* Client-side behavior
* Component communication

This separation creates a cleaner architecture.

---

# 🏛️ 12. Service Layer and Business Logic

A service layer helps separate reusable data-access and business operations from UI components.

### Architecture

```text
LWC
 │
 ▼
Service Layer
 │
 ▼
Business Logic
 │
 ▼
LDS / Apex
 │
 ▼
Salesforce
```

Instead of placing every operation directly inside the UI component, reusable operations can be separated logically.

### Benefits

* Reusable logic
* Cleaner components
* Easier maintenance
* Easier testing
* Reduced duplication
* Better separation of concerns

---

# 🧠 13. State Management

**State** represents the current condition of a component or application.

Examples include:

```javascript
selectedAccount
searchTerm
records
isLoading
hasError
errorMessage
isModalOpen
```

### Example Flow

```text
Initial State
     │
     ▼
User Action
     │
     ▼
Update State
     │
     ▼
Process Data
     │
     ▼
Update State Again
     │
     ▼
UI Re-renders
```

Good state management ensures that the UI always represents the latest application state.

---

# ⏳ 14. Loading State

Applications should indicate when an operation is in progress.

Example:

```javascript
this.isLoading = true;
```

After the operation:

```javascript
this.isLoading = false;
```

Template:

```html
<template if:true={isLoading}>
    <lightning-spinner
        alternative-text="Loading">
    </lightning-spinner>
</template>
```

### Why Loading State Is Important

It informs users that:

* The request is being processed.
* The application is working.
* They should wait for the result.
* Their action was successfully recognized.

---

# ❌ 15. Error Handling

A production application must handle errors properly.

Common errors include:

* Invalid user input
* Validation errors
* Apex exceptions
* Permission problems
* Network failures
* Missing records
* Server-side failures

### Error Flow

```text
User Action
     │
     ▼
Server Request
     │
 ┌───┴────┐
 │        │
Success  Error
 │        │
 ▼        ▼
UI      Error Message
Update
```

### Good Error Handling Should

* Detect errors.
* Log or process them appropriately.
* Display meaningful feedback.
* Avoid exposing unnecessary technical information.
* Allow users to recover when possible.

---

# 🔄 16. Data Refresh

After a record is created, updated, or deleted, the UI may contain outdated information.

Therefore, the application may need to refresh or synchronize its data.

### Example

```text
User Updates Record
       │
       ▼
Salesforce Record Updated
       │
       ▼
Data Refresh
       │
       ▼
Component State Updated
       │
       ▼
UI Displays Latest Data
```

### Goal

The UI should always represent the latest valid application state.

---

# 🟢 17. Success State

A successful operation should provide an appropriate response to the user.

Example flow:

```text
User Saves Record
       │
       ▼
Salesforce Processing
       │
       ▼
Success
       │
       ▼
Update State
       │
       ▼
Refresh Data
       │
       ▼
Display Updated Record
```

Depending on the application, a success message or toast notification may be displayed.

---

# ⚪ 18. Empty State

Applications should also handle situations where no data is available.

Example:

```text
Search
  │
  ▼
No Records Found
  │
  ▼
Display Empty State
```

Instead of displaying a blank area, the UI should explain what happened.

Example message:

```text
No accounts found for the selected search criteria.
```

Empty states improve usability and make the application easier to understand.

---

# ⚡ 19. Performance Best Practices

Performance is an important part of LWC development.

### Recommended Practices

* Avoid unnecessary server calls.
* Use LDS where appropriate.
* Retrieve only required data.
* Avoid duplicate requests.
* Keep components focused.
* Avoid unnecessary processing.
* Reuse data where appropriate.
* Manage loading states properly.
* Refresh only when required.

### Performance Flow

```text
Efficient Component
       ↓
Fewer Unnecessary Calls
       ↓
Less Processing
       ↓
Faster Response
       ↓
Better User Experience
```

---

# 🔐 20. Security Considerations

Salesforce applications must respect security at every layer.

Important areas include:

* Object permissions
* Field-level security
* Record-level access
* Sharing rules
* User permissions
* Apex security
* Data visibility

### Security Principle

> **Never assume that client-side code alone provides data security.**

Server-side logic must also respect appropriate Salesforce security controls.

---

# ♻️ 21. Reusable Components

Reusable components can be used in multiple areas of an application.

For example:

```html
<c-record-search></c-record-search>
```

A reusable search component may be designed to support different record types or search scenarios.

### Reusable Components Should Have

* Clear inputs
* Predictable outputs
* Minimal dependencies
* Focused functionality
* Configurable behavior
* Well-defined communication

### Benefits

```text
Reusable Component
       ↓
Less Duplicate Code
       ↓
Easier Maintenance
       ↓
Consistent UI
       ↓
Faster Development
```

---

# 🧪 22. Testing Strategy

Testing should cover both individual components and component interactions.

### Component Testing

```text
✓ Component Rendering
✓ User Interaction
✓ Property Updates
✓ Event Handling
```

### Data Testing

```text
✓ LDS Operations
✓ Apex Calls
✓ Correct Data Display
✓ Data Refresh
```

### Error Testing

```text
✓ Server Errors
✓ Validation Errors
✓ Permission Errors
✓ Empty Results
```

### State Testing

```text
✓ Loading State
✓ Success State
✓ Error State
✓ Empty State
```

Testing ensures that components behave correctly under different conditions.

---

# 📁 23. Recommended GitHub Project Structure

A Chapter 10 project can be organized like this:

```text
chapter-10-lwc/
│
├── README.md
│
├── force-app/
│   └── main/
│       └── default/
│           │
│           ├── lwc/
│           │   ├── parentComponent/
│           │   ├── childComponent/
│           │   ├── accountSearch/
│           │   ├── accountList/
│           │   ├── accountDetails/
│           │   └── accountForm/
│           │
│           ├── classes/
│           │   └── AccountController.cls
│           │
│           └── messageChannels/
│
├── docs/
│   ├── architecture.md
│   ├── communication.md
│   ├── lds-vs-apex.md
│   └── testing.md
│
└── examples/
    ├── parent-child/
    ├── custom-events/
    └── apex-integration/
```

This structure keeps application code, documentation, and examples organized.

---

# 💡 24. Real-World Use Cases

The concepts in this chapter can be applied to many Salesforce applications.

## Account Management

```text
Search Account
      ↓
Display Account List
      ↓
Select Account
      ↓
Display Account Details
      ↓
Edit Account
      ↓
Save Record
      ↓
Refresh UI
```

## Contact Management

```text
Select Account
      ↓
Load Contacts
      ↓
Display Contact List
      ↓
Create / Edit Contact
      ↓
Save Contact
      ↓
Refresh Contacts
```

## Opportunity Management

```text
Search Opportunity
      ↓
Select Opportunity
      ↓
Display Details
      ↓
Update Stage
      ↓
Save Changes
      ↓
Refresh UI
```

## Case Management

```text
Search Case
      ↓
Display Cases
      ↓
Select Case
      ↓
Update Status
      ↓
Save Case
      ↓
Refresh Case List
```

---

# 🔁 25. Complete Application Data Flow

The complete application flow can be represented as:

```text
                         USER
                           │
                           ▼
                    User Interaction
                           │
                           ▼
                     Lightning Web
                      Component
                           │
                           ▼
                Component Communication
                           │
             ┌─────────────┴─────────────┐
             ▼                           ▼
        Custom Events                 @api / LMS
             │                           │
             └─────────────┬─────────────┘
                           ▼
                     Data Request
                           │
                    ┌──────┴──────┐
                    ▼             ▼
                   LDS           Apex
                    │             │
                    └──────┬──────┘
                           ▼
                   Business Logic
                           │
                           ▼
                  Salesforce Database
                           │
                           ▼
                       Response
                           │
                           ▼
                    Component State
                           │
                           ▼
                      UI Refresh
                           │
                           ▼
                          USER
```

---

# 🧱 26. Complete Component Architecture

A realistic Salesforce application can follow this architecture:

```text
                    APPLICATION
                         │
                         ▼
                  Parent LWC
                         │
       ┌─────────────────┼─────────────────┐
       │                 │                 │
       ▼                 ▼                 ▼
    Search             List             Details
       │                 │                 │
       └─────────────────┼─────────────────┘
                         │
                         ▼
                  Service / Data Layer
                         │
                  ┌──────┴──────┐
                  ▼             ▼
                 LDS           Apex
                  │             │
                  └──────┬──────┘
                         ▼
                Salesforce Database
                         │
                         ▼
                     Response
                         │
                         ▼
                    State Update
                         │
                         ▼
                     UI Refresh
```

This architecture provides a clear separation between:

* Presentation
* Component communication
* Data access
* Business logic
* Salesforce database
* UI state

---

# 📊 27. Architecture Comparison

## ❌ Poor Architecture

```text
One Large Component
        │
        ├── UI
        ├── Search
        ├── Data Access
        ├── Business Logic
        ├── Error Handling
        ├── State Management
        └── Everything Else
```

Problems:

* Difficult to maintain
* Difficult to test
* Difficult to reuse
* Strong coupling
* Difficult debugging
* Poor scalability

## ✅ Better Architecture

```text
Parent
│
├── Search
├── List
├── Details
└── Form
     │
     ▼
Service / Data Layer
     │
     ├── LDS
     └── Apex
          │
          ▼
      Salesforce
```

Benefits:

* Clear responsibilities
* Better maintainability
* Better reusability
* Easier testing
* Better scalability
* Cleaner code

---

# 📖 28. Important Terminology

| Term                 | Meaning                                                     |
| -------------------- | ----------------------------------------------------------- |
| **LWC**              | Lightning Web Component                                     |
| **LDS**              | Lightning Data Service                                      |
| **Apex**             | Salesforce server-side programming language                 |
| **`@api`**           | Used to expose public properties or methods                 |
| **Custom Event**     | Mechanism commonly used for child-to-parent communication   |
| **LMS**              | Lightning Message Service                                   |
| **State**            | Current condition/data of a component or application        |
| **Service Layer**    | Layer used to organize reusable data or business operations |
| **UI Refresh**       | Updating the interface with the latest application state    |
| **Component**        | Reusable UI building block                                  |
| **Parent Component** | Component responsible for coordinating child components     |
| **Child Component**  | Component contained inside another component                |

---

# 🔑 29. Quick Revision

```text
Parent → Child
        @api

Child → Parent
        Custom Event

Unrelated Components
        Lightning Message Service

Standard Record Operations
        Lightning Data Service

Complex Server-Side Logic
        Apex

Application State
        Data + Loading + Error + UI State

After Record Changes
        Refresh / Synchronize UI

Good Architecture
        Focused + Reusable + Maintainable

Good Performance
        Fewer Unnecessary Calls + Efficient Data Handling

Good Security
        Respect Salesforce Access Controls
```

---

# 🚀 30. End-to-End Example

Consider an Account Management application.

### Step 1 — User Searches

```text
User
 ↓
Account Search Component
```

### Step 2 — Search Component Sends Event

```text
Account Search
 ↓
Custom Event
 ↓
Parent Component
```

### Step 3 — Parent Requests Data

```text
Parent
 ↓
LDS / Apex
```

### Step 4 — Salesforce Returns Data

```text
Salesforce
 ↓
LDS / Apex
 ↓
Parent
```

### Step 5 — State Is Updated

```text
records = returnedAccounts
isLoading = false
```

### Step 6 — List Is Updated

```text
Parent
 ↓
Account List
 ↓
Display Accounts
```

### Step 7 — User Selects Account

```text
Account List
 ↓
Custom Event
 ↓
Parent
```

### Step 8 — Details Component Receives Record

```text
Parent
 ↓
Account Details
 ↓
Display Selected Account
```

### Step 9 — User Updates Record

```text
Account Details / Form
 ↓
LDS / Apex
 ↓
Salesforce
```

### Step 10 — UI Refreshes

```text
Updated Record
 ↓
State Update
 ↓
UI Refresh
 ↓
User Sees Latest Data
```

---

# 🎓 31. Final Learning Outcomes

After completing Chapter 10, you should be able to design an LWC application where multiple components work together as a single application.

You should understand how to:

### 1. Design Component Architecture

Break large applications into smaller, focused components.

### 2. Define Component Responsibilities

Ensure that every component has a clear purpose.

### 3. Implement Communication

Use `@api`, Custom Events, and Lightning Message Service appropriately.

### 4. Work with Salesforce Data

Use LDS for supported standard operations and Apex for complex server-side requirements.

### 5. Separate Responsibilities

Keep UI, communication, data access, and business logic properly organized.

### 6. Manage State

Maintain selected records, loading states, errors, results, and other UI information.

### 7. Handle Errors

Provide meaningful feedback when operations fail.

### 8. Refresh Data

Ensure the UI reflects the latest Salesforce record state.

### 9. Build Reusable Components

Create components that can be reused across different application areas.

### 10. Improve Performance

Reduce unnecessary processing and server calls.

### 11. Apply Security

Respect Salesforce permissions and data-access rules.

### 12. Build Scalable Applications

Use clean architecture so the application can grow without becoming difficult to maintain.

---

# 🧠 32. Key Takeaway

The main lesson of Chapter 10 is that **building an LWC is not only about creating individual components**.

A professional Salesforce developer must understand how components interact, how data flows through the application, how Salesforce services are used, and how the UI remains synchronized with the underlying data.

The complete concept can be remembered as:

```text
USER
  ↓
LWC
  ↓
COMPONENT COMMUNICATION
  ↓
LDS / APEX
  ↓
SERVICE / BUSINESS LOGIC
  ↓
SALESFORCE DATABASE
  ↓
RESULT
  ↓
STATE UPDATE
  ↓
UI REFRESH
  ↓
USER
```

The goal is to build applications where components are:

```text
Focused
   +
Reusable
   +
Loosely Coupled
   +
Secure
   +
Efficient
   +
Maintainable
   +
Scalable
```

> **Build components that think together, communicate clearly, use Salesforce data efficiently, maintain consistent state, and work together as one complete application.**

---

# ⭐ Chapter 10 Summary

```text
┌──────────────────────────────────────────────┐
│        CHAPTER 10 — CORE CONCEPTS            │
├──────────────────────────────────────────────┤
│ Component Architecture                       │
│ Component Responsibilities                   │
│ Parent → Child Communication                 │
│ Child → Parent Communication                 │
│ Sibling Communication                        │
│ Lightning Message Service                   │
│ Lightning Data Service                      │
│ Apex Integration                            │
│ Service / Business Layer                    │
│ State Management                             │
│ Loading & Error Handling                    │
│ Data Refresh                                 │
│ Reusable Components                          │
│ Performance Optimization                     │
│ Security                                     │
│ Testing                                      │
│ Real-World Application Architecture          │
└──────────────────────────────────────────────┘
```

## 🎯 Final Goal

```text
Individual Components
        ↓
Connected Components
        ↓
Coordinated Data Flow
        ↓
Consistent Application State
        ↓
Scalable Salesforce Application
```

**Chapter 10 represents the transition from learning how to build individual LWCs to learning how to design complete, connected, maintainable, and scalable Salesforce applications.**
