
# 🚀 Day 11 — Salesforce Placement Application & Candidate Integration

<div align="center">

![Salesforce](https://img.shields.io/badge/Salesforce-Developer-blue?style=for-the-badge&logo=salesforce)
![Apex](https://img.shields.io/badge/Apex-Programming-red?style=for-the-badge)
![LWC](https://img.shields.io/badge/LWC-Lightning%20Web%20Components-orange?style=for-the-badge)
![SOQL](https://img.shields.io/badge/SOQL-Database-blueviolet?style=for-the-badge)
![Testing](https://img.shields.io/badge/Tests-100%25%20Passed-success?style=for-the-badge)
![API](https://img.shields.io/badge/API-v67.0-blue?style=for-the-badge)

### Salesforce Placement Application System

**Day 11 — Application Service, Placement Controller, LWC Job Application Flow & Candidate API Integration**

</div>

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Objectives](#-objectives)
- [Concepts Learned](#-concepts-learned)
- [System Architecture](#-system-architecture)
- [Application Flow](#-application-flow)
- [Project Components](#-project-components)
- [ApplicationService](#-applicationservice)
- [PlacementController](#-placementcontroller)
- [Eligible Jobs LWC](#-eligible-jobs-lwc)
- [Application Validation](#-application-validation)
- [Candidate Synchronization](#-candidate-synchronization)
- [Error Handling](#-error-handling)
- [Duplicate Application Prevention](#-duplicate-application-prevention)
- [CGPA Eligibility](#-cgpa-eligibility)
- [Testing](#-testing)
- [Code Coverage](#-code-coverage)
- [Deployment](#-deployment)
- [Verification](#-verification)
- [Screenshots](#-screenshots)
- [Key Learnings](#-key-learnings)
- [Challenges & Solutions](#-challenges--solutions)
- [Final Result](#-final-result)

---

# 📖 Overview

Day 11 focused on building and verifying the **Salesforce Placement Application System**.

The implementation connects:

- Lightning Web Components
- Apex Controllers
- Apex Service Layer
- Salesforce Custom Objects
- SOQL
- Application validation
- Candidate synchronization
- HTTP Callouts
- Queueable Apex
- Apex Testing
- Code Coverage
- Salesforce Metadata Deployment

The main business flow implemented and verified was:

```text
Eligible Jobs
      ↓
View Job Details
      ↓
Apply for Job
      ↓
ApplicationService
      ↓
Eligibility Validation
      ↓
Duplicate Check
      ↓
Create Application__c
      ↓
Application Status = Applied
