# 📅 Sprint 7 Learning Journal

![Salesforce](https://img.shields.io/badge/Salesforce-Sprint_7-blue?style=for-the-badge&logo=salesforce)
![Learning](https://img.shields.io/badge/Learning-In_Progress-success?style=for-the-badge)
![Apex](https://img.shields.io/badge/Apex-Scalable_Development-orange?style=for-the-badge)

---

# 🎯 Sprint Objective

The primary objective of Sprint 7 was to learn how Salesforce applications efficiently process large volumes of records while following platform best practices.

This sprint focused on developing a collection-based approach to Apex programming by understanding Governor Limits, Bulkification, Trigger Collections, and enterprise Trigger design.

By the end of this sprint, I gained practical knowledge of writing Apex code that is scalable, efficient, and suitable for real-world Salesforce applications.

---

# 📖 Concepts Explored

During this sprint, I studied the following topics:

- ✅ Salesforce Multi-Tenant Architecture
- ✅ Governor Limits
- ✅ Bulkification
- ✅ Collection-Based Processing
- ✅ SOQL Optimization
- ✅ DML Optimization
- ✅ Lists
- ✅ Sets
- ✅ Maps
- ✅ Trigger Collections
- ✅ Trigger.new and Trigger.oldMap
- ✅ Trigger Handler Architecture

These concepts helped me understand how Salesforce manages resources while processing multiple records in a single transaction.

---

# 💻 Hands-On Practice

## Apex Development

As part of the practical exercises, I worked on improving the project architecture by implementing and updating several Apex components.

Completed tasks included:

- Creating **ApplicationTriggerHandler.cls**
- Modifying **ApplicationTrigger.trigger**
- Updating **ApplicationService.cls**
- Deploying Apex classes and triggers using Salesforce CLI
- Verifying successful deployment in the Salesforce organization

---

## Salesforce Developer Console Practice

To strengthen my understanding of Apex collections and SOQL, I performed several Execute Anonymous exercises.

### Retrieving Salesforce Records

Executed a SOQL query to retrieve Account records and analyzed the results using the Debug Log.

---

### Working with Lists

Created a List collection to understand ordered data storage.

```apex
List<String> products = new List<String>{
    'Laptop',
    'Keyboard',
    'Mouse'
};

System.debug(products);
```

---

### Working with Sets

Created a Set collection to observe how duplicate values are automatically removed.

```apex
Set<String> technologies = new Set<String>();

technologies.add('Apex');
technologies.add('Flow');
technologies.add('Apex');

System.debug(technologies);
```

---

### Working with Maps

Created a Map collection to understand key-value storage and fast data retrieval.

```apex
Map<Integer, String> departments = new Map<Integer, String>();

departments.put(101, 'Sales');
departments.put(102, 'Support');

System.debug(departments);
```

---

# 🧠 Major Learnings

Throughout this sprint, I discovered several important Salesforce development principles.

- Salesforce Triggers process records in bulk rather than individually.
- Governor Limits help protect shared platform resources.
- SOQL queries should be executed efficiently to reduce database usage.
- DML operations should be grouped whenever possible.
- Lists are ideal for processing multiple records.
- Sets help eliminate duplicate values.
- Maps provide quick access to records using unique keys.
- Trigger Handler Architecture improves code organization.
- Bulkification is essential for building scalable Apex applications.

---

# ⚠️ Challenges Encountered

While completing this sprint, I faced several practical challenges.

- Understanding how bulk processing works internally.
- Learning when to use Lists, Sets, and Maps.
- Implementing the Trigger Handler pattern correctly.
- Configuring Salesforce CLI for deployments.
- Managing the default Salesforce organization.
- Resolving deployment issues related to project structure and metadata.

Each challenge helped strengthen my understanding of Salesforce development practices.

---

# ✅ Solutions Applied

To overcome these challenges, I:

- Configured the correct default Salesforce Org.
- Corrected deployment configuration issues.
- Fixed metadata and project structure problems.
- Successfully deployed Apex classes and triggers.
- Verified deployments inside Salesforce.
- Practiced Apex collection examples using Execute Anonymous.
- Used Debug Logs to validate program execution.

---

# 📸 Evidence of Work

The **Screenshots** folder contains images demonstrating the successful completion of the practical activities, including:

- ApplicationTriggerHandler class
- ApplicationTrigger
- Successful deployment
- Apex Classes
- Apex Trigger
- Execute Anonymous window
- Debug Log output
- List collection example
- Set collection example
- Map collection example

---

# 🎤 Interview Preparation

This sprint also helped me prepare for common Salesforce interview questions.

### What are Governor Limits?

Governor Limits are platform restrictions that ensure every Salesforce organization receives a fair share of system resources in a multi-tenant environment.

---

### What is Bulkification?

Bulkification is the practice of designing Apex code that efficiently processes multiple records within a single transaction while minimizing database operations.

---

### Why should SOQL queries not be placed inside loops?

Executing SOQL inside a loop results in repeated database queries, increasing the likelihood of exceeding Salesforce Governor Limits.

---

### Why should DML statements not be placed inside loops?

Executing DML inside a loop performs multiple database operations instead of a single bulk operation, reducing efficiency and potentially exceeding DML limits.

---

### Why are Maps commonly used in Apex?

Maps provide direct access to records using unique keys, making data retrieval faster and reducing the need for additional SOQL queries.

---

# 🏆 Sprint Outcome

By completing Sprint 7, I developed a strong understanding of how enterprise Salesforce applications are designed to process large volumes of records efficiently.

I also learned how Bulkification, Collections, and Trigger Handler Architecture contribute to building applications that are scalable, maintainable, and compliant with Salesforce Governor Limits.

---

# 🌟 Personal Reflection

This sprint changed the way I think about Apex development.

Previously, I focused on writing code that solved a problem for a single record. Now I understand that enterprise applications must be designed to handle hundreds of records efficiently without affecting system performance.

Learning about collections, bulk processing, and Trigger architecture has given me a stronger foundation for developing scalable Salesforce solutions and following industry best practices.

> **"Efficient Salesforce development begins with thinking in collections, reducing unnecessary database operations, and writing Apex code that can scale with growing business needs."**
