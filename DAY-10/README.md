
# Sprint 10 — LWC Component Communication, Forms, LDS & Reusable Architecture

## Overview

Sprint 10 focuses on building Lightning Web Components (LWC) as a coordinated application rather than as isolated UI components.

The sprint extends the Student Placement Portal by introducing component communication, forms, validation, Lightning Data Service (LDS), reactive data, reusable components, UI states, and application-level architecture.

The main objective is to understand how multiple LWCs communicate with each other, how data ownership is managed, and how UI components interact with Apex, services, and Salesforce data.

---

## Objectives

The key objectives of this sprint are:

- Understand LWC component architecture.
- Implement parent-to-child communication.
- Implement child-to-parent communication.
- Use `@api` public properties.
- Use custom events for component communication.
- Design clear event contracts.
- Understand sibling component communication.
- Establish clear data ownership.
- Work with reactive data.
- Refresh data after record updates.
- Build forms using LWC.
- Implement client-side validation.
- Understand server-side validation.
- Use Lightning Data Service (LDS).
- Understand Wire and imperative Apex.
- Build reusable components.
- Avoid large "god components".
- Implement loading, success, empty, and error states.
- Understand the complete LWC → Apex → Service → Database flow.

---

# 1. Business Problem

The Student Placement Portal initially contains functionality such as:

- Viewing eligible jobs
- Viewing job details
- Applying for jobs
- Viewing applications

As the application grows, additional requirements are introduced:

- Student profile management
- Application tracking
- Interview information
- Offer information
- Notifications
- Different actions for different users

Putting all functionality into one LWC creates a large and difficult-to-maintain component.

### Problematic Architecture

```text
StudentPortal
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
