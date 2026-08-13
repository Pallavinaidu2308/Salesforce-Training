
# 🚀 From Developer Org to Production

## Salesforce Engineering Sprint 12

This module explains how to move a Salesforce application from a Developer Org into a professional, source-controlled and deployment-ready development process.

The goal is not only to write Salesforce code, but to understand the complete engineering lifecycle:

```text
Build
  ↓
Version Control
  ↓
Code Review
  ↓
Testing
  ↓
Deployment
  ↓
Verification
  ↓
Production
```

The concepts covered in this module include:

* Git & GitHub
* Branches
* Commits
* Push & Pull
* Pull Requests
* Git Merge Conflicts
* Salesforce Metadata
* Salesforce CLI
* `sf` and `sfdx`
* Org Authentication
* Org Aliases
* Metadata Retrieval
* Metadata Deployment
* Sandboxes
* Scratch Orgs
* Changesets
* Metadata API
* Deployment Dependencies
* Testing Before Deployment
* Deployment Pipeline
* Professional Repository Structure
* Deployment Documentation
* Production Readiness

---

# 📌 1. Why Salesforce Development Needs Version Control

A Salesforce application should not exist only inside a Salesforce Org.

Imagine multiple developers working on the same application:

```text
Developer A → Apex Class
Developer B → Apex Class
Developer C → LWC
Developer D → Trigger
Developer E → Custom Object
```

Without version control, it becomes difficult to answer:

* Who changed the code?
* What exactly changed?
* When was it changed?
* Why was it changed?
* Which version is correct?
* Can the previous version be restored?

Git solves these problems.

### Engineering Principle

> **The Salesforce Org is an environment. The Git repository is the record of development.**

The basic relationship is:

```text
Git Repository
      ↓
Source of Development
      ↓
Deployment
      ↓
Salesforce Org
```

The PDF emphasizes that a professional Salesforce developer should not treat the Org as the only copy of the application.

---

# 📌 2. Git Mental Model

Git manages changes between your local development environment and the shared repository.

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
Remote Repository
```

Another developer can use:

```text
git pull
```

to bring remote changes into their local environment.

---

# 📌 3. Clone

`git clone` downloads an existing repository to your computer.

```bash
git clone <repository-url>
```

### Flow

```text
GitHub Repository
       ↓
    git clone
       ↓
Local Computer
```

This is normally the first step when joining an existing project.

---

# 📌 4. Commit

A commit records a logical set of changes in your local Git history.

Example:

```bash
git commit -m "Add application submission flow"
```

A good commit message should explain **what changed**.

### Good examples

```text
Add placement application object
Add eligibility service
Add application trigger handler
Add eligible jobs LWC
Add application submission workflow
Add candidate sync queueable
```

### Avoid

```text
changes
update
final
done
```

The PDF explains that meaningful commit history becomes a development story and provides engineering evidence during interviews.

---

# 📌 5. Push

`git push` sends your local commits to the remote repository.

```bash
git push
```

### Flow

```text
Local Repository
       ↓
    git push
       ↓
GitHub Repository
```

If you commit but do not push:

```text
Local Repository
       ↓
Commit exists
       ↓
GitHub does NOT have the commit yet
```

---

# 📌 6. Pull

`git pull` brings changes from the remote repository into your local branch.

```bash
git pull
```

### Flow

```text
GitHub Repository
       ↓
    git pull
       ↓
Local Repository
```

If your teammate pushes changes and you do not pull, your local copy may become outdated.

---

# 📌 7. Git Branches

A branch provides an isolated place to work on a feature.

Instead of modifying `main` directly:

```text
main
 │
 ├── feature/student-profile
 │
 ├── feature/job-search
 │
 └── feature/application-workflow
```

After development:

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

### Engineering Principle

> **A branch is a safe place to change things.**

Branches allow changes to be:

* Reviewed
* Tested
* Discussed
* Safely merged

---

# 📌 8. Pull Requests

A Pull Request is used to propose changes before merging them into the main branch.

### Flow

```text
Feature Branch
      ↓
    Commit
      ↓
     Push
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

A reviewer should check:

### Apex

* Is the code bulkified?
* Is the responsibility clear?
* Is SOQL appropriate?
* Is DML outside loops?
* Is error handling present?
* Are tests available?

### LWC

* Is component responsibility clear?
* Is naming meaningful?
* Is loading handled?
* Is error handling present?
* Is business logic duplicated?

### Security

* Are secrets hard-coded?
* Is sharing/security considered?

### Integration

* Are Named Credentials used where appropriate?
* Is failure handling considered?
* Is duplicate processing considered?

---

# 📌 9. Git Merge Conflicts

A merge conflict occurs when Git cannot automatically determine which version of a change should be kept.

Example:

```text
Developer A:
Minimum CGPA = 7.0

Developer B:
Minimum CGPA = 7.5
```

Git cannot determine which business rule is correct.

Therefore:

```text
Git detects conflict
       ↓
Developers inspect code
       ↓
Understand business requirement
       ↓
Choose correct behavior
       ↓
Resolve conflict
       ↓
Test
       ↓
Commit
```

### Important Principle

> **A merge conflict can sometimes be a business conflict in disguise.**

Never blindly choose `ours` or `theirs`. First understand the requirement.

---

# 📌 10. Professional GitHub Repository Structure

The PDF recommends a professional structure such as:

```text
placement-management-system/
│
├── README.md
│
├── force-app/
│   └── main/
│       └── default/
│
├── docs/
│   ├── architecture/
│   ├── api/
│   └── deployment/
│
├── scripts/
│
└── .gitignore
```

For the production-ready project, the structure can be expanded:

```text
placement-management-system/
│
├── README.md
│
├── force-app/
│
├── docs/
│   ├── architecture/
│   ├── api/
│   ├── deployment/
│   └── decisions/
│
├── screenshots/
│
├── tests/
│
└── .gitignore
```

Avoid folders such as:

```text
final/
final2/
final_latest/
final_latest2/
working/
working_new/
```

Git should manage versions instead of filenames.

---

# 📌 11. What Should Be Stored in Git?

Typical Salesforce project artifacts include:

```text
Apex Classes
Triggers
LWC Components
Custom Objects
Fields
Flows
Permission Metadata
Configuration Metadata
Tests
Documentation
Deployment Configuration
```

However, Salesforce business data should not automatically be treated as source code.

Examples:

```text
Student Records
Application Records
Personal Information
```

These are **data**, not automatically source code.

---

# 📌 12. Code vs Metadata vs Data

This distinction is extremely important.

```text
Salesforce Project
       │
       ├── Code
       │    ├── Apex
       │    └── LWC
       │
       ├── Metadata
       │    ├── Objects
       │    ├── Fields
       │    ├── Flows
       │    └── Permissions
       │
       └── Data
            ├── Students
            ├── Applications
            ├── Jobs
            └── Offers
```

### Code

Defines application behavior.

### Metadata

Defines Salesforce configuration and structure.

### Data

Represents actual business records.

The deployment process primarily deals with moving **metadata/source**, while business data requires separate consideration.

---

# 📌 13. Salesforce CLI

Salesforce CLI provides a command-line interface for Salesforce development.

The modern command is:

```bash
sf
```

You may still encounter:

```bash
sfdx
```

in older tutorials and repositories.

The PDF recommends understanding both terms while learning the modern `sf` command structure.

---

# 📌 14. Why Salesforce CLI?

The Salesforce UI is useful for:

* Configuration
* Administration
* Quick inspection

But manually repeating many Setup clicks is difficult to reproduce.

For example:

```text
Setup
  ↓
Object
  ↓
Field
  ↓
Permission
  ↓
Flow
  ↓
Page
```

CLI provides a repeatable development process.

It can help developers:

```text
Authenticate
    ↓
Retrieve Metadata
    ↓
Deploy Metadata
    ↓
Run Tests
    ↓
Inspect Orgs
    ↓
Manage Environments
```

The key principle is:

> **A command is repeatable.**

---

# 📌 15. Salesforce Org Authentication

Before using Salesforce CLI against an Org, authenticate the Org.

The basic workflow is:

```text
Install Salesforce CLI
        ↓
Verify CLI
        ↓
Authenticate Salesforce Org
        ↓
Assign meaningful alias
        ↓
Verify connected Org
```

Always know which Org the CLI is currently connected to.

This becomes especially important when working with:

```text
Development
QA
UAT
Production
```

Accidentally deploying to Production because the CLI is connected to the wrong Org can cause serious problems.

---

# 📌 16. Org Aliases

Instead of repeatedly using a long Salesforce username, meaningful aliases can be used.

Example:

```text
placement-dev
placement-qa
placement-uat
```

Conceptually:

```text
placement-dev → Development Org

placement-qa → QA Org

placement-uat → UAT Org
```

However, an alias should not replace verification.

### Before Deployment

Ask:

```text
Which Org?
Which Branch?
Which Commit?
Which Metadata?
Which Tests?
Who Approved This?
```

This is part of professional environment awareness.

---

# 📌 17. Salesforce Metadata

Salesforce configuration is represented as metadata.

Examples:

```text
Custom Object
      ↓
Metadata

Custom Field
      ↓
Metadata

Flow
      ↓
Metadata

Apex Class
      ↓
Metadata

LWC
      ↓
Source + Metadata
```

The source-driven model is:

```text
Salesforce Configuration
        ↓
Metadata
        ↓
Source Representation
        ↓
Git
```

This allows the same configuration to be moved to another environment instead of manually rebuilding it.

---

# 📌 18. Metadata Retrieval

Retrieval means bringing Salesforce metadata from an Org into your local project.

### Flow

```text
Salesforce Org
      ↓
   Retrieve
      ↓
Local Source
      ↓
     Git
```

After retrieval, developers should inspect the source.

For example:

### Apex

```text
.cls
.trigger
.cls-meta.xml
```

### LWC

```text
.html
.js
.js-meta.xml
```

### Objects

Identify metadata for objects such as:

```text
Job__c
Application__c
Student__c
```

and identify where their fields are represented.

---

# 📌 19. Metadata Deployment

Deployment moves metadata from one environment to another.

```text
Source
   ↓
Deployment
   ↓
Target Org
```

A typical environment progression can be:

```text
Developer
    ↓
QA
    ↓
UAT
    ↓
Production
```

The exact structure varies between organizations, but the principle is controlled progression.

---

# 📌 20. Sandboxes

A Salesforce Sandbox provides a separate environment for development, testing, or other purposes depending on its type and configuration.

Conceptually:

```text
Production
    ↓
Sandbox
```

A team can use environments such as:

```text
Developer
   ↓
QA
   ↓
UAT
   ↓
Production
```

The major purpose is to allow development and testing without directly modifying Production.

---

# 📌 21. Scratch Orgs

A Scratch Org is a temporary, source-driven Salesforce environment.

Think:

```text
Source
  ↓
Scratch Org
  ↓
Develop
  ↓
Test
  ↓
Destroy
```

Scratch Orgs support reproducibility because the environment can be created from defined project configuration.

### Important Principle

> **"Works in my Org" is not enough.**

A professional system should be reproducible:

```text
Source
   ↓
Environment Setup
   ↓
Deploy
   ↓
Test
   ↓
Works
```

rather than:

```text
My Org
   ↓
Magic Configuration
   ↓
Works Somehow
```

---

# 📌 22. Changesets

Changesets are a Salesforce-native mechanism for moving metadata between related Salesforce Orgs.

Typical flow:

```text
Sandbox
   ↓
Outbound Change Set
   ↓
Target Org
```

They can be useful in organizations following traditional Salesforce deployment processes.

They are one deployment approach among several rather than something that should simply be labelled good or bad.

---

# 📌 23. Metadata API

The Metadata API provides programmatic mechanisms for retrieving and deploying Salesforce metadata.

Think:

```text
Salesforce Metadata
       ↕
Deployment / Retrieval
       ↕
Salesforce Org
```

Salesforce CLI can use Salesforce metadata deployment mechanisms underneath the developer experience.

You do not necessarily need to implement the Metadata API yourself; you need to understand its role in the deployment architecture.

---

# 📌 24. Deployment Approach Comparison

| Approach       | Main Purpose                                             |
| -------------- | -------------------------------------------------------- |
| Changesets     | Salesforce-native metadata movement between related Orgs |
| Salesforce CLI | Developer-oriented command-line workflow                 |
| Metadata API   | Programmatic metadata deployment/retrieval mechanism     |
| Scratch Orgs   | Temporary source-driven development environments         |
| Sandboxes      | Longer-lived development/testing/UAT environments        |

### Choosing an Approach

```text
Modern Git-Based Workflow
        ↓
Salesforce CLI + Source Control

Traditional Admin-Led Process
        ↓
Changesets

Temporary Isolated Development
        ↓
Scratch Org

Testing Before Production
        ↓
Sandbox / Controlled Environment
```

The PDF notes that more than one answer can be reasonable depending on the organization's development model.

---

# 📌 25. Deployment Is More Than "Push Code"

A Salesforce application contains many components:

```text
Apex
LWC
Custom Objects
Fields
Flows
Permissions
Named Credentials
```

You cannot always deploy one file independently.

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

If the LWC depends on an Apex class or metadata that does not exist in the target Org, deployment or functionality can fail.

### Engineering Principle

> **Deploy the system, not just the file.**

Always ask:

```text
What does this component depend on?
             ↓
Does the target environment have those dependencies?
```

---

# 📌 26. Testing Before Deployment

Never deploy simply because:

> "It worked yesterday."

Before deployment, consider:

```text
Apex Tests
Functional Tests
Integration Tests
LWC Testing where applicable
Permission Checks
Deployment Validation
Regression Testing
```

The deployment rules and test requirements can depend on the deployment type and target environment.

For Production, Apex test execution and coverage are especially important.

### Correct Flow

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

### Incorrect Flow

```text
Build
  ↓
Deploy
  ↓
Hope
```

---

# 📌 27. Complete Deployment Pipeline

A professional Placement Management System can follow:

```text
Developer
    ↓
Git Feature Branch
    ↓
Code Review
    ↓
Developer Environment
    ↓
Automated / Manual Tests
    ↓
QA
    ↓
UAT
    ↓
Production
```

Each stage has a purpose.

| Stage       | Main Question                             |
| ----------- | ----------------------------------------- |
| Development | Does it work?                             |
| Code Review | Is it well designed?                      |
| QA          | Does it behave correctly?                 |
| UAT         | Does it satisfy the business requirement? |
| Production  | Can real users safely use it?             |

---

# 📌 28. Complete Developer-to-Production Flow

The complete lifecycle can be visualized as:

```text
                  ┌───────────────────┐
                  │     Developer     │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │   Feature Branch  │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │      Commit       │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │       Push        │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │  Pull Request     │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │   Code Review     │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │       Merge       │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │ Developer / Test  │
                  │      Org          │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │      Testing      │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │        QA         │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │       UAT         │
                  └─────────┬─────────┘
                            ↓
                  ┌───────────────────┐
                  │    Production     │
                  └───────────────────┘
```

---

# 📌 29. Deployment README Requirements

A professional project README should explain:

### Prerequisites

What does a developer need?

```text
Salesforce CLI
Git
Salesforce Org Access
Appropriate Permissions
```

### Clone

How does the developer obtain the project?

```text
GitHub Repository
       ↓
git clone
       ↓
Local Project
```

### Authenticate

How does the developer connect to Salesforce?

```text
Local Project
       ↓
Salesforce CLI
       ↓
Authenticate Org
```

### Deploy

Explain the deployment process.

### Test

Explain how Apex and other tests are executed.

### Verify

Explain what should be checked after deployment.

### Troubleshooting

Document common problems such as:

```text
Authentication Failure
Missing Metadata Dependency
Test Failure
Git Conflict
Deployment Error
```

The PDF explicitly asks the deployment README to cover prerequisites, clone, authentication, deployment, testing, verification and troubleshooting.

---

# 📌 30. GitHub as Engineering Evidence

A GitHub repository should tell the story of the project.

```text
Salesforce Developer Portfolio
          ↓
     Business Problem
          ↓
       Architecture
          ↓
          Apex
          ↓
          LWC
          ↓
      Integration
          ↓
         Tests
          ↓
      Deployment
```

Instead of simply saying:

> "I learned Salesforce."

your repository should demonstrate:

> "I can build, organize, test and deliver a Salesforce application."

---

# 📌 31. Production-Ready Repository

A production-ready repository can contain:

```text
placement-management-system/
│
├── README.md
│
├── force-app/
│
├── docs/
│   ├── architecture/
│   ├── api/
│   ├── deployment/
│   └── decisions/
│
├── screenshots/
│
├── tests/
│
└── .gitignore
```

The README should answer:

1. What problem does the application solve?
2. Who are its users?
3. What are the major Salesforce objects?
4. What Apex architecture is used?
5. What LWC components exist?
6. What asynchronous processing exists?
7. What integrations exist?
8. How is authentication managed?
9. How is the application tested?
10. How is it deployed?
11. What assumptions does the application make?
12. What would be improved in Version 2?

---

# 📌 32. Deployment Roles in a Real Team

The PDF introduces a realistic team simulation.

```text
Developer
   ↓
Explains the change

Reviewer
   ↓
Reviews Git changes

QA
   ↓
Tests the feature

DevOps Engineer
   ↓
Reviews deployment readiness

Product Owner
   ↓
Checks business requirement
```

Each role asks different questions.

### Developer

> How does it work?

### Reviewer

> Why was it designed this way?

### QA

> Does it behave correctly?

### DevOps

> Can we deploy it safely?

### Product Owner

> Does it solve the business problem?

---

# 📌 33. Deployment Review Scenarios

## Scenario 1 — Manually Recreating Fields

A developer creates five fields in a Developer Org and tells the team:

> "Create the same fields in QA."

### Problem

The process is not reproducible or source-controlled.

Better:

```text
Developer Org
      ↓
Retrieve Metadata
      ↓
Git
      ↓
Deploy
      ↓
QA
```

---

## Scenario 2 — LWC Without Apex Dependency

An LWC depends on an Apex class, but only the LWC is deployed.

### Problem

The required Apex dependency may not exist in the target environment.

```text
LWC
 ↓
Apex
 ↓
Metadata
```

Deployment planning must consider dependencies.

---

## Scenario 3 — Direct Push to Main

A developer pushes directly to `main`.

### Problem

The change bypasses:

```text
Code Review
Testing
Discussion
Approval
```

A safer approach is:

```text
Feature Branch
      ↓
Pull Request
      ↓
Review
      ↓
Testing
      ↓
Merge
```

---

## Scenario 4 — Deployment Succeeds but Feature Fails

Investigate:

```text
Metadata
Permissions
Data
Configuration
External Credentials
Environment-Specific Settings
```

Deployment success does not automatically mean application success.

---

## Scenario 5 — Blindly Choosing "Theirs"

A developer resolves a conflict by selecting `theirs` without understanding the code.

### Problem

The selected version might violate the actual business requirement.

Always understand the conflict first.

---

# 📌 34. Definition of Done

A deployment exercise is complete when:

* [ ] Git repository exists
* [ ] Branching strategy is documented
* [ ] Feature branch was used
* [ ] Pull Request was reviewed
* [ ] Salesforce metadata is source-controlled
* [ ] CLI authentication works
* [ ] Metadata can be retrieved
* [ ] Metadata can be deployed
* [ ] Apex tests run successfully
* [ ] Target Org is verified
* [ ] Deployment is documented

---

# 📌 35. Interview Questions

Be prepared to explain:

### Git

1. Why should Salesforce development use Git?
2. What is a Git branch?
3. What is the difference between commit and push?
4. What is a Pull Request?
5. What is a Git merge conflict?
6. How do you safely resolve a conflict?

### Salesforce

7. What is Salesforce CLI?
8. What does metadata mean?
9. What is the purpose of a Sandbox?
10. What is a Scratch Org?
11. What is a Changeset?
12. What is the Metadata API?

### Deployment

13. Why should you verify the Org before deploying?
14. Why can deployment fail even if an Apex class is correct?
15. Why is testing required before Production?
16. Why is "works in my Org" insufficient?
17. What dependencies should be considered during deployment?

The PDF specifically provides these interview questions as preparation for explaining the complete development-to-production lifecycle.

---

# 📌 36. Strong Interview Answer: Developer Org → Production

A strong explanation can be:

```text
We maintain Salesforce metadata and source code in Git.
Developers work on feature branches and commit logical changes.
The changes are pushed to GitHub and reviewed through Pull Requests.

After review, the validated source is deployed to a development or
testing environment using Salesforce CLI and the appropriate deployment
mechanism.

We run Apex and functional tests, verify dependencies, permissions and
configuration, then move the validated changes through QA and UAT before
Production.

This gives us source control, collaboration, testing, reproducibility
and controlled deployment.
```

This reflects the engineering lifecycle described in the PDF.

---

# 📌 37. Final End-to-End Architecture

The entire Sprint 12 concept can be summarized as:

```text
                     SALESFORCE DEVELOPMENT LIFECYCLE

                           Developer
                               │
                               ↓
                       Feature Branch
                               │
                               ↓
                            Git
                               │
                    ┌──────────┴──────────┐
                    ↓                     ↓
                  Commit                Push
                                          │
                                          ↓
                                      GitHub
                                          │
                                          ↓
                                  Pull Request
                                          │
                                          ↓
                                    Code Review
                                          │
                                          ↓
                                      Testing
                                          │
                                          ↓
                                      Merge
                                          │
                                          ↓
                              Salesforce CLI
                                          │
                                          ↓
                                Metadata Deployment
                                          │
                                          ↓
                              Development / QA Org
                                          │
                                          ↓
                                       QA Tests
                                          │
                                          ↓
                                        UAT
                                          │
                                          ↓
                                    Production
                                          │
                                          ↓
                                     Verification
```

---

# 🎯 Key Engineering Principles

### 1. Org ≠ Source Control

```text
Org = Environment
Git = Development Record
```

### 2. Branch Before You Change

```text
Feature → Branch → Review → Merge
```

### 3. Commit Meaningfully

```text
Logical Change → Meaningful Commit
```

### 4. Deploy Metadata, Not Just Code

```text
Application
   ↓
Code + Metadata + Configuration + Dependencies
```

### 5. Test Before Production

```text
Build → Test → Validate → Deploy → Verify
```

### 6. Verify the Target Org

```text
Before Deployment:
Org?
Branch?
Commit?
Metadata?
Tests?
Approval?
```

### 7. Make Development Reproducible

```text
Source
  ↓
Environment
  ↓
Deploy
  ↓
Test
  ↓
Works
```

### 8. Document Everything Needed by the Next Developer

A project is not truly production-ready if another developer cannot understand:

```text
What?
Why?
Where?
How?
Dependencies?
Testing?
Deployment?
Verification?
```

---

# 🏁 Sprint 12 Final Summary

This sprint transforms the Placement Management System from a collection of Salesforce components into a professional software product.

The complete lifecycle is:

```text
Designed
   ↓
Built
   ↓
Tested
   ↓
Version Controlled
   ↓
Reviewed
   ↓
Deployed
   ↓
Verified
```

A professional Salesforce developer should be able to:

* Use Git for source control
* Work with branches
* Create meaningful commits
* Push and pull changes
* Create and review Pull Requests
* Resolve merge conflicts intelligently
* Understand Salesforce metadata
* Use Salesforce CLI
* Authenticate Salesforce Orgs
* Retrieve metadata
* Deploy metadata
* Understand Sandboxes
* Understand Scratch Orgs
* Understand Changesets
* Understand Metadata API
* Identify deployment dependencies
* Test before deployment
* Follow a controlled deployment pipeline
* Document deployment procedures
* Present GitHub as evidence of engineering ability

The central lesson of this sprint is:

> **A Salesforce developer is not only someone who can build an application. A professional Salesforce developer can build, test, version, review, document and safely deliver that application.**

---

## 📚 Module Flow at a Glance

```text
Git
 ↓
Branches
 ↓
Commits
 ↓
Push / Pull
 ↓
Pull Requests
 ↓
Code Review
 ↓
Merge Conflicts
 ↓
Repository Structure
 ↓
Code / Metadata / Data
 ↓
Salesforce CLI
 ↓
Org Authentication
 ↓
Org Aliases
 ↓
Metadata
 ↓
Retrieve
 ↓
Deploy
 ↓
Sandboxes
 ↓
Scratch Orgs
 ↓
Changesets
 ↓
Metadata API
 ↓
Dependencies
 ↓
Testing
 ↓
Deployment Pipeline
 ↓
QA
 ↓
UAT
 ↓
Production
 ↓
Verification
```

### ⭐ Core Message

**From Developer Org to Production = From "I built it" to "I can professionally deliver it."**
