# 📘 Sprint 6 Learning Journal

## Chapter 6 – Developing Event-Driven Applications with Apex Triggers

---

# 📅 Sprint Information

| Category | Details |
|----------|---------|
| **Sprint** | 6 |
| **Module** | Apex Triggers |
| **Project** | Placement Management System |
| **Platform** | Salesforce |

---

# 🎯 Sprint Objective

The goal of this sprint was to understand how Salesforce automates business processes using **Apex Triggers**.

Unlike previous modules where actions were initiated directly by users, this sprint introduced the concept of **event-driven programming**, where the application automatically responds whenever important business events occur.

I also learned how enterprise Salesforce applications organize automation using **Triggers** and **Service Classes** instead of placing all logic in a single file.

---

# 📖 Sprint Overview

Enterprise applications process thousands of transactions every day.

Imagine a recruitment portal where students apply for jobs, recruiters review applications, and companies publish new opportunities.

If users had to manually validate every application, update reports, and send notifications, the system would become slow and error-prone.

Salesforce solves this challenge by automatically executing Apex Triggers whenever records are created, updated, deleted, or restored.

This allows the application to react immediately whenever important business events occur.

---

# 💡 Concepts Learned

## 🔹 Apex Triggers

An Apex Trigger is a block of Apex code that executes automatically whenever data changes in Salesforce.

Triggers help automate business processes without requiring users to perform additional actions.

Triggers can execute when records are:

- Created
- Updated
- Deleted
- Restored

This makes Salesforce applications more efficient and consistent.

---

## 🔹 Event-Driven Programming

One of the biggest lessons from this sprint was understanding **event-driven architecture**.

Instead of continuously asking users what to do next, Salesforce waits for important business events and responds automatically.

### Example Business Events

| Business Event | Automatic System Response |
|----------------|---------------------------|
| Customer account created | Validate customer information |
| Product added | Update inventory |
| Service request closed | Notify customer |
| Invoice paid | Update payment status |

This approach reduces manual effort and improves application reliability.

---

## 🔹 Business Event Thinking

Professional Salesforce developers focus on **business events**, not user actions.

Instead of asking:

> **"Which button did the user click?"**

They ask:

> **"What business event occurred, and what should the system do automatically?"**

Thinking this way helps developers design scalable and maintainable enterprise applications.

---

## 🔹 Trigger vs Service Class

Another important concept introduced during this sprint was the separation of responsibilities between Triggers and Service Classes.

### Trigger Responsibilities

A Trigger should:

- Detect business events.
- Identify the trigger context.
- Pass records to the appropriate service class.
- Coordinate execution.

A Trigger should remain small and contain very little business logic.

---

### Service Class Responsibilities

A Service Class contains the application's business logic.

Typical responsibilities include:

- Data validation
- Business rule implementation
- Duplicate checking
- Record processing
- Decision making

Keeping business logic inside Service Classes makes the application easier to maintain and reuse.

---

# 💻 Practical Implementation

During this sprint, I implemented the following components.

## Apex Class

### CustomerService.cls

Implemented features:

- Customer validation
- Duplicate record validation
- Required field verification
- Business rule processing

---

## Apex Trigger

### CustomerTrigger.trigger

Implemented features:

- Before Insert Trigger
- Trigger delegation
- Service Layer implementation

The trigger simply detected the event and delegated the processing to the Service Class.

---

# 🛠 Salesforce CLI Practice

During development, I used Salesforce CLI to manage my project and deploy metadata.

### Frequently Used Commands

```bash
sf org login web

sf org list

sf org open

sf config set target-org MyOrg

sf project deploy start --source-dir force-app/main/default/classes

sf project deploy start --source-dir force-app/main/default/triggers

sf project deploy start --source-dir force-app/main/default/classes --source-dir force-app/main/default/triggers
```

These commands helped me manage Salesforce organizations, deploy Apex components, and verify successful deployments.

---

# ⚠ Challenges Encountered

Every project introduces practical challenges. During this sprint, I faced several issues while implementing Apex Triggers.

---

## 🔸 Trigger Metadata Missing

### Challenge

The trigger was successfully created in the project but did not appear in Salesforce after deployment.

### Solution

Created the required metadata file for the trigger and deployed it again.

---

## 🔸 Deployment Errors

### Challenge

Deployment failed because the Trigger referenced a method that had not yet been implemented.

### Solution

Implemented the missing validation method inside the Service Class and redeployed the project.

---

## 🔸 Incorrect Project Structure

### Challenge

Some metadata files were placed in incorrect folders, preventing successful deployment.

### Solution

Reorganized the project using the standard Salesforce DX directory structure.

---

## 🔸 Managing Multiple Salesforce Orgs

### Challenge

While practicing and helping others, I worked with multiple Salesforce Developer Orgs, which sometimes caused deployment confusion.

### Solution

Configured default organizations using Salesforce CLI and verified the active org before every deployment.

---

# 📈 Skills Developed

This sprint improved my practical understanding of:

- Apex Programming
- Apex Triggers
- SOQL
- DML
- Salesforce CLI
- Event-Driven Programming
- Service Layer Pattern
- Enterprise Application Architecture
- Metadata Deployment
- Project Organization
- Debugging Salesforce Applications

---

# 🏗 Enterprise Trigger Architecture

The trigger architecture implemented during this sprint follows a layered approach.

```text
User Action
      │
      ▼
Business Event
      │
      ▼
Apex Trigger
      │
      ▼
Service Class
      │
      ▼
Business Logic
      │
      ▼
Salesforce Database
```

This architecture separates responsibilities, making the application easier to maintain and extend.

---

# 📚 Best Practices Learned

Throughout this sprint, I learned several Salesforce development best practices.

- ✅ Keep Triggers lightweight.
- ✅ Store business logic inside Service Classes.
- ✅ Use one Trigger per object.
- ✅ Create reusable methods.
- ✅ Avoid duplicate code.
- ✅ Separate responsibilities clearly.
- ✅ Design applications for scalability.
- ✅ Follow enterprise design principles.

---

# 🎤 Interview Preparation

This sprint prepared me for several common Salesforce interview questions, including:

- What is an Apex Trigger?
- What are Trigger Events?
- Difference between Before and After Triggers.
- Difference between Triggers and Apex Classes.
- Difference between Triggers and Flows.
- What is Event-Driven Architecture?
- What is the Service Layer Pattern?
- Why should business logic not be written inside Triggers?
- What are Salesforce Trigger Best Practices?

---

# 🌟 Key Learning Outcomes

By the end of this sprint, I understood that enterprise applications should be designed around **business events** rather than user interactions.

Instead of writing large triggers filled with validation and processing logic, Salesforce developers keep triggers simple and delegate all business logic to dedicated Service Classes.

This design approach produces applications that are cleaner, more scalable, easier to maintain, and aligned with enterprise software engineering principles.

---

# 🏆 Sprint Outcome

Successfully completed:

- ✅ Service Class Development
- ✅ Apex Trigger Development
- ✅ Trigger Delegation
- ✅ Event-Driven Programming
- ✅ Business Rule Validation
- ✅ Enterprise Trigger Architecture
- ✅ Automatic Business Process Execution

---

# 🎯 Next Learning Goal

In the upcoming sprint, I plan to build on these concepts by learning:

- Bulk Processing
- Governor Limits
- Trigger Bulkification
- SOQL Optimization
- DML Best Practices
- Enterprise Trigger Frameworks
- Collection-Based Apex Programming

These concepts will help me write Apex code that efficiently processes large numbers of records while following Salesforce best practices.
