# 🏗️ System Architecture

The Placement Management System follows a **source-driven Salesforce development architecture**, where application source code and Salesforce metadata are maintained in Git and moved through controlled environments.

## 🔹 High-Level Architecture

```text
                    ┌──────────────────────┐
                    │      Developers      │
                    └──────────┬───────────┘
                               │
                               ↓
                    ┌──────────────────────┐
                    │    Git Repository    │
                    │       GitHub         │
                    └──────────┬───────────┘
                               │
                       Feature Branch
                               │
                               ↓
                    ┌──────────────────────┐
                    │   Pull Request &    │
                    │    Code Review      │
                    └──────────┬───────────┘
                               │
                               ↓
                    ┌──────────────────────┐
                    │   Salesforce CLI     │
                    │        (sf)          │
                    └──────────┬───────────┘
                               │
                      Metadata Deployment
                               │
                               ↓
             ┌──────────────────────────────────┐
             │       Salesforce Platform        │
             │                                  │
             │  ┌──────────┐   ┌────────────┐  │
             │  │   LWC    │ →│    Apex    │  │
             │  └──────────┘   └─────┬──────┘  │
             │                       │          │
             │                  SOQL / DML      │
             │                       │          │
             │                       ↓          │
             │              ┌────────────────┐  │
             │              │ Salesforce     │  │
             │              │ Objects/Data   │  │
             │              └────────────────┘  │
             │                                  │
             │  Objects • Fields • Flows        │
             │  Triggers • Permissions           │
             └──────────────────┬───────────────┘
                                │
                                ↓
                       Testing & Verification
                                │
                                ↓
                      ┌────────────────────┐
                      │    QA → UAT →      │
                      │     Production     │
                      └────────────────────┘
```

The PDF describes this overall approach as moving from **source control → deployment → Salesforce environments**, rather than treating the Salesforce Org as the only copy of the application.

---

## 🔹 1. Development Layer

Developers create and modify Salesforce application components such as:

* Apex Classes
* Apex Triggers
* Lightning Web Components
* Objects
* Fields
* Flows
* Permissions
* Configuration

These components are represented as source and metadata within the project.

```text
Developer
    ↓
Salesforce Components
    ↓
Local Source
```

---

## 🔹 2. Version Control Layer

Git provides the history and collaboration layer for the project.

```text
Working Files
     ↓
   git add
     ↓
Staging Area
     ↓
 git commit
     ↓
Local Repository
     ↓
 git push
     ↓
GitHub Repository
```

Developers can use `git pull` to bring changes from the remote repository into their local environment.

---

## 🔹 3. Branch & Review Layer

New functionality is developed through feature branches rather than directly changing the main branch.

```text
main
 │
 ├── feature/student-profile
 ├── feature/job-search
 └── feature/application-workflow
```

The completed feature follows:

```text
Feature Branch
      ↓
Pull Request
      ↓
Code Review
      ↓
Testing
      ↓
Merge
      ↓
main
```

This allows changes to be reviewed and tested before they become part of the main development line.

---

## 🔹 4. Salesforce CLI Layer

Salesforce CLI provides the command-line interface between the local project and Salesforce environments.

```text
Local Project
      ↓
Salesforce CLI (sf)
      ↓
Authenticate
      ↓
Retrieve / Deploy
      ↓
Salesforce Org
```

The CLI supports activities such as authentication, metadata retrieval, deployment, testing, and environment management.

---

## 🔹 5. Salesforce Application Layer

Inside Salesforce, the application consists of multiple components.

```text
                    Salesforce Application
                            │
          ┌─────────────────┼─────────────────┐
          ↓                 ↓                 ↓
         LWC              Apex             Flows
          │                 │
          ↓                 ↓
       User UI          Business Logic
                            │
                    ┌───────┴────────┐
                    ↓                ↓
                 SOQL              DML
                    │                │
                    └───────┬────────┘
                            ↓
                    Salesforce Objects
```

The PDF emphasizes that an application is a combination of **Apex, LWC, Objects, Fields, Flows, Permissions, Named Credentials, and other metadata**, rather than a single code file.

---

## 🔹 6. Metadata Layer

Salesforce configuration is represented as metadata.

```text
Salesforce Configuration
          ↓
       Metadata
          ↓
   Source Representation
          ↓
         Git
```

Examples include:

```text
Custom Objects
Custom Fields
Flows
Apex Classes
Triggers
LWC Metadata
Permissions
```

This allows the configuration to be version-controlled and deployed to another environment.

---

## 🔹 7. Environment Layer

The application moves through controlled environments.

```text
Developer
    ↓
   QA
    ↓
   UAT
    ↓
Production
```

Each environment has a different purpose:

| Environment | Purpose                               |
| ----------- | ------------------------------------- |
| Developer   | Build and develop features            |
| QA          | Test functionality                    |
| UAT         | Validate business requirements        |
| Production  | Provide the application to real users |

The exact environment structure can vary between organizations, but the principle is controlled progression.

---

## 🔹 8. Testing & Validation Layer

Before Production, the application goes through testing and validation.

```text
Build
  ↓
Test
  ↓
Validate
  ↓
Deploy
  ↓
Verify
```

Testing can include:

* Apex Tests
* Functional Tests
* Integration Tests
* LWC Testing where applicable
* Permission Checks
* Deployment Validation
* Regression Testing

---

## 🔹 9. Deployment Layer

The deployment layer moves validated Salesforce metadata into the target environment.

```text
Source
  ↓
Deployment
  ↓
Target Salesforce Org
```

Possible deployment approaches include:

```text
Salesforce CLI
      │
      ├── Source-driven workflow
      │
Changesets
      │
      └── Salesforce-native metadata movement

Metadata API
      │
      └── Programmatic metadata deployment/retrieval
```

The PDF presents these as different approaches that can be appropriate depending on the organization's development model.

---

## 🔹 10. Dependency Flow

Deployment must consider dependencies between components.

For example:

```text
LWC
 ↓
Apex Method
 ↓
Apex Class
 ↓
Custom Object
 ↓
Custom Field
```

If a required dependency does not exist in the target environment, the deployment or functionality may fail.

### Key Principle

> **Deploy the system, not just the file.**

Always identify what a component depends on before deployment.

---

# 🔄 Complete System Flow

```text
Developer
    ↓
Local Salesforce Project
    ↓
Git Feature Branch
    ↓
Commit
    ↓
Push to GitHub
    ↓
Pull Request
    ↓
Code Review
    ↓
Merge
    ↓
Salesforce CLI
    ↓
Metadata Deployment
    ↓
Development / Test Org
    ↓
Testing
    ↓
QA
    ↓
UAT
    ↓
Production
    ↓
Verification
```

## ⭐ Architecture Principle

The system follows a **source-driven and controlled development model**:

```text
Source Control
      ↓
Development
      ↓
Code Review
      ↓
Testing
      ↓
Metadata Deployment
      ↓
Controlled Environments
      ↓
Production
```

This architecture changes the project from simply **"an application that works in my Salesforce Org"** into a system that can be **version-controlled, reviewed, tested, reproduced, documented, and safely delivered**.
