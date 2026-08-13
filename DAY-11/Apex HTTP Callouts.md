
---

# 5. Apex HTTP Callouts

```markdown
# ☁️ Apex HTTP Callouts

## Overview

An Apex HTTP callout allows Salesforce to send an HTTP request to an external system and receive its response.

## Basic Flow

```text
HttpRequest
     ↓
Configure Endpoint
     ↓
Set HTTP Method
     ↓
Set Headers
     ↓
Set Body
     ↓
Http.send()
     ↓
HttpResponse
