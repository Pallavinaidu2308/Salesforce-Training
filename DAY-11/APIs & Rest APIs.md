# 🔗 APIs — Application Programming Interfaces

## Overview

An API (Application Programming Interface) is a communication contract that allows two different software systems to exchange data and perform operations.

In Salesforce, APIs are commonly used when Salesforce needs to communicate with external systems such as:

- Recruitment platforms
- ERP systems
- HR systems
- Payment systems
- Banking systems
- Analytics platforms

## Example

In the Placement Management System, Salesforce sends selected student information to an external recruitment platform.

```text
Salesforce
    ↓
    API Request
    ↓
External Recruitment System
    ↓
    API Response
    ↓
Salesforce


---

# 2. REST APIs

```markdown
# 🌐 REST APIs

## Overview

REST (Representational State Transfer) is a common architectural style for building web APIs.

REST APIs commonly use HTTP to communicate between Salesforce and external systems.

## Example Endpoints

```http
GET /jobs
GET /jobs/1001
POST /candidates
PATCH /candidates/1001
DELETE /candidates/1001
