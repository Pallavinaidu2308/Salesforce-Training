# 🏗️ Component Architecture — Day 9

## Student Placement Portal — Lightning Web Components

> **Engineering Sprint 09 | Salesforce LWC**

---

## 📌 Overview

The **Student Placement Portal** is designed using a component-based architecture in Salesforce. The system separates the user interface, server-side logic, business rules, and database operations into different layers.

This separation makes the application:

* Easier to understand
* Easier to maintain
* Easier to test
* Easier to debug
* Reusable
* Scalable

The main principle followed in this architecture is:

> **The UI requests. The business layer decides.**

The Lightning Web Component handles what the user sees and does, while Apex handles server-side processing and business logic.

---

# 🎯 Architectural Objective

The objective of the Student Placement Portal is to provide students with a simple interface for managing placement activities.

The system allows students to:

* 👨‍🎓 View student-related information
* 💼 View available and eligible jobs
* 🏢 View company names
* 📊 View minimum CGPA requirements
* 📅 View job closing dates
* 🖱️ Apply for jobs
* ⚠️ Receive validation and error messages
* ✅ Receive application confirmation
* 📋 Store submitted applications in Salesforce

The student interacts only with the user interface. The underlying Apex and Salesforce database operations are handled automatically by the application.

---

# 🧩 What is Component-Based Architecture?

Component-based architecture divides an application into smaller independent components.

Each component has a specific responsibility.

Instead of creating one large application containing all the logic, the Student Placement Portal separates the system into:

```text
Lightning Web Component
        ↓
Apex Controller
        ↓
Application Service
        ↓
Business Validation
        ↓
Salesforce Database
```

Each layer communicates with the next layer.

This prevents the UI from containing complex business logic.

---

# 🏗️ High-Level Architecture

```text
                         👨‍🎓 STUDENT
                              │
                              ▼
                 ┌────────────────────────┐
                 │  Placement Dashboard   │
                 └────────────┬───────────┘
                              │
                              ▼
                 ┌────────────────────────┐
                 │    Eligible Jobs LWC   │
                 │                        │
                 │  eligibleJobs.html     │
                 │  eligibleJobs.js      │
                 │  eligibleJobs-meta.xml│
                 └────────────┬───────────┘
                              │
                       Apex Method Call
                              │
                              ▼
                 ┌────────────────────────┐
                 │ ApplicationController  │
                 │         Apex           │
                 └────────────┬───────────┘
                              │
                              ▼
                 ┌────────────────────────┐
                 │   ApplicationService   │
                 │         Apex           │
                 └────────────┬───────────┘
                              │
                    Business Processing
                              │
                 ┌────────────┴────────────┐
                 │                         │
                 ▼                         ▼
        ┌─────────────────┐       ┌─────────────────┐
        │    Validation   │       │   Application   │
        │     Rules       │       │    Processing   │
        └────────┬────────┘       └────────┬────────┘
                 │                         │
                 └────────────┬────────────┘
                              │
                              ▼
                 ┌────────────────────────┐
                 │  Salesforce Database   │
                 │                        │
                 │  Student__c            │
                 │  Job__c                │
                 │  Application__c        │
                 └────────────────────────┘
```

---

# 🖥️ 1. Lightning Web Component Layer

The Lightning Web Component is the presentation layer of the application.

The current project contains an `eligibleJobs` LWC.

### Main files

```text
eligibleJobs/
│
├── eligibleJobs.html
├── eligibleJobs.js
└── eligibleJobs.js-meta.xml
```

### `eligibleJobs.html`

The HTML file defines what the user sees.

It displays:

* Job title
* Company name
* Minimum CGPA
* Closing date
* Apply button

Example structure:

```text
Eligible Jobs
│
├── Salesforce Developer
│   ├── Company: TCS
│   ├── Minimum CGPA: 7.5
│   ├── Closing Date: 2026-08-30
│   └── Apply
│
├── Software Engineer
│   ├── Company: Microsoft
│   ├── Minimum CGPA: 8.0
│   ├── Closing Date: 2026-08-30
│   └── Apply
│
└── SDE
    ├── Company: Amazon
    ├── Minimum CGPA: 7.0
    ├── Closing Date: 2026-08-30
    └── Apply
```

---

# ⚙️ 2. JavaScript Layer

The `eligibleJobs.js` file controls the behavior of the component.

It is responsible for:

* Calling Apex methods
* Receiving job records
* Storing job data
* Handling Apply button clicks
* Displaying success messages
* Displaying error messages

The component uses the Salesforce `wire` service to retrieve job information.

Conceptually:

```text
LWC
 │
 │ Request jobs
 ▼
ApplicationController
 │
 ▼
ApplicationService
 │
 ▼
Job__c records
 │
 ▼
LWC
 │
 ▼
Display jobs
```

When the user clicks **Apply**, the component sends the selected Job ID to Apex.

```text
User clicks Apply
       ↓
Job ID captured
       ↓
submitApplication()
       ↓
ApplicationController
       ↓
ApplicationService
       ↓
Validation
       ↓
Application__c created
       ↓
Success message
```

---

# 🔌 3. Apex Controller Layer

The `ApplicationController` acts as the bridge between the Lightning Web Component and the service layer.

### File

```text
ApplicationController.cls
```

The controller exposes methods that can be called from the LWC.

The main responsibilities are:

* Receive requests from the LWC
* Pass requests to the service layer
* Return results to the LWC
* Avoid containing unnecessary business logic

The architecture follows:

```text
LWC
 │
 ▼
ApplicationController
 │
 ▼
ApplicationService
```

This keeps the controller lightweight.

---

# 🧠 4. Application Service Layer

The `ApplicationService` contains the main application processing logic.

### File

```text
ApplicationService.cls
```

This layer is responsible for:

* Processing applications
* Checking whether a student exists
* Preventing duplicate applications
* Creating Application records
* Applying business rules
* Performing database operations

For example, when a student applies:

```text
Check Job ID
      ↓
Check Student
      ↓
Check Duplicate Application
      ↓
Create Application
      ↓
Return Application ID
```

This design prevents the Lightning Web Component from directly handling database logic.

---

# 🛡️ 5. Validation Layer

The project also uses Salesforce validation rules to protect data integrity.

Examples include:

### Student Mandatory Validation

A student must be selected before an application can be created.

```text
Student__c cannot be blank
```

### CGPA Validation

The student's CGPA must satisfy the job's minimum CGPA requirement.

```text
Student CGPA
      ≥
Job Minimum CGPA
```

For example:

```text
Student CGPA = 8.5
Job Minimum CGPA = 7.0

8.5 ≥ 7.0

Application allowed
```

If:

```text
Student CGPA = 6.8
Job Minimum CGPA = 7.5
```

the application should be rejected.

### Application Date Validation

The application date should not be after the job closing date.

```text
Application Date
       ≤
Closing Date
```

These validations provide an additional layer of protection at the Salesforce database level.

---

# 🗄️ 6. Salesforce Database Layer

The application uses Salesforce custom objects to store placement data.

### Student__c

Stores student information.

Example:

```text
Student
├── Name
└── CGPA__c
```

### Job__c

Stores job information.

Example:

```text
Job
├── Name
├── Company__c
├── Minimum_CGPA__c
└── Closing_Date__c
```

### Application__c

Stores student applications.

Example:

```text
Application
├── Student__c
├── Job__c
├── Status__c
└── Application_Date__c
```

The relationships can be represented as:

```text
Student__c
    │
    │
    ├──────────────┐
    │              │
    ▼              ▼
Application__c ← Job__c
```

An application connects a student with a particular job.

---

# 🔄 Application Submission Flow

The complete application process works as follows:

```text
1. Student opens Placement Portal
              ↓
2. Eligible Jobs LWC loads
              ↓
3. LWC requests jobs from Apex
              ↓
4. ApplicationController receives request
              ↓
5. ApplicationService processes request
              ↓
6. Job records are retrieved
              ↓
7. Jobs are displayed
              ↓
8. Student clicks Apply
              ↓
9. Selected Job ID is sent to Apex
              ↓
10. ApplicationController receives Job ID
              ↓
11. ApplicationService validates request
              ↓
12. Duplicate application is checked
              ↓
13. Salesforce validation rules are applied
              ↓
14. Application__c record is created
              ↓
15. Success response is returned
              ↓
16. LWC displays confirmation
```

---

# 🚫 Duplicate Application Prevention

The system prevents the same student from applying to the same job multiple times.

The logic is:

```text
Student + Job
     ↓
Search existing Application
     ↓
     ┌───────────────┐
     │ Application   │
     │ already exists│
     └───────┬───────┘
             │
            YES
             │
             ▼
      Reject application

             OR

            NO
             │
             ▼
      Create application
```

This prevents duplicate application records.

---

# 🔐 Separation of Responsibilities

A major advantage of this architecture is separation of responsibilities.

| Layer               | Responsibility                            |
| ------------------- | ----------------------------------------- |
| LWC HTML            | User interface                            |
| LWC JavaScript      | User interaction and component state      |
| Apex Controller     | Communication between UI and service      |
| Application Service | Business logic and application processing |
| Validation Rules    | Data validation                           |
| Salesforce Objects  | Data storage                              |

This makes the application easier to maintain and modify.

---

# 📈 Benefits of the Architecture

## 1. Maintainability

Changes to the UI do not require rewriting the entire Apex layer.

## 2. Reusability

Apex service methods can be reused by different components.

## 3. Scalability

The architecture can support additional features such as:

* Job search
* Job filtering
* Application tracking
* Student dashboards
* Recruiter dashboards
* Notifications
* Application status updates

## 4. Security

Server-side Apex and Salesforce validation rules provide controlled access to business operations.

## 5. Easier Testing

Each layer can be tested independently.

## 6. Better Debugging

Errors can be isolated to:

```text
UI
↓
Controller
↓
Service
↓
Validation
↓
Database
```

---

# 🧱 GitHub Project Architecture

Use the following structure for your GitHub repository:

```text
Student-Placement-Portal/
│
├── README.md
│
├── force-app/
│   └── main/
│       └── default/
│           │
│           ├── classes/
│           │   ├── ApplicationController.cls
│           │   ├── ApplicationController.cls-meta.xml
│           │   ├── ApplicationService.cls
│           │   ├── ApplicationService.cls-meta.xml
│           │   ├── NotificationService.cls
│           │   ├── NotificationService.cls-meta.xml
│           │   ├── StatisticsService.cls
│           │   ├── StatisticsService.cls-meta.xml
│           │   ├── AlumniService.cls
│           │   └── AlumniService.cls-meta.xml
│           │
│           ├── lwc/
│           │   └── eligibleJobs/
│           │       ├── eligibleJobs.html
│           │       ├── eligibleJobs.js
│           │       └── eligibleJobs.js-meta.xml
│           │
│           ├── objects/
│           │   ├── Student__c/
│           │   ├── Job__c/
│           │   └── Application__c/
│           │
│           └── triggers/
│
├── screenshots/
│   ├── eligible-jobs.png
│   ├── company-name.png
│   ├── application-success.png
│   ├── application-record.png
│   └── architecture.png
│
└── sfdx-project.json
```

---

# 📸 Recommended Screenshots for GitHub

Create a `screenshots` folder and include the following evidence.

### Screenshot 1 — Eligible Jobs

Show:

* Eligible Jobs heading
* Job names
* Company names
* Minimum CGPA
* Closing dates

### Screenshot 2 — Apply Button

Show the Eligible Jobs component with the **Apply** button.

### Screenshot 3 — Successful Application

Show:

```text
Success
Application submitted successfully.
```

### Screenshot 4 — Application Record

Show the Salesforce `Application__c` record containing:

* Student
* Job
* Status
* Application Date

### Screenshot 5 — Duplicate Application

Show the system preventing a duplicate application.

### Screenshot 6 — Architecture

Take a screenshot of the architecture diagram in this document or create a clean architecture diagram and save it as:

```text
screenshots/architecture.png
```

---

# 🧪 Testing Flow

The component can be tested using the following scenarios.

| Test Case                              | Expected Result                |
| -------------------------------------- | ------------------------------ |
| Eligible student views jobs            | Jobs displayed                 |
| Company field exists                   | Company name displayed         |
| Student clicks Apply                   | Application created            |
| Student applies twice                  | Duplicate rejected             |
| CGPA is below requirement              | Application rejected           |
| Student is missing                     | Application rejected           |
| Application date is after closing date | Application rejected           |
| Valid application                      | Success confirmation displayed |

---

# 🚀 Future Enhancements

The architecture can be extended with additional components.

```text
Placement Dashboard
│
├── Student Profile
│
├── Eligible Jobs
│   └── Job Card
│
├── My Applications
│
├── Application Status
│
├── Job Search
│
└── Notifications
```

Future versions can also include:

* Search and filter functionality
* Application status tracking
* Recruiter management
* Interview scheduling
* Email notifications
* Student dashboards
* Placement statistics
* Automated notifications

---

# 📌 Key Learning

The most important concept from this architecture is **separation of responsibilities**.

The system follows:

```text
LWC
 │
 │ User Interaction
 ▼
ApplicationController
 │
 │ Request Routing
 ▼
ApplicationService
 │
 │ Business Logic
 ▼
Validation
 │
 │ Data Integrity
 ▼
Salesforce Database
```

This architecture keeps the user interface simple while placing important business rules and database operations on the server side.

> **The UI requests. The controller routes. The service decides. The database stores.**

---

# ✅ Conclusion

The Student Placement Portal demonstrates how Salesforce Lightning Web Components can be combined with Apex and Salesforce custom objects to create a structured, maintainable application.

The component-based architecture provides clear separation between:

* Presentation
* User interaction
* Server-side communication
* Business logic
* Validation
* Data storage

This approach provides a strong foundation for building larger Salesforce applications while keeping the code organized, reusable, testable, and easier to maintain.
