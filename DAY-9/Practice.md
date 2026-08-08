
# 📚 Lightning Web Components — Learning Notes

## 🚀 Day 9 | Salesforce Lightning Web Components

> **Engineering Sprint 09 — Student Placement Portal**

---

# 🎯 Introduction

**Lightning Web Components (LWC)** is Salesforce's modern framework for creating interactive and reusable user interfaces.

LWC allows developers to build an application by dividing the interface into **small, independent components** instead of creating everything inside one large component.

For example, the Student Placement Portal can be divided into components such as:

```text
Student Placement Portal
        │
        ├── Placement Home
        │
        ├── Placement Dashboard
        │
        ├── Eligible Jobs
        │       │
        │       └── Job Card
        │
        └── My Applications
```

Each component has a specific responsibility and can work independently while also communicating with other components when required.

---

# 🧠 1. What is Lightning Web Components?

**Lightning Web Components (LWC)** is a Salesforce framework used to create modern web interfaces on the Salesforce Platform.

LWC is based on standard web technologies and follows the **Web Components** standards.

The main technologies used in LWC are:

* **HTML** — Creates the structure of the component.
* **JavaScript** — Controls the behavior and logic.
* **CSS** — Controls the appearance and styling.
* **Web Components** — Provides the component-based architecture.
* **ES6+ JavaScript** — Provides modern JavaScript features.
* **Lightning Base Components** — Provides ready-made Salesforce UI components.

### Simple Example

A simple LWC can contain:

```text
HTML
  ↓
Displays a button

JavaScript
  ↓
Handles button click

CSS
  ↓
Controls appearance
```

So, an LWC combines **structure + behavior + styling** into a reusable unit.

---

# 🧩 2. Component-Based Architecture

One of the most important concepts in LWC is **component-based development**.

Instead of building the complete Student Placement Portal as one component, the application can be divided into smaller components.

```text
Student Placement Portal
        │
        ├── Home
        │
        ├── Dashboard
        │
        ├── Eligible Jobs
        │       │
        │       ├── Job Card
        │       └── Apply Button
        │
        └── My Applications
```

Each component performs a specific task.

### Why divide the application?

It makes the application:

* Easier to understand
* Easier to develop
* Easier to test
* Easier to debug
* Easier to reuse
* Easier to maintain

For example, instead of writing the job display logic repeatedly, a reusable **Job Card** component can be created.

---

# 🧱 3. Structure of an LWC

An LWC usually contains three main files:

```text
jobCard/
│
├── jobCard.html
├── jobCard.js
└── jobCard.js-meta.xml
```

Sometimes a component can also contain:

```text
jobCard.css
```

### HTML File

The HTML file defines what the user sees.

```html
<template>
    <lightning-card title="Placement Opportunity">
        <p>{jobName}</p>
    </lightning-card>
</template>
```

The HTML template is responsible for the component's visual structure.

---

### JavaScript File

The JavaScript file contains the component's logic.

```javascript
import { LightningElement } from 'lwc';

export default class JobCard extends LightningElement {
    jobName = 'Software Developer';
}
```

Here:

```text
jobName
   ↓
JavaScript property
   ↓
HTML template
   ↓
Displayed to user
```

---

### Metadata File

The `.js-meta.xml` file defines how the component can be used in Salesforce.

For example, it can control whether the component is available on:

* Lightning App pages
* Home pages
* Record pages
* Experience Cloud pages

---

# 🎨 4. HTML in LWC

HTML defines the structure of the user interface.

LWC HTML uses a `<template>` element as the root of the component.

Example:

```html
<template>
    <lightning-card title="Eligible Job">
        <p>Software Developer</p>
        <lightning-button label="Apply"></lightning-button>
    </lightning-card>
</template>
```

This creates a simple placement opportunity card.

### Important Point

HTML should mainly describe **what should be displayed**.

The actual behavior is generally handled by JavaScript.

---

# ⚙️ 5. JavaScript in LWC

JavaScript controls the behavior of the component.

It can:

* Store data
* Handle user actions
* Call Apex methods
* Update component state
* Process responses
* Communicate with other components

Example:

```javascript
import { LightningElement } from 'lwc';

export default class JobCard extends LightningElement {

    jobName = 'Software Developer';

    handleApply() {
        console.log('Application started');
    }
}
```

The JavaScript class controls what happens when the user interacts with the component.

---

# 🎨 6. CSS in LWC

CSS is used to customize the visual appearance of an LWC.

Example:

```css
.job-title {
    font-size: 20px;
    font-weight: bold;
}
```

HTML:

```html
<template>
    <h2 class="job-title">Software Developer</h2>
</template>
```

CSS controls presentation while HTML defines structure.

---

# 🔄 7. Data Binding

Data binding connects JavaScript data with the HTML template.

Example:

```javascript
jobName = 'Software Developer';
```

HTML:

```html
<template>
    <p>{jobName}</p>
</template>
```

The value:

```text
JavaScript
    │
    ▼
 jobName
    │
    ▼
 {jobName}
    │
    ▼
 HTML
```

The user sees:

```text
Software Developer
```

This allows the interface to display dynamic information.

---

# 🔁 8. Conditional Rendering

Sometimes an interface should display different content depending on a condition.

For example:

```text
Application Status
       │
       ├── Applied → Show "Application Submitted"
       │
       └── Not Applied → Show "Apply Now"
```

LWC supports conditional rendering using template directives.

Example:

```html
<template lwc:if={isApplied}>
    <p>Application Submitted</p>
</template>

<template lwc:else>
    <p>Apply Now</p>
</template>
```

JavaScript:

```javascript
isApplied = false;
```

If `isApplied` becomes `true`, the first section is displayed.

---

# 🔢 9. Rendering Lists

Placement portals commonly display multiple jobs.

For example:

```text
Available Jobs

Software Developer
Data Analyst
Web Developer
Cloud Engineer
```

Instead of manually creating HTML for every job, LWC can render a list dynamically.

Example:

```javascript
jobs = [
    { id: '1', name: 'Software Developer' },
    { id: '2', name: 'Data Analyst' },
    { id: '3', name: 'Web Developer' }
];
```

HTML:

```html
<template for:each={jobs} for:item="job">
    <p key={job.id}>{job.name}</p>
</template>
```

This allows the same UI structure to be reused for every job.

---

# 🖱️ 10. Event Handling

Events allow the component to respond to user actions.

Common user actions include:

* Clicking a button
* Selecting a job
* Entering information
* Changing a value
* Submitting a form

Example:

```html
<lightning-button
    label="Apply"
    onclick={handleApply}>
</lightning-button>
```

JavaScript:

```javascript
handleApply() {
    console.log('Apply button clicked');
}
```

The flow is:

```text
User clicks Apply
       ↓
onclick event
       ↓
handleApply()
       ↓
JavaScript executes
```

---

# 📤 11. Passing Data from Parent to Child

A parent component can send information to a child component.

For example:

```text
Eligible Jobs
      │
      ├── Job Card 1
      ├── Job Card 2
      └── Job Card 3
```

The parent knows the complete job information and passes individual job data to each Job Card.

In the child component:

```javascript
@api job;
```

The `@api` decorator makes a property available to the parent component.

### Simple Concept

```text
Parent Component
       │
       │ Job Data
       ▼
Child Component
```

This is useful when creating reusable components.

---

# 📥 12. Communication from Child to Parent

Sometimes the child component needs to inform its parent about an action.

For example:

```text
Job Card
   │
   │ User clicks Apply
   ▼
Child sends event
   │
   ▼
Parent receives event
```

This can be done using a **CustomEvent**.

Example:

```javascript
this.dispatchEvent(
    new CustomEvent('apply')
);
```

The parent can listen for the event:

```html
<c-job-card onapply={handleApply}></c-job-card>
```

This allows components to communicate without tightly coupling their internal logic.

---

# 🌐 13. Lightning Data Service

Salesforce provides **Lightning Data Service (LDS)** to work with Salesforce records without always writing custom Apex.

LDS can be used to:

* Retrieve records
* Create records
* Update records
* Delete records

It also provides Salesforce-managed data handling and caching.

Conceptually:

```text
LWC
 ↓
Lightning Data Service
 ↓
Salesforce Records
```

For standard record operations, LDS can often reduce the amount of custom Apex code required.

---

# 🔌 14. Calling Apex from LWC

When the required operation cannot be handled directly through standard LWC data services, Apex can be used.

The general flow is:

```text
LWC
 ↓
Apex Method
 ↓
Salesforce Database
 ↓
Apex Response
 ↓
LWC
```

For the Student Placement Portal, Apex can handle operations such as:

* Retrieving eligible jobs
* Checking application eligibility
* Preventing duplicate applications
* Validating CGPA
* Checking application deadlines
* Creating application records

---

# 🛡️ 15. Business Logic in Apex

Business logic contains the rules that determine whether an operation is allowed.

For example, before creating a placement application, the system can check:

```text
Application Request
       │
       ▼
Duplicate Check
       │
       ▼
CGPA Check
       │
       ▼
Deadline Check
       │
       ▼
Create Application
```

If a validation fails, Apex can return an error instead of creating the record.

This keeps important business rules on the server side.

---

# 🔄 16. Wire Service

The **wire service** provides a reactive way to retrieve Salesforce data.

Example:

```javascript
@wire(getJobs)
wiredJobs({ data, error }) {
    if (data) {
        this.jobs = data;
    }
}
```

The basic flow is:

```text
Salesforce Data
      ↓
Wire Service
      ↓
LWC JavaScript
      ↓
Component State
      ↓
HTML
      ↓
User Interface
```

One important advantage is that the component can react when the wired data changes.

---

# ⚡ 17. Imperative Apex Calls

Apex can also be called imperatively when the operation needs to happen because of a specific user action.

For example:

```text
User clicks "Apply"
       ↓
JavaScript method executes
       ↓
Apex method is called
       ↓
Application is processed
```

This approach is particularly useful for actions such as:

* Submit application
* Delete record
* Perform an operation after a button click
* Send specific parameters to Apex

---

# 🔄 18. Component State

**Component state** represents the current information maintained by the LWC.

For example:

```javascript
selectedJob;
selectedStudent;
isLoading = false;
errorMessage;
```

The state can change during user interaction.

Example:

```text
Initial State
     ↓
No Job Selected
     ↓
User Selects Job
     ↓
selectedJob Updated
     ↓
UI Updates
```

Managing state correctly helps keep the interface synchronized with the user's actions.

---

# ⏳ 19. Loading and Error Handling

Applications often need to show the user what is happening.

For example:

```text
User clicks Apply
       ↓
Processing...
       ↓
       ├── Success
       │     ↓
       │  Application Created
       │
       └── Error
             ↓
         Error Message
```

A loading indicator can be displayed while Apex is processing the request.

Example:

```javascript
isLoading = true;
```

After processing:

```javascript
isLoading = false;
```

Error handling ensures that users receive meaningful feedback instead of seeing a broken or unresponsive interface.

---

# 🔄 20. Refreshing Data

After creating or updating a Salesforce record, the displayed information may need to be refreshed.

For example:

```text
Student submits application
          ↓
Application created
          ↓
Refresh application data
          ↓
My Applications
          ↓
New application displayed
```

This ensures that the interface reflects the latest Salesforce data.

---

# 🧩 21. Lightning Base Components

Salesforce provides reusable UI components called **Lightning Base Components**.

Examples include:

```text
lightning-button
lightning-input
lightning-card
lightning-combobox
lightning-datatable
lightning-spinner
```

Example:

```html
<lightning-input
    label="Student Name">
</lightning-input>
```

Using base components saves development time and provides a consistent Salesforce-style interface.

---

# 📊 22. Student Placement Portal Component Structure

The concepts learned in LWC can be combined to create a structured portal.

```text
Student Placement Portal
        │
        ├── Placement Home
        │
        ├── Placement Dashboard
        │
        ├── Eligible Jobs
        │       │
        │       ├── Job Card
        │       │      │
        │       │      └── Apply Button
        │       │
        │       └── Job Details
        │
        └── My Applications
                │
                ├── Application List
                └── Application Status
```

Each component has a focused responsibility.

---

# 🔗 23. Complete LWC Data Flow

The overall flow of the Student Placement Portal can be represented as:

```text
                 USER
                  │
                  ▼
           ┌──────────────┐
           │     LWC      │
           │ HTML + JS    │
           └──────┬───────┘
                  │
          User Interaction
                  │
                  ▼
           ┌──────────────┐
           │ Apex / LDS   │
           └──────┬───────┘
                  │
          Business / Data Logic
                  │
                  ▼
           ┌──────────────┐
           │  Salesforce  │
           │   Database   │
           └──────┬───────┘
                  │
             Data Response
                  │
                  ▼
           ┌──────────────┐
           │     LWC      │
           │ State Update │
           └──────┬───────┘
                  │
                  ▼
              USER INTERFACE
```

---

# 🎓 24. What Was Learned in Day 9

By working with Lightning Web Components, the following concepts were understood:

### LWC Fundamentals

* Component-based development
* HTML, JavaScript, and CSS structure
* Metadata configuration

### UI Development

* Data binding
* Conditional rendering
* List rendering
* Lightning Base Components
* User interactions

### Component Communication

* Parent-to-child communication
* Child-to-parent communication
* Custom events

### Salesforce Integration

* Lightning Data Service
* Wire service
* Imperative Apex
* Salesforce database interaction

### Application Logic

* Component state
* Business validation
* Error handling
* Loading states
* Data refresh

### Placement Portal Application

* Job listing
* Job selection
* Student selection
* Application submission
* Eligibility validation
* Application creation
* Application visibility

---

# 🚀 Final Takeaway

Lightning Web Components provide a structured way to build modern Salesforce applications by separating the user interface into reusable components.

For the Student Placement Portal, the complete architecture follows:

```text
User
 ↓
LWC Interface
 ↓
Component Logic
 ↓
LDS / Apex
 ↓
Business Validation
 ↓
Salesforce Database
 ↓
Response
 ↓
LWC State
 ↓
Updated Interface
```

The main idea is simple:

> **LWC manages the user experience, Apex handles server-side business logic, and Salesforce manages the data.**

Together, these layers create a scalable foundation for building real-world Salesforce applications.
