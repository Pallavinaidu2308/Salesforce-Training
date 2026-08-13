# Sprint 10 — Building Components That Think Together

## LWC Component Communication, Forms, Lightning Data Service & Reusable Architecture

> A component becomes truly useful when it knows not only how to perform its own task, but also how to participate in a larger system.

---

## 📌 Overview

Sprint 10 focuses on moving from building individual Lightning Web Components (LWCs) to designing a group of components that work together as one complete Salesforce application.

The Student Placement Portal is extended from a simple application flow into a more realistic application containing multiple focused components such as:

- Student Summary
- Student Profile
- Eligible Jobs
- Job Card
- Job Details
- My Applications
- Application Card
- Offer Summary

The major engineering challenge in this sprint is not simply creating more components.

The challenge is understanding:

- How components communicate
- Which component owns which data
- How data moves between components
- How user actions become application behaviour
- How forms should be designed
- Where validation should happen
- When to use Lightning Data Service (LDS)
- When to use Apex
- How to refresh dependent information
- How to build reusable components
- How to avoid tightly coupled components
- How to design loading, success, empty and error states

The sprint therefore introduces an important architectural principle:

> **A good Salesforce application is a collection of focused components that communicate through clear responsibilities and clear contracts.**

---

# 📚 Table of Contents

1. [Sprint Objectives](#-sprint-objectives)
2. [Business Context](#-business-context)
3. [Problem With a Large Component](#-problem-with-a-large-component)
4. [Component Architecture](#-component-architecture)
5. [Component Responsibilities](#-component-responsibilities)
6. [Parent-to-Child Communication](#-parent-to-child-communication)
7. [Child-to-Parent Communication](#-child-to-parent-communication)
8. [Custom Events](#-custom-events)
9. [Event Contracts](#-event-contracts)
10. [Sibling Component Communication](#-sibling-component-communication)
11. [Data Ownership](#-data-ownership)
12. [Reactive Data](#-reactive-data)
13. [Refreshing Data After Updates](#-refreshing-data-after-updates)
14. [Forms in LWC](#-forms-in-lwc)
15. [Lightning Base Components](#-lightning-base-components)
16. [Client-Side Validation](#-client-side-validation)
17. [Server-Side Validation](#-server-side-validation)
18. [Lightning Data Service](#-lightning-data-service)
19. [LDS vs Apex](#-lds-vs-apex)
20. [Wire vs Imperative Apex](#-wire-vs-imperative-apex)
21. [UI State Management](#-ui-state-management)
22. [Loading State](#-loading-state)
23. [Empty State](#-empty-state)
24. [Error State](#-error-state)
25. [Success State](#-success-state)
26. [Reusable Components](#-reusable-components)
27. [Reuse vs Over-Engineering](#-reuse-vs-over-engineering)
28. [Avoiding God Components](#-avoiding-god-components)
29. [Component Coupling](#-component-coupling)
30. [Complete Application Flow](#-complete-application-flow)
31. [Architecture Diagram](#-architecture-diagram)
32. [Data Flow](#-data-flow)
33. [Student Profile Form](#-student-profile-form)
34. [Job Application Flow](#-job-application-flow)
35. [Refresh Strategy](#-refresh-strategy)
36. [Architecture Decisions](#-architecture-decisions)
37. [Repository Structure](#-repository-structure)
38. [GitHub Evidence](#-github-evidence)
39. [Testing & Review](#-testing--review)
40. [Definition of Done](#-definition-of-done)
41. [Interview Questions](#-interview-questions)
42. [Key Engineering Principles](#-key-engineering-principles)
43. [Sprint Retrospective](#-sprint-retrospective)
44. [Conclusion](#-conclusion)

---

# 🎯 Sprint Objectives

By the end of this sprint, the application should demonstrate the following capabilities:

### Component Architecture

- Design multiple LWCs as one application.
- Give every component a clear responsibility.
- Avoid unnecessary component coupling.
- Prevent a single component from owning the entire application.

### Component Communication

- Implement parent-to-child communication.
- Implement child-to-parent communication.
- Use `@api` public properties appropriately.
- Use custom events for child-to-parent communication.
- Design meaningful event contracts.
- Understand how sibling components should communicate.

### Forms

- Build forms using Salesforce Lightning base components.
- Load existing record information.
- Allow users to edit information.
- Validate user input.
- Save changes.
- Display success and error messages.

### Salesforce Data

- Understand Lightning Data Service.
- Identify when LDS is appropriate.
- Identify when custom Apex is required.
- Understand wired and imperative Apex.
- Understand reactive data.
- Refresh dependent data after updates.

### UI Experience

- Implement loading states.
- Implement empty states.
- Implement error states.
- Implement success states.
- Prevent users from being confused about the current operation.

### Reusability

- Build meaningful reusable components.
- Avoid duplicate UI behaviour.
- Identify when abstraction is useful.
- Recognize when reuse becomes over-engineering.

These learning outcomes are directly aligned with the sprint objectives described in the module. :contentReference[oaicite:1]{index=1}

---

# 🏢 Business Context

The application being developed is a **Student Placement Portal**.

The portal allows students to:

- View their placement information
- View eligible jobs
- View job details
- Apply for jobs
- View submitted applications
- Maintain their profile

As the application grows, more requirements are introduced.

For example:

```text
Student Portal
│
├── Job Search
├── Job Details
├── Application
├── Withdraw Application
├── Interview
├── Offer
├── Profile
├── Notifications
└── Admin Actions
