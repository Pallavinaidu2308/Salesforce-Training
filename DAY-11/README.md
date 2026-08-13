# Crossing the Salesforce Boundary

## Sprint 11 — Salesforce APIs, REST Integration, Named Credentials & External Systems

> **Engineering Principle:**
> A good Salesforce application does not live in isolation. It knows what belongs inside the platform, what belongs outside it, and how the two should communicate safely.

This module introduces **Salesforce integration with external systems** using REST APIs, Apex HTTP callouts, Named Credentials, authentication, External Objects, Salesforce Connect, middleware, synchronous/asynchronous integration, error handling, retry strategies, and idempotency.

The module uses a **Student Placement Management System** as the primary business scenario. The system must communicate with an external recruitment platform when students are selected for jobs and must also receive updates from the external system.

The core architectural idea is:

```text
Salesforce ↔ External System
```

Until this point, the application primarily operated inside Salesforce. This sprint introduces the engineering challenges that appear when Salesforce must communicate with systems that it does not control.

---

# Table of Contents

* [1. Learning Outcomes](#1-learning-outcomes)
* [2. Business Problem](#2-business-problem)
* [3. Why Salesforce Integrations Are Required](#3-why-salesforce-integrations-are-required)
* [4. APIs](#4-apis)
* [5. REST APIs](#5-rest-apis)
* [6. HTTP Methods](#6-http-methods)
* [7. Request and Response Structure](#7-request-and-response-structure)
* [8. HTTP Status Codes](#8-http-status-codes)
* [9. JSON](#9-json)
* [10. Salesforce HTTP Callouts](#10-salesforce-http-callouts)
* [11. Apex Callout Architecture](#11-apex-callout-architecture)
* [12. Why Callouts Should Be Asynchronous](#12-why-callouts-should-be-asynchronous)
* [13. Named Credentials](#13-named-credentials)
* [14. Authentication vs Authorisation](#14-authentication-vs-authorisation)
* [15. Auth Providers](#15-auth-providers)
* [16. Callouts and Salesforce Transactions](#16-callouts-and-salesforce-transactions)
* [17. Handling External System Failures](#17-handling-external-system-failures)
* [18. Integration Status Tracking](#18-integration-status-tracking)
* [19. Retry Strategy](#19-retry-strategy)
* [20. Idempotency](#20-idempotency)
* [21. Salesforce Connect and External Objects](#21-salesforce-connect-and-external-objects)
* [22. Copy Data vs Access Data](#22-copy-data-vs-access-data)
* [23. Integration Patterns](#23-integration-patterns)
* [24. Point-to-Point Integration](#24-point-to-point-integration)
* [25. Middleware-Based Integration](#25-middleware-based-integration)
* [26. Synchronous vs Asynchronous Integration](#26-synchronous-vs-asynchronous-integration)
* [27. Integration Architecture Scenarios](#27-integration-architecture-scenarios)
* [28. External Recruitment Integration](#28-external-recruitment-integration)
* [29. API Contract](#29-api-contract)
* [30. CandidateSyncQueueable](#30-candidatesyncqueueable)
* [31. Error Handling](#31-error-handling)
* [32. Security Principles](#32-security-principles)
* [33. Integration Reliability](#33-integration-reliability)
* [34. Mini Project](#34-mini-project)
* [35. Recommended Repository Structure](#35-recommended-repository-structure)
* [36. GitHub Evidence](#36-github-evidence)
* [37. Pod Code Review](#37-pod-code-review)
* [38. Interview Preparation](#38-interview-preparation)
* [39. Key Engineering Principles](#39-key-engineering-principles)
* [40. Final Architecture](#40-final-architecture)
* [41. Sprint Summary](#41-sprint-summary)

---

# 1. Learning Outcomes

By completing this sprint, you should be able to:

* Explain why Salesforce integrations are required in enterprise applications.
* Understand the basic concept of an API.
* Explain REST APIs using practical business scenarios.
* Understand HTTP methods such as:

  * GET
  * POST
  * PUT
  * PATCH
  * DELETE
* Understand API request and response structures.
* Read and work with JSON.
* Perform a basic Salesforce HTTP callout from Apex.
* Understand why callouts should not be mixed carelessly with database operations in the same transaction.
* Understand the purpose of Named Credentials.
* Explain authentication at a practical level.
* Distinguish authentication from authorisation.
* Understand Auth Providers.
* Understand Salesforce Connect and External Objects.
* Compare point-to-point and middleware-based integrations.
* Decide when integration should be synchronous or asynchronous.
* Design an external recruitment integration.
* Handle failures, retries and duplicate processing.
* Track integration status.
* Document an API contract.
* Explain Salesforce integration concepts during technical interviews.

---

# 2. Business Problem

The Placement Management System already allows students to:

* View their profiles
* View eligible jobs
* Apply for jobs
* View applications
* Update information

Placement Officers can:

* Manage jobs
* Monitor applications
* Process offers

Internally, the application uses:

```text
Lightning Web Components
        ↓
Apex Services
        ↓
Triggers
        ↓
Queueable Apex
        ↓
Batch Apex
        ↓
Salesforce Database
```

However, one of the recruiting companies uses its own recruitment platform.

The new business requirement is:

> When a student is selected, Salesforce should automatically send the candidate information to the company's recruitment platform.

There is also a reverse communication requirement:

> When the external company updates an interview result, Salesforce should receive that information.

Therefore, the application must cross the Salesforce boundary:

```text
Salesforce
    ↕
External Recruitment System
```

The PDF describes this as the transition from an application operating entirely within Salesforce to one that must communicate with an external system.

---

# 3. Why Salesforce Integrations Are Required

Enterprise applications rarely exist in isolation.

A Salesforce implementation may need to communicate with:

* Recruitment platforms
* ERP systems
* HR systems
* Finance systems
* University systems
* Analytics platforms
* External identity providers
* Other business applications

Two systems cannot simply access each other's internal databases.

Instead, they require an agreed communication mechanism.

That mechanism is commonly an **API**.

The systems need an agreed:

* Language
* Vocabulary
* Request structure
* Response structure
* Authentication mechanism
* Error-handling mechanism

The important principle is:

```text
External System
      ↓
Integration Contract
      ↓
Salesforce
```

The external system does not need to understand how Salesforce internally stores its data.

It only needs to understand the agreed integration contract.

---

# 4. APIs

## What Is an API?

API stands for:

**Application Programming Interface**

For this module, the most useful definition is:

> An API is a contract that allows software systems to communicate with each other.

For example, an external recruitment platform might expose:

```http
POST /candidates
```

and expect:

```json
{
  "name": "Ananya",
  "email": "ananya@example.com",
  "branch": "CSE",
  "cgpa": 8.4
}
```

Salesforce sends the request.

The external system processes it.

The external system returns a response.

```text
Salesforce
    |
    | Request
    ↓
External API
    |
    | Response
    ↓
Salesforce
```

The two systems do not need to know each other's internal implementation.

They only need to follow the agreed contract.

---

# 5. REST APIs

REST is one of the most common styles used for web APIs.

REST-based APIs commonly use HTTP.

Salesforce can communicate with REST APIs using HTTP requests.

Example endpoints:

```http
GET /jobs
GET /jobs/123
POST /applications
PATCH /applications/123
```

The HTTP method communicates the intended operation.

---

# 6. HTTP Methods

| Method | Typical Meaning             |
| ------ | --------------------------- |
| GET    | Retrieve data               |
| POST   | Create or process something |
| PUT    | Replace/update a resource   |
| PATCH  | Partially update a resource |
| DELETE | Remove a resource           |

These are standard mental models. Individual APIs may define their own conventions.

### Example

```http
GET /jobs
```

Could retrieve available jobs.

```http
POST /applications
```

Could create a new application.

```http
PATCH /applications/123
```

Could partially update application `123`.

---

# 7. Request and Response Structure

An API interaction normally consists of two parts:

## Request

The caller sends:

* URL
* HTTP method
* Headers
* Authentication information
* Optional request body

Conceptually:

```text
REQUEST
-------
Method
URL
Headers
Authentication
Body
```

## Response

The server returns:

* Status code
* Headers
* Optional response body

```text
RESPONSE
--------
Status Code
Headers
Body
```

Complete flow:

```text
Salesforce
    |
    | Method
    | URL
    | Headers
    | Authentication
    | Body
    ↓
External System
    |
    | Status Code
    | Headers
    | Body
    ↓
Salesforce
```

---

# 8. HTTP Status Codes

The external system communicates the result of the request through an HTTP status code.

| Status Code | Meaning                                  |
| ----------- | ---------------------------------------- |
| 200         | Successful request                       |
| 201         | Resource successfully created            |
| 204         | Successful request with no response body |
| 400         | Bad request                              |
| 401         | Authentication required/failed           |
| 403         | Forbidden                                |
| 404         | Resource not found                       |
| 500         | Server-side error                        |

Integration code should interpret these responses instead of assuming that every request succeeds.

For example:

```text
200 → Success
201 → Created
400 → Invalid request
401 → Authentication problem
403 → Permission problem
404 → Resource unavailable
500 → External server problem
```

---

# 9. JSON

Modern APIs frequently exchange data using JSON.

Example:

```json
{
  "studentId": "STU10045",
  "name": "Ananya",
  "email": "ananya@example.com",
  "cgpa": 8.4,
  "branch": "CSE"
}
```

JSON consists of:

* Keys
* Values
* Objects
* Arrays

Another example:

```json
{
  "jobId": "JOB1007",
  "company": "KSquare",
  "role": "Salesforce Developer",
  "location": "Hyderabad",
  "eligibleBranches": [
    "CSE",
    "IT",
    "AIML"
  ],
  "minimumCgpa": 7.0
}
```

Here:

```text
jobId              → String
company            → String
role               → String
location           → String
eligibleBranches   → Array
minimumCgpa        → Number
```

The key engineering lesson is:

> Understand the data structure before writing integration code.

---

# 10. Salesforce HTTP Callouts

Salesforce provides Apex classes for making HTTP requests to external systems.

The basic conceptual flow is:

```text
HttpRequest
     ↓
Configure Request
     ↓
Http
     ↓
send()
     ↓
HttpResponse
```

Basic Apex example:

```apex
HttpRequest request = new HttpRequest();

request.setEndpoint(
    'callout:Recruitment_API/candidates'
);

request.setMethod('POST');

request.setHeader(
    'Content-Type',
    'application/json'
);

request.setBody(
    JSON.serialize(candidate)
);

Http http = new Http();

HttpResponse response =
    http.send(request);
```

The purpose of each component is:

| Component      | Responsibility                           |
| -------------- | ---------------------------------------- |
| `HttpRequest`  | Represents what Salesforce wants to send |
| Endpoint       | Identifies where the request goes        |
| Method         | Defines the requested operation          |
| Headers        | Provides additional request information  |
| Body           | Contains the data being sent             |
| `Http`         | Performs the HTTP request                |
| `HttpResponse` | Contains the external system response    |

The PDF specifically presents `HttpRequest`, endpoint, method, headers, body, `Http.send()` and `HttpResponse` as concepts that developers should be able to explain individually.

---

# 11. Apex Callout Architecture

A recommended architecture for the recruitment use case is:

```text
Application Status
        ↓
     Selected?
        ↓
     Trigger
        ↓
     Service
        ↓
Queueable Apex
        ↓
   HTTP Callout
        ↓
Named Credential
        ↓
External REST API
        ↓
Process Response
        ↓
Integration Status
```

Each layer should have a clear responsibility.

### Trigger

Detects the business event.

### Service

Contains business logic.

### Queueable

Moves secondary work into background processing.

### Callout

Communicates with the external system.

### Named Credential

Manages endpoint/authentication configuration.

### Response Processing

Interprets success and failure.

---

# 12. Why Callouts Should Be Asynchronous

Suppose a student is selected.

The immediate business transaction is:

```text
Application → Selected
```

The external synchronization is secondary.

The student should not necessarily have to wait for the external recruitment platform.

Therefore:

```text
Student Selected
      ↓
Trigger
      ↓
Service
      ↓
Queueable
      ↓
External API
```

Queueable Apex is useful because it allows the external communication to happen separately from the immediate Salesforce transaction.

This connects the concepts:

```text
Trigger
   ↓
Detect business event

Service
   ↓
Apply business logic

Queueable
   ↓
Perform background work

Callout
   ↓
Communicate externally
```

The PDF emphasizes that this is how enterprise architecture develops by combining concepts learned across different areas of Salesforce development.

---

# 13. Named Credentials

## Why Credentials Should Not Be Hard-Coded

Never place credentials directly in Apex.

Bad example:

```apex
request.setHeader(
    'Authorization',
    'Bearer abc123...'
);
```

Hard-coded credentials can:

* Leak into Git
* Appear in code reviews
* Be copied accidentally
* Become difficult to rotate
* Create security risks

The PDF explicitly identifies hard-coded URLs, usernames, passwords and tokens as configuration that should not be embedded directly in source code.

---

## What Is a Named Credential?

A Named Credential can be thought of as managed Salesforce configuration for:

* External endpoint
* Authentication configuration
* Callout connection details

Instead of putting configuration into Apex:

```text
Apex
  ↓
Named Credential
  ↓
Authentication
  ↓
External API
```

Apex can focus on:

> What API operation should I perform?

rather than:

> Where should I store this secret?

---

## Configuration vs Business Code

A well-designed integration separates configuration from business code.

Configuration may differ across:

```text
Development
     ↓
Testing
     ↓
Production
```

The business logic should not need to change simply because the external endpoint or authentication configuration changes.

---

# 14. Authentication vs Authorisation

These two concepts must not be confused.

## Authentication

Answers:

> **Who are you?**

Example:

```text
Identity Card → Identifies Sumit
```

## Authorisation

Answers:

> **What are you allowed to do?**

Example:

```text
Sumit is authenticated.

Permissions:
✓ Enter laboratory
✗ Enter server room
```

Therefore:

```text
Authentication
     ↓
Who are you?

Authorisation
     ↓
What are you allowed to do?
```

### HTTP Example

A `401` response should generally lead you to investigate authentication.

A `403` response may indicate that the authenticated identity does not have sufficient permission.

The exact behaviour depends on the API, but the distinction is fundamental.

---

# 15. Auth Providers

An Auth Provider can help Salesforce handle authentication with supported external identity providers.

The architectural relationship described in this sprint is:

```text
External Identity Provider
          ↓
     Auth Provider
          ↓
Salesforce Authentication Configuration
          ↓
    Named Credential
          ↓
      Apex Callout
          ↓
      External API
```

The exact configuration depends on:

* External provider
* Authentication protocol
* Integration requirements

The important point is that Named Credentials are not simply "a place to store a password." Salesforce provides more sophisticated authentication and credential-management capabilities.

---

# 16. Callouts and Salesforce Transactions

Salesforce places restrictions around callouts and uncommitted database work.

A problematic pattern can involve:

```text
DML
 ↓
HTTP Callout
```

inside the same inappropriate synchronous transaction sequence.

A cleaner architecture is often:

```text
Immediate Salesforce Transaction
        ↓
Commit Essential Salesforce Work
        ↓
Queueable
        ↓
HTTP Callout
```

This provides a separation between:

**Business Commitment**

and

**External Communication**

The Salesforce transaction should establish the essential business truth.

The external system can then be updated asynchronously.

This reduces the risk of an external dependency unnecessarily blocking the primary Salesforce operation.

---

# 17. Handling External System Failures

External systems can fail.

Example:

```text
Salesforce
    ↓
External API
    X
Unavailable
```

The student's selection should not necessarily disappear because the external system is unavailable.

There are two separate truths:

```text
Salesforce Business Event
        ↓
Selection succeeded

External Synchronisation
        ↓
Failed
```

Therefore:

```text
Salesforce Success
       ≠
External System Success
```

The integration layer needs to track and reconcile these states.

---

# 18. Integration Status Tracking

A useful integration status field can contain:

```text
Pending
Sent
Failed
Retry Required
```

Example Salesforce fields:

| Field                   | Purpose                                 |
| ----------------------- | --------------------------------------- |
| `Integration_Status__c` | Current synchronization state           |
| External Reference      | ID returned by external system          |
| Last Attempt            | Timestamp of latest integration attempt |
| Error Message           | Details of the latest failure           |

Example lifecycle:

```text
Selected
   ↓
Pending
   ↓
Queueable
   ↓
Success
   ↓
Sent
```

Failure path:

```text
Selected
   ↓
Pending
   ↓
Queueable
   ↓
Failure
   ↓
Retry Required
```

This allows administrators and developers to identify what happened.

---

# 19. Retry Strategy

An external API may temporarily return:

```http
500 Internal Server Error
```

This does not necessarily mean the candidate should be permanently marked as failed.

The external system may recover.

A retry strategy can therefore be introduced.

Example:

```text
Pending
   ↓
Attempt 1
   ↓
500 Error
   ↓
Retry Required
   ↓
Attempt 2
   ↓
Success
   ↓
Sent
```

However, retrying introduces another problem:

> Duplicate processing.

If the same candidate is submitted multiple times, the external system might create multiple candidate records.

Therefore:

```text
Retry
  +
Idempotency
```

must be considered together.

---

# 20. Idempotency

Idempotency means designing an operation so that repeated execution does not unintentionally create duplicate business effects.

Consider:

```text
Salesforce
    ↓
Send Candidate
    ↓
External API
```

The API fails after creating the candidate but before Salesforce receives the response.

Salesforce retries.

Now:

```text
Attempt 1 → Candidate Created
Attempt 2 → Candidate Created Again
```

This may create duplicates.

Therefore the integration needs a way to identify the same business transaction.

Possible approaches include:

* External reference ID
* Salesforce Application ID
* Idempotency key
* Existing-record lookup
* Synchronisation status

The team should identify which value uniquely represents the candidate submission.

---

# 21. Salesforce Connect and External Objects

Not every integration requires copying external data into Salesforce.

Sometimes the requirement is:

> Allow Salesforce users to access external information without storing all of it inside Salesforce.

This is where:

* Salesforce Connect
* External Objects

become relevant.

Conceptually:

```text
External System
       ↓
External Object
       ↓
Salesforce UI
```

The data remains primarily in the external system.

Salesforce provides a mechanism for users and applications to work with that external information.

---

# 22. Copy Data vs Access Data

This is an important architecture decision.

## Option A — Copy Data

```text
External System
       ↓
Integration
       ↓
Salesforce Records
```

### Advantages

* Salesforce-native reporting
* Salesforce automation
* Local data access
* Easier use by Salesforce processes

### Costs

* Data duplication
* Synchronisation complexity
* Storage requirements
* Risk of stale data

---

## Option B — Access External Data

```text
External System
       ↑
External Object
       ↑
Salesforce User
```

### Advantages

* Less data duplication
* External data can be accessed without copying everything

### Considerations

* Query limitations
* Latency
* External-system dependency
* Different reporting capabilities
* Different automation capabilities

---

## Architecture Decision Factors

The correct approach depends on:

* Data ownership
* Data volume
* Latency
* Reporting requirements
* Security
* Integration requirements
* Business criticality

For example, a company with **10 million historical recruitment records** may not want to copy all records into Salesforce if users only need authorised access to selected external information.

---

# 23. Integration Patterns

The sprint introduces two major integration patterns:

1. Point-to-point
2. Middleware-based

The choice depends on the number of systems and the complexity of communication.

---

# 24. Point-to-Point Integration

In point-to-point integration, Salesforce communicates directly with the external system.

```text
Salesforce
     ↕
Company System
```

This is simple when there is only one external system.

For example:

```text
Salesforce ↔ Recruitment
```

However, complexity grows as systems are added.

Example:

```text
Salesforce ↔ HR
Salesforce ↔ Recruitment
Salesforce ↔ Finance
Salesforce ↔ University
Salesforce ↔ Analytics
```

Multiple direct integrations can make the architecture increasingly difficult to manage.

---

# 25. Middleware-Based Integration

Middleware introduces an integration platform between Salesforce and external systems.

```text
Salesforce
     ↕
 Middleware
     ↕
External Systems
```

Middleware may handle:

* Transformation
* Routing
* Orchestration
* Monitoring
* Retries
* Protocol conversion

The sprint mentions **MuleSoft** as a preferred skill, but the objective here is to understand why middleware exists rather than become a MuleSoft expert.

### Architectural Principle

> Integration architecture should scale with the number of systems.

For one external system:

```text
Point-to-point
```

may be appropriate.

For many systems:

```text
Middleware
```

may become more attractive.

---

# 26. Synchronous vs Asynchronous Integration

Integration architecture should also consider whether the user needs an immediate response.

## Synchronous

```text
Salesforce
     ↓
External API
     ↓
Response
     ↓
Salesforce
```

The user may wait for the external system.

Use this when the immediate response is genuinely required.

### Example

A student enters a certification number and Salesforce must immediately verify it.

```text
LWC
 ↓
Apex
 ↓
External API
 ↓
Response
 ↓
LWC
```

Synchronous processing makes sense because the user needs the answer immediately.

---

## Asynchronous

```text
Salesforce
     ↓
Queueable
     ↓
External API
```

The user does not wait.

This is appropriate when the integration is secondary or can safely happen later.

### Example

When a student is selected:

```text
Application Selected
       ↓
Queueable
       ↓
External Recruitment API
```

The student does not need to wait for the external system.

---

# 27. Integration Architecture Scenarios

## Scenario A — Immediate Verification

### Requirement

When a student enters a certification number, Salesforce must verify it against an external service.

### Architecture

```text
LWC
 ↓
Apex
 ↓
External API
 ↓
Response
 ↓
LWC
```

### Pattern

**Synchronous**

### Reason

The user needs the answer immediately.

---

## Scenario B — Candidate Synchronisation

### Requirement

When a student is selected, send candidate information to the external recruitment platform.

### Architecture

```text
Trigger
 ↓
Queueable
 ↓
External API
```

### Pattern

**Asynchronous**

### Reason

The external synchronization is secondary to the primary Salesforce business transaction.

---

## Scenario C — Historical Synchronisation

### Requirement

Every night Salesforce must process 200,000 external records.

### Recommended concepts

```text
Scheduled Apex
      ↓
Batch Apex
      ↓
Integration
      ↓
Error Handling
      ↓
Retry Strategy
```

A 200,000-record synchronization should not be implemented as one synchronous user request.

---

# 28. External Recruitment Integration

The primary mini-project in this sprint is an **External Recruitment Gateway**.

## Business Requirement

When an application becomes selected:

```text
Application
    ↓
Queueable
    ↓
External API
```

Candidate information should be sent to the external recruitment platform.

---

## Candidate Data

The integration should send:

* Student ID
* Name
* Email
* Branch
* CGPA
* Job ID
* Company
* Role
* Selection Date

---

## Architecture

```text
Application Status
       ↓
    Selected?
       ↓
    Queueable
       ↓
Build Request
       ↓
Named Credential
       ↓
REST API
       ↓
Process Response
       ↓
Integration Status
```

The PDF specifies this flow as the core external recruitment integration exercise.

---

# 29. API Contract

Before writing code, define the API contract.

The API contract should document:

### Endpoint

```http
POST /candidates
```

### Request Body

Define the JSON structure.

Example:

```json
{
  "studentId": "STU10045",
  "name": "Ananya",
  "email": "ananya@example.com",
  "branch": "CSE",
  "cgpa": 8.4,
  "jobId": "JOB1007",
  "company": "KSquare",
  "role": "Salesforce Developer",
  "selectionDate": "2026-08-13"
}
```

### Response

Define the expected success response.

Example conceptual response:

```json
{
  "success": true,
  "externalCandidateId": "EXT-10001"
}
```

### Error Responses

Document expected failures:

```text
400
401
403
500
Unexpected response
```

The API contract should become part of the project documentation.

---

# 30. CandidateSyncQueueable

Create a Queueable Apex class:

```text
CandidateSyncQueueable
```

Its responsibility is:

> Send the selected candidate to the external recruitment system.

Do not put external integration logic directly inside:

* Trigger
* Lightning Web Component

Keep responsibilities separated.

Recommended architecture:

```text
Trigger
   ↓
Service
   ↓
CandidateSyncQueueable
   ↓
Callout Service
   ↓
Named Credential
   ↓
External API
```

---

# 31. Error Handling

The integration should distinguish between different response categories.

At minimum:

```text
Success
Authentication Failure
Bad Request
Server Error
Unexpected Response
```

Example:

```text
200 / 201
    ↓
Success

400
    ↓
Bad Request

401
    ↓
Authentication Failure

403
    ↓
Permission Failure

500
    ↓
Server Error

Anything unexpected
    ↓
Unexpected Response
```

Do not reduce every failure to:

```text
Something went wrong.
```

The external system has provided information that should be interpreted.

---

# 32. Security Principles

Security is a major part of integration engineering.

## Never hard-code secrets

Avoid:

```apex
String token = 'abc123';
```

Avoid hard-coded:

* Passwords
* Access tokens
* API secrets
* Credentials

## Use Named Credentials

Use:

```text
Apex
 ↓
Named Credential
 ↓
Authentication
 ↓
External API
```

## Separate Configuration From Code

External URLs and authentication mechanisms may differ between:

```text
Development
Testing
Production
```

The code should not need unnecessary changes simply because configuration changes.

---

# 33. Integration Reliability

A reliable integration must be designed for failure.

Do not assume:

```text
Request sent
     ↓
Always succeeds
```

Instead, ask:

* What if the request is invalid?
* What if authentication fails?
* What if the resource does not exist?
* What if the external server is down?
* What if the response takes too long?
* What if the same request is sent twice?
* What if the external system changes?
* What if the response format is unexpected?

Integration engineering requires designing for reality.

Important reliability concerns include:

```text
Timeouts
Errors
Authentication
Retries
Duplicates
Monitoring
Data Ownership
Contracts
```

---

# 34. Mini Project

## External Recruitment Gateway

Implement a prototype that satisfies the following requirements.

### 1. Send Selected Candidates

When an Application becomes `Selected`:

```text
Application
    ↓
Queueable
    ↓
External API
```

---

### 2. Track Integration Status

Create appropriate fields such as:

```text
Integration Status
External Candidate Id
Last Integration Attempt
Integration Error
```

Example:

```text
Pending
Sent
Failed
Retry Required
```

---

### 3. Use Named Credentials

The integration must not contain hard-coded secrets.

```text
❌ Username in Apex
❌ Password in Apex
❌ Access Token in Apex
❌ API Secret in Apex

✓ Named Credential
```

---

### 4. Handle Responses

At minimum handle:

```text
Success
400
401
403
500
Unexpected Error
```

---

### 5. Handle Retry Thinking

Document:

> What happens if the external system is temporarily unavailable?

Example:

```text
Attempt
  ↓
Failure
  ↓
Retry Required
  ↓
Retry
  ↓
Success
```

---

### 6. Prevent Duplicates

Document:

> What uniquely identifies this candidate submission?

Possible identifiers:

```text
Application Id
External Reference
Idempotency Key
Salesforce Candidate Id
```

---

### 7. Document the API Contract

The project README/API documentation should contain:

* Endpoint
* HTTP method
* Request JSON
* Response JSON
* Authentication approach
* Error handling
* Retry strategy
* Idempotency strategy
* Mock API details, if a real external API is not being used

---

# 35. Recommended Repository Structure

The sprint recommends a repository structure similar to:

```text
Sprint-11-Integration/
│
├── README.md
│
├── architecture/
│   ├── integration-flow.png
│   ├── sequence-diagram.png
│   └── integration-pattern.png
│
├── force-app/
│   └── ...
│
├── api-contract/
│   └── candidate-api.md
│
├── screenshots/
│   └── ...
│
└── learning-notes/
    └── sprint-11.md
```

This structure keeps:

* Architecture documentation
* Salesforce source code
* API contract
* Evidence/screenshots
* Learning notes

separated and easy to understand.

---

# 36. GitHub Evidence

The repository README should clearly answer:

## Business Problem

Why does the integration exist?

## External System

What does the external system provide?

## Data Flow

How does data travel?

```text
Salesforce
 ↓
Trigger
 ↓
Service
 ↓
Queueable
 ↓
Named Credential
 ↓
REST API
 ↓
External System
```

## Authentication

How is the external system authenticated?

## Error Handling

What happens when the API fails?

## Retry

What happens next?

## Idempotency

How are duplicate submissions prevented?

## Integration Pattern

Why was point-to-point or middleware selected?

## Synchronous vs Asynchronous

Why was the selected approach appropriate?

These topics should be explicitly documented in the project README.

---

# 37. Pod Code Review

Conduct a 25-minute integration review.

Suggested responsibilities:

| Role              | Responsibility                  |
| ----------------- | ------------------------------- |
| Presenter         | Explains the integration        |
| Interviewer       | Asks technical questions        |
| Security Reviewer | Reviews authentication/security |
| Apex Reviewer     | Reviews Apex architecture       |
| Failure Reviewer  | Reviews error/retry handling    |

Questions to discuss:

* Why Queueable?
* Why Named Credential?
* What happens if the API is down?
* What happens if the same request executes twice?
* What happens if the API returns 401?
* What happens if the API returns 500?
* Why not store external data directly?
* Why not use Salesforce Connect?

The presenter should be able to defend the architectural decisions.

---

# 38. Interview Preparation

## Q1. What is an API?

An API is a contract that allows software systems to communicate with each other without exposing their internal implementation.

---

## Q2. What is REST?

REST is a common style of web API communication that commonly uses HTTP methods and resources.

---

## Q3. What is the difference between GET and POST?

```text
GET
→ Typically retrieves data.

POST
→ Typically creates or processes something.
```

---

## Q4. What is JSON?

JSON is a structured data format commonly used by APIs to exchange information.

It contains:

* Objects
* Keys
* Values
* Arrays

---

## Q5. What is an HTTP status code?

It is a response signal from the server indicating the result of an HTTP request.

Examples:

```text
200 → Success
201 → Created
400 → Bad Request
401 → Authentication failure
403 → Forbidden
500 → Server Error
```

---

## Q6. What is a Salesforce callout?

A Salesforce callout is a request from Salesforce/Apex to an external system.

---

## Q7. Why should credentials not be hard-coded?

Because secrets in source code can:

* Leak into Git
* Appear in reviews
* Be copied accidentally
* Be difficult to rotate
* Create security risks

---

## Q8. What is a Named Credential?

A Named Credential provides managed Salesforce configuration for an external endpoint and its authentication setup.

---

## Q9. Authentication vs Authorisation?

```text
Authentication → Who are you?

Authorisation → What are you allowed to do?
```

---

## Q10. What is an Auth Provider?

An Auth Provider helps Salesforce handle authentication with supported external identity providers.

---

## Q11. When would you use Salesforce Connect and External Objects?

When Salesforce users need to access external data without necessarily copying all of that data into Salesforce.

---

## Q12. What is point-to-point integration?

A direct connection between Salesforce and an external system.

```text
Salesforce ↔ External System
```

---

## Q13. Why might middleware be useful?

Middleware can centralise:

* Transformation
* Routing
* Orchestration
* Monitoring
* Retry
* Protocol conversion

It becomes particularly useful as the number of systems increases.

---

## Q14. When would you prefer asynchronous integration?

When the user does not need the external response immediately and the integration can safely happen in the background.

Example:

```text
Student Selected
     ↓
Queueable
     ↓
External Recruitment API
```

---

## Q15. What is idempotency and why does it matter?

Idempotency helps ensure repeated execution of the same business operation does not unintentionally create duplicate effects.

It is particularly important when retrying asynchronous integrations.

---

# 39. Interview Scenario

### Question

> When an Opportunity becomes Closed Won, Salesforce must send the customer information to an external ERP. The user should not wait for the ERP. Design the solution.

### Strong Architecture

```text
Opportunity Update
        ↓
Trigger / Service
        ↓
Queueable
        ↓
Named Credential
        ↓
REST Callout
        ↓
External ERP
        ↓
Response
        ↓
Integration Status
```

Then discuss:

* Authentication
* Failure handling
* Retry
* Duplicate processing
* Monitoring
* Integration status

A strong integration answer should go beyond simply saying:

> "Use a REST API."

It should explain the complete architecture and failure strategy.

---

# 40. Final Architecture

The complete Placement Management System now follows an enterprise-style architecture:

```text
                    Students
                       │
                       ▼
             Lightning Web Components
                       │
                       ▼
                 Apex Services
                       │
              ┌────────┴────────┐
              │                 │
              ▼                 ▼
          Salesforce        Async Apex
           Database       Queueable/Batch
              │                 │
              │                 ▼
              │            External APIs
              │                 │
              │                 ▼
              │          External Systems
              │
              ▼
           Triggers
```

More specifically for candidate synchronization:

```text
┌───────────────────────┐
│ Student Application   │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│ Application Selected  │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│ Trigger / Service     │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│ Queueable Apex        │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│ Build JSON Request    │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│ Named Credential      │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│ External REST API     │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│ Process Response      │
└───────────┬───────────┘
            │
       ┌────┴─────┐
       │          │
       ▼          ▼
   Success      Failure
       │          │
       ▼          ▼
     Sent    Retry Required
```

The overall architectural lesson is:

```text
Business Event
      ↓
Business Logic
      ↓
Asynchronous Processing
      ↓
Secure Integration
      ↓
External System
      ↓
Response Handling
      ↓
Integration State
      ↓
Retry / Reconciliation
```

---

# 41. Key Engineering Principles

## 1. API Is a Contract

An API defines how independent systems communicate.

---

## 2. Do Not Depend on Internal Implementation

Salesforce and the external system only need to understand the integration contract.

---

## 3. Never Hard-Code Credentials

Use appropriate Salesforce authentication and credential-management mechanisms.

---

## 4. Separate Configuration From Business Logic

Endpoints and authentication configuration should not become business code.

---

## 5. Separate Business Commitment From External Communication

When appropriate:

```text
Salesforce Transaction
        ↓
Commit Business Truth
        ↓
Queueable
        ↓
External Communication
```

---

## 6. Design for Failure

Assume the external system can be:

* Slow
* Unavailable
* Incorrectly configured
* Overloaded
* Changed
* Authenticated differently
* Returning unexpected data

---

## 7. Track Integration State

Do not assume that Salesforce success means external-system success.

Track:

```text
Pending
Sent
Failed
Retry Required
```

---

## 8. Retries Require Idempotency

Retrying without duplicate protection can create duplicate records.

---

## 9. Choose Data Ownership Carefully

Decide whether data should:

```text
Be copied into Salesforce
```

or:

```text
Remain in the external system
```

based on business and technical requirements.

---

## 10. Architecture Should Scale

One external system may work well with point-to-point integration.

Many systems may justify middleware.

---

## 11. Choose Synchronous vs Asynchronous Based on Business Need

Use synchronous processing when an immediate answer is required.

Use asynchronous processing when the integration can safely happen later.

---

# Sprint 11 Checklist

Use this checklist to verify that the integration module is complete.

* [ ] Understand what an API is
* [ ] Understand REST
* [ ] Understand GET
* [ ] Understand POST
* [ ] Understand PUT
* [ ] Understand PATCH
* [ ] Understand DELETE
* [ ] Understand request structure
* [ ] Understand response structure
* [ ] Understand HTTP status codes
* [ ] Understand JSON
* [ ] Understand Apex HTTP callouts
* [ ] Understand `HttpRequest`
* [ ] Understand `HttpResponse`
* [ ] Understand `Http.send()`
* [ ] Understand Queueable-based callouts
* [ ] Understand Named Credentials
* [ ] Understand Auth Providers
* [ ] Understand authentication
* [ ] Understand authorisation
* [ ] Understand callout/transaction considerations
* [ ] Implement integration status tracking
* [ ] Design retry handling
* [ ] Understand idempotency
* [ ] Understand Salesforce Connect
* [ ] Understand External Objects
* [ ] Compare copy-data vs access-data approaches
* [ ] Understand point-to-point integration
* [ ] Understand middleware
* [ ] Compare synchronous and asynchronous integration
* [ ] Define an API contract
* [ ] Build the CandidateSyncQueueable concept
* [ ] Handle success and error responses
* [ ] Document security decisions
* [ ] Document retry strategy
* [ ] Document idempotency strategy
* [ ] Add architecture diagrams
* [ ] Add screenshots/evidence
* [ ] Prepare for integration interview questions

---

# Final Takeaway

The most important lesson of this sprint is that Salesforce integration is **not simply about making an HTTP request**.

A production-quality integration must consider:

```text
API Contract
     +
Authentication
     +
Authorisation
     +
Security
     +
Transactions
     +
Asynchronous Processing
     +
Error Handling
     +
Retries
     +
Idempotency
     +
Monitoring
     +
Data Ownership
     +
Integration Architecture
```

The Salesforce application has now crossed its boundary:

```text
Before:

Salesforce
   │
   └── Application

After:

Salesforce
   ↕
External Systems
```

Inside Salesforce, developers control much of the environment.

Outside Salesforce, the external system may behave unexpectedly.

Therefore, integration engineering requires designing for reality rather than assuming that every API call succeeds.

The strongest Salesforce developers understand that:

> **An API call is not merely `http.send(request)` — it is a business conversation between two independent systems.**

Design that conversation carefully.

---

## Sprint 11 Completion

**Module:** Crossing the Salesforce Boundary
**Focus:** Salesforce APIs, REST Integration, Named Credentials & External Systems
**Primary Project:** External Recruitment Gateway
**Core Architecture:** Trigger → Service → Queueable → Named Credential → REST API → Response Handling → Integration Status

This README consolidates the topics and project expectations covered throughout the Sprint 11 source material.
