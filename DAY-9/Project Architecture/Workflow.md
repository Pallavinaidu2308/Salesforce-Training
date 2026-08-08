
# 📝 Apply Workflow — Day 9

## Student Placement Portal — Lightning Web Components

### Engineering Sprint 09 | Salesforce LWC

---

## 📌 Workflow Summary

The **Apply Workflow** handles the complete process of submitting a student's application for a placement opportunity.

The Lightning Web Components provide the user interface for selecting a job and student, while the **Salesforce Apex business layer** performs the required validations before an application is created.

The workflow ensures that only valid applications are submitted and that students cannot apply for opportunities that do not meet the required conditions.

### Key Capabilities

* Display available placement opportunities
* Select a placement opportunity
* Select the student applying for the opportunity
* Submit the application through LWC
* Process the request through Apex
* Prevent duplicate applications
* Verify CGPA eligibility
* Validate the application deadline
* Create the application record after successful validation
* Display success or error messages
* Refresh the application list after submission

---

## 🎯 Process Objective

The purpose of this workflow is to provide a controlled application process between the **LWC interface and Salesforce Apex logic**.

Instead of creating an application directly from the frontend, the request is passed to Apex, where the business rules are checked.

An application is created only when all required conditions are satisfied.

This approach keeps the application process reliable and prevents invalid or duplicate records from being inserted.

---

## 🔄 Application Processing Flow

```text
Student
   │
   ▼
View Eligible Jobs
   │
   ▼
Select Job
   │
   ▼
Click Apply
   │
   ▼
Select Student
   │
   ▼
Submit Application
   │
   ▼
Apex Business Layer
   │
   ▼
Validate Application
   │
   ├── Check Duplicate Application
   │
   ├── Verify CGPA Eligibility
   │
   └── Check Application Deadline
   │
   ▼
All Validations Passed?
   │
   ├── No ──► Return Error Message
   │
   └── Yes
         │
         ▼
   Create Application Record
         │
         ▼
   Return Success Response
         │
         ▼
   Refresh Application Data
         │
         ▼
   Display in My Applications
```

---

## ⚙️ Workflow Execution

### 1. View Available Jobs

The student accesses the placement portal and views the available placement opportunities that can be applied for.

The LWC retrieves the required job information and presents it through the user interface.

### 2. Select a Job

The student selects the placement opportunity they want to apply for.

The selected job becomes the target opportunity for the application process.

### 3. Initiate Application

When the student clicks **Apply**, the LWC opens the application interface and requests the student information required for submission.

### 4. Select Student

The appropriate student record is selected and associated with the chosen placement opportunity.

### 5. Submit Application

After the required information is selected, the LWC sends the application request to the Apex controller.

The frontend does not directly create the Salesforce record.

### 6. Perform Business Validation

The Apex business layer processes the request and performs three important checks:

**Duplicate Check**

Verifies whether the student has already submitted an application for the selected job.

**CGPA Check**

Compares the student's CGPA with the eligibility requirement defined for the placement opportunity.

**Deadline Check**

Verifies whether the application is being submitted before the job's application deadline.

### 7. Create Application

If all validations are successful, Salesforce creates the application record with the selected student and placement opportunity.

If any validation fails, the application is rejected and an appropriate error response is returned to the LWC.

### 8. Display Result

The LWC processes the Apex response and displays the appropriate result to the user.

* Successful submission → Success message
* Duplicate application → Validation error
* Insufficient CGPA → Eligibility error
* Deadline exceeded → Deadline error

### 9. Refresh Application Data

After a successful application, the LWC refreshes the application data so that the newly created record becomes immediately visible.

The student can then view the submitted application under **My Applications**.

---

## 🔗 Component Interaction

```text
Lightning Web Component
        │
        │ Application Request
        ▼
Apex Controller
        │
        ▼
Business Validation
        │
        ├── Duplicate Validation
        ├── CGPA Validation
        └── Deadline Validation
        │
        ▼
Salesforce Database
        │
        ▼
Application Record
        │
        ▼
Apex Response
        │
        ▼
Lightning Web Component
        │
        ▼
Refresh Application List
        │
        ▼
My Applications
```

---

## ✅ Expected Outcome

At the end of the workflow:

* A student can select an eligible placement opportunity.
* The application request is processed through Apex.
* Duplicate applications are prevented.
* CGPA requirements are enforced.
* Application deadlines are respected.
* Valid applications are stored in Salesforce.
* Users receive clear success or error feedback.
* The newly submitted application appears in **My Applications** without requiring a manual page reload.

---

## 🚀 Result

The Apply Workflow establishes a complete **LWC → Apex → Validation → Salesforce Database → LWC** application cycle.

By keeping the business rules inside the Apex layer, the system ensures that application records are created only when the placement requirements are satisfied.
