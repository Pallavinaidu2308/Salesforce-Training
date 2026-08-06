# 📅 Sprint 7 Learning Journal

![Salesforce](https://img.shields.io/badge/Salesforce-Sprint_7-blue?style=for-the-badge&logo=salesforce)
![Learning](https://img.shields.io/badge/Learning-In_Progress-success?style=for-the-badge)
![Apex](https://img.shields.io/badge/Apex-Bulkification-orange?style=for-the-badge)

---

# 🎯 Sprint Objective

The primary objective of Sprint 7 was to understand how Salesforce handles multiple records in a single transaction and how to write efficient Apex code that complies with **Governor Limits**.

During this sprint, I explored the concept of **Bulkification**, learned how to work with Apex collections, and understood why enterprise Salesforce applications use **Trigger Handler Architecture** instead of placing business logic directly inside triggers.

---

# 📚 Topics Explored

Throughout this sprint, I gained practical and theoretical knowledge of the following topics:

- ✅ Multi-Tenant Architecture
- ✅ Governor Limits
- ✅ Bulkification
- ✅ Collection-Based Programming
- ✅ SOQL Best Practices
- ✅ DML Best Practices
- ✅ Lists
- ✅ Sets
- ✅ Maps
- ✅ Trigger Context Variables
  - `Trigger.new`
  - `Trigger.old`
  - `Trigger.oldMap`
- ✅ Trigger Handler Pattern

---

# 💻 Hands-on Activities

This sprint focused on implementing best practices through practical exercises.

## Apex Development

Successfully completed the following development tasks:

- Created the **ApplicationTriggerHandler** Apex class.
- Modified the **ApplicationTrigger** to delegate processing to the handler class.
- Updated the **ApplicationService** class to separate business logic from trigger logic.
- Deployed all Apex classes and metadata successfully using Salesforce CLI.

---

## Developer Console Practice

To strengthen my understanding of Apex collections, I performed several exercises using **Execute Anonymous**.

### 🔍 Retrieving Records with SOQL

Executed a SOQL query to fetch Account records and verified the output using the Debug Log.

---

### 📋 Working with Lists

Created a List to store multiple values and displayed the contents.

```apex
List<String> technologies = new List<String>{
    'Apex',
    'Lightning Web Components',
    'SOQL'
};
```

---

### 🎯 Working with Sets

Created a Set and observed how duplicate values are automatically removed.

```apex
Set<String> certifications = new Set<String>();

certifications.add('Administrator');
certifications.add('Platform Developer');
certifications.add('Administrator');
```

---

### 🗺 Working with Maps

Created a Map to store data as key-value pairs and accessed values using their keys.

```apex
Map<Integer,String> sprintMap = new Map<Integer,String>();

sprintMap.put(1,'Sprint One');
sprintMap.put(2,'Sprint Two');
```

---

# 🧠 Major Learning Outcomes

By the end of Sprint 7, I developed a better understanding of how Apex applications should be designed for scalability and performance.

Some of the important concepts I learned include:

- Salesforce triggers are capable of processing multiple records simultaneously.
- Governor Limits ensure efficient resource sharing among Salesforce organizations.
- SOQL queries should always be executed outside loops.
- DML operations should be performed only once after processing all records.
- Lists are useful for storing and processing multiple records.
- Sets help maintain unique values by automatically removing duplicates.
- Maps provide quick access to records using unique keys.
- Trigger Handler Architecture improves code organization and maintainability.
- Bulkification is essential for building scalable Salesforce applications.

---

# ⚠ Challenges Encountered

While working through this sprint, I encountered several practical challenges:

- Understanding how Bulk Processing works.
- Learning to think in terms of collections rather than individual records.
- Implementing the Trigger Handler Pattern.
- Configuring Salesforce CLI correctly.
- Setting the default Salesforce Org.
- Resolving metadata deployment errors during deployment.

Each challenge helped me better understand Salesforce development and deployment practices.

---

# ✅ Solutions Applied

To overcome these challenges, I implemented the following solutions:

- Configured the default Salesforce Org using Salesforce CLI.
- Corrected metadata configuration issues that caused deployment failures.
- Successfully deployed Apex classes and triggers.
- Verified the deployed components in Salesforce Setup.
- Practiced Apex code execution using Execute Anonymous.
- Reviewed Debug Logs to validate program execution.

---

# 📸 Project Screenshots

The **Screenshots** folder contains evidence of all practical activities completed during this sprint.

Included screenshots:

- 📄 ApplicationTriggerHandler Apex Class
- 📄 ApplicationTrigger Trigger
- ✅ Successful Metadata Deployment
- 📄 Apex Classes in Salesforce
- 📄 Apex Trigger
- 💻 Execute Anonymous Window
- 📋 Debug Log Output
- 📋 List Example Output
- 📋 Set Example Output
- 📋 Map Example Output

---

# 🎯 Interview Questions Practiced

## 1. What are Governor Limits?

Governor Limits are system-enforced restrictions that ensure fair usage of shared Salesforce resources in a multi-tenant environment.

---

## 2. What is Bulkification?

Bulkification is the process of writing Apex code that efficiently processes multiple records in a single transaction while minimizing SOQL queries and DML operations.

---

## 3. Why should SOQL queries not be written inside loops?

Because the query executes once for every iteration, increasing the number of database queries and potentially exceeding Salesforce's SOQL Governor Limit.

---

## 4. Why should DML operations not be performed inside loops?

Each DML statement counts toward Salesforce's DML limit. Executing DML repeatedly inside a loop can quickly exceed the maximum allowed limit.

---

## 5. Why are Maps important in Apex?

Maps provide fast access to records using unique keys, reducing unnecessary database queries and improving application performance.

---

# 🏆 Sprint Outcome

Sprint 7 helped me build a strong foundation in writing scalable Apex applications.

I learned how to:

- Write bulkified Apex code.
- Work efficiently with Lists, Sets, and Maps.
- Understand Salesforce Governor Limits.
- Separate business logic using the Trigger Handler Pattern.
- Deploy and validate Apex components using Salesforce CLI.

These concepts are fundamental for developing enterprise-level Salesforce applications.

---

# 🌟 Personal Reflection

This sprint changed the way I think about Apex development.

Initially, I focused on writing code that worked for individual records. Through this sprint, I learned that real-world Salesforce applications must be designed to handle hundreds of records efficiently.

Understanding Bulkification, Governor Limits, and Collection-Based Programming has helped me appreciate the importance of writing clean, maintainable, and scalable Apex code.

> **"Great Salesforce developers don't just write working code—they write code that scales."**
