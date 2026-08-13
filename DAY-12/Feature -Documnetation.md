
The workflow above follows the PDF's controlled sequence from feature branch through Pull Request, deployment, testing, verification, and documentation. :contentReference[oaicite:2]{index=2}

---

# 2. `feature-documentation.md`

```markdown
# 📝 Feature Documentation

## Overview

Feature documentation explains a feature from both a business and technical perspective.

It should help a developer, reviewer, tester, or product owner understand:

- What the feature does
- Why it exists
- Who uses it
- What data it requires
- How it works
- Which Salesforce components are involved
- What validations are performed
- How the feature is tested

## Why Feature Documentation Matters

Code explains implementation, but documentation explains intent.

A feature may contain multiple components:

```text
LWC
 ↓
Apex Controller
 ↓
Service
 ↓
Objects
 ↓
Fields
 ↓
Automation
