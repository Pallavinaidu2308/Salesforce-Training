---

# 3. `deployment-architecture.md`

```markdown
# 🚀 Deployment Architecture

## Overview

Deployment architecture defines how Salesforce source code and metadata move from development to Production.

Deployment is not simply the process of "pushing code."

A Salesforce application can contain:

- Apex
- LWC
- Custom Objects
- Custom Fields
- Flows
- Permissions
- Named Credentials
- Other metadata and configuration

Therefore, deployment must consider the complete application and its dependencies.

## High-Level Deployment Architecture

```text
                    Developer
                        ↓
                 Local Project
                        ↓
                    Git Branch
                        ↓
                   GitHub
                        ↓
                 Pull Request
                        ↓
                  Code Review
                        ↓
                    Testing
                        ↓
               Salesforce CLI
                        ↓
              Development / QA
                        ↓
                       UAT
                        ↓
                  Production
                        ↓
                  Verification
