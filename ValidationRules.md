# Validation Rules

## Definition

A Validation Rule checks whether the entered data follows business rules. If the data is invalid, Salesforce prevents the record from being saved and displays an error message.

---

## Validation Rule 1

**Requirement:**
Student CGPA must be greater than or equal to the Job's minimum CGPA.

**Formula:**

```text
Student__r.CGPA__c < Job__r.Minimum_CGPA__c
```

---

## Validation Rule 2

**Requirement:**
Application Date cannot be after the Job Closing Date.

**Formula:**

```text
Application_Date__c > Job__r.Closing_Date__c
```

---

## Validation Rule 3

**Requirement:**
Mandatory fields cannot be left blank.

**Formula:**

```text
OR(
ISBLANK(Student__c),
ISBLANK(Job__c),
ISBLANK(Application_Date__c)
)
```
