# Record-Triggered Flows

A Record-Triggered Flow is an automation tool in Salesforce that runs automatically when a record is created, updated, or deleted.

---

## Flow 1: Auto Populate Application Date

**Flow Type:** Before Save Record-Triggered Flow

**Object:** Application__c

**Trigger:** Record Created

**Purpose:**
Automatically sets the Application Date when a new application is created.

---

## Flow 2: Send Confirmation Email

**Flow Type:** After Save Record-Triggered Flow

**Object:** Application__c

**Trigger:** Record Created

**Purpose:**
Sends a confirmation email to the Placement Officer.

---

## Flow 3: Create Offer Letter

**Flow Type:** After Save Record-Triggered Flow

**Object:** Application__c

**Trigger:** Record Updated

**Condition:** Status = Selected

**Purpose:**
Automatically creates an Offer Letter record when a student's application status becomes **Selected**.
