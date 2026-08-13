# 🔁 Retry Strategy

## Overview

A **Retry Strategy** is a mechanism that allows Salesforce to attempt an external API operation again when the first attempt fails due to a temporary problem.

External systems may fail because of:

- Network problems
- Temporary server downtime
- API timeout
- Service overload
- Temporary `5xx` errors

A retry strategy improves the **reliability and resilience** of Salesforce integrations.

---

## 🔄 Basic Retry Flow

```text
Salesforce
    ↓
API Request
    ↓
External System
    ↓
Failure
    ↓
Check Error Type
    ↓
Retryable?
   / \
 Yes  No
  ↓    ↓
Retry  Handle Error
  ↓
Success / Failure
EXAMPLE
Student Selected
      ↓
Queueable Apex
      ↓
Send Candidate
      ↓
External API
      ↓
500 Server Error
      ↓
Retry Required
      ↓
Retry Attempt
      ↓
Success
      ↓
Integration Status = Sent
