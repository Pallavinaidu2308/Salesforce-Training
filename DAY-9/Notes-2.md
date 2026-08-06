# 🚀 Why Should You Avoid SOQL and DML Inside Loops?

When writing Apex code, one of the most important Salesforce best practices is **Bulkification**.

Salesforce is a **multi-tenant platform**, where multiple organizations share the same resources. To ensure fair resource usage and maintain platform performance, Salesforce enforces **Governor Limits**.

Two of the most common mistakes that lead to governor limit exceptions are:

- Executing **SOQL queries inside loops**
- Performing **DML operations inside loops**

Let's understand why these practices should be avoided and how to write efficient Apex code.

---

# 🔍 Why is SOQL Inside a Loop Dangerous?

**SOQL (Salesforce Object Query Language)** is used to retrieve records from the Salesforce database.

When a SOQL query is placed inside a loop, Salesforce executes the query **once for every record** being processed.

## ❌ Bad Example

Suppose we want to retrieve the related Account for every Contact.

```apex
for(Contact con : Trigger.new){

    Account acc = [
        SELECT Id, Name
        FROM Account
        WHERE Id = :con.AccountId
    ];

}
```

---

## 🚨 What Happens?

If a trigger receives **200 Contact records**, the loop executes 200 times.

```
200 Contact Records
        │
        ▼
Loop Executes 200 Times
        │
        ▼
200 SOQL Queries
        │
        ▼
❌ Governor Limit Exceeded
```

Salesforce allows only **100 SOQL queries per transaction**.

After the 100th query, Salesforce throws the following exception:

```
Too many SOQL queries: 101
```

The logic is correct, but repeatedly querying the database is inefficient and causes governor limit exceptions.

---

# ✅ Best Practice

Instead of querying inside the loop:

1. Collect all required record IDs.
2. Execute a single SOQL query.
3. Store the results in a Map.
4. Retrieve records from the Map inside the loop.

### ✅ Good Example

```apex
Set<Id> accountIds = new Set<Id>();

for(Contact con : Trigger.new){
    if(con.AccountId != null){
        accountIds.add(con.AccountId);
    }
}

Map<Id, Account> accountMap = new Map<Id, Account>(
    [SELECT Id, Name
     FROM Account
     WHERE Id IN :accountIds]
);

for(Contact con : Trigger.new){

    Account acc = accountMap.get(con.AccountId);

}
```

---

## ✅ Result

Instead of executing:

```
200 SOQL Queries
```

Salesforce executes only:

```
1 SOQL Query
```

This improves performance and keeps your code within governor limits.

---

# ⚠️ Why is DML Inside a Loop Dangerous?

**DML (Data Manipulation Language)** is used to modify Salesforce records.

Common DML operations include:

- Insert
- Update
- Delete
- Upsert

When a DML statement is placed inside a loop, Salesforce performs a separate database operation for every record.

---

## ❌ Bad Example

Suppose we want to close multiple Case records.

```apex
for(Case c : caseList){

    c.Status = 'Closed';
    update c;

}
```

---

## 🚨 What Happens?

If there are **200 Case records**:

```
200 Case Records
        │
        ▼
Loop Executes 200 Times
        │
        ▼
200 Update Statements
        │
        ▼
❌ Governor Limit Exceeded
```

Salesforce allows only **150 DML statements per transaction**.

Executing one DML statement for every record quickly exceeds this limit.

---

# ✅ Best Practice

Store all modified records in a list and perform **one DML operation**.

### ✅ Good Example

```apex
List<Case> casesToUpdate = new List<Case>();

for(Case c : caseList){

    c.Status = 'Closed';
    casesToUpdate.add(c);

}

update casesToUpdate;
```

---

## ✅ Result

Instead of executing:

```
200 Update Statements
```

Salesforce executes:

```
1 Update Statement
```

This approach is faster, more efficient, and follows Salesforce best practices.

---

# 🚀 What is Bulkification?

**Bulkification** is the practice of writing Apex code that efficiently processes **multiple records in a single transaction**.

Instead of processing records one by one, Salesforce processes collections of records together.

Bulkified code works efficiently for:

- Triggers
- Batch Apex
- Data Loader imports
- API operations
- Mass updates

---

# 📊 Bulkification Workflow

```
📥 Receive Multiple Records
          │
          ▼
🆔 Collect Required IDs
          │
          ▼
🔍 Execute One SOQL Query
          │
          ▼
🗺 Store Results in a Map
          │
          ▼
⚙ Process Each Record
          │
          ▼
📋 Collect Records to Update
          │
          ▼
💾 Execute One DML Operation
```

---

# 🌟 Advantages of Bulkification

- ⚡ Improves application performance.
- 🚀 Executes faster.
- 📉 Reduces SOQL queries.
- 📉 Reduces DML statements.
- 🔒 Prevents Governor Limit exceptions.
- 📈 Supports large data volumes.
- 💼 Follows Salesforce Apex best practices.
- ✅ Makes code easier to maintain and scale.

---

# 📝 Key Takeaways

- ✅ Never execute **SOQL queries inside loops**.
- ✅ Never perform **DML operations inside loops**.
- ✅ Query all required records using **one SOQL query**.
- ✅ Use **Set** to collect IDs and **Map** for quick record access.
- ✅ Store modified records in a **List** and perform **one DML operation**.
- ✅ Always write **bulkified Apex code** that can handle hundreds of records efficiently while staying within Salesforce Governor Limits.
