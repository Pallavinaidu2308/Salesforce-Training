# 🚀 SOQL and DML Inside Loops – Why Should You Avoid Them?

When developing in Apex, one of the most important coding practices is **Bulkification**.

Salesforce is a **multi-tenant platform**, meaning multiple organizations share the same server resources. To ensure that no single organization consumes excessive resources, Salesforce enforces **Governor Limits**.

If Apex code is not written efficiently, it can easily exceed these limits, causing runtime exceptions.

Two of the most common mistakes developers make are:

- Executing **SOQL queries inside loops**
- Performing **DML operations inside loops**

Let's understand why these practices should be avoided and how to write scalable Apex code.

---

# 🔍 Why Should You Avoid SOQL Inside a Loop?

SOQL (**Salesforce Object Query Language**) is used to retrieve records from the Salesforce database.

When a SOQL query is written inside a loop, Salesforce executes that query **once for every iteration** of the loop.

Although this may work for a small number of records, it becomes a serious problem when processing hundreds of records.

---

## ❌ Bad Example

Suppose we want to retrieve the Owner of every Opportunity.

```apex
for(Opportunity opp : Trigger.new){

    User owner = [
        SELECT Id, Name
        FROM User
        WHERE Id = :opp.OwnerId
    ];

}
```

---

## 🚨 What Happens?

Imagine a trigger receives **200 Opportunity records**.

```
200 Opportunity Records
          │
          ▼
Loop runs 200 times
          │
          ▼
SOQL query executes 200 times
          │
          ▼
❌ Governor Limit Exceeded
```

Salesforce allows only **100 SOQL queries** in a single transaction.

Once the limit is crossed, Salesforce immediately stops execution and throws the following error:

```
Too many SOQL queries: 101
```

The problem is not the query itself—the problem is executing the same query repeatedly.

---

# ✅ Best Practice

Instead of querying inside the loop:

1. Collect all required record IDs.
2. Execute one SOQL query.
3. Store the retrieved records in a Map.
4. Access records from the Map while processing the loop.

---

## ✅ Good Example

```apex
Set<Id> ownerIds = new Set<Id>();

for(Opportunity opp : Trigger.new){

    if(opp.OwnerId != null){
        ownerIds.add(opp.OwnerId);
    }

}

Map<Id, User> ownerMap = new Map<Id, User>(
    [SELECT Id, Name
     FROM User
     WHERE Id IN :ownerIds]
);

for(Opportunity opp : Trigger.new){

    User owner = ownerMap.get(opp.OwnerId);

}
```

---

## ✅ Why Is This Better?

Instead of running:

```
200 SOQL Queries
```

Salesforce runs only:

```
1 SOQL Query
```

This approach improves performance, reduces database calls, and keeps your code within governor limits.

---

# ⚠️ Why Should You Avoid DML Inside a Loop?

DML (**Data Manipulation Language**) is used to create, modify, or delete records in Salesforce.

Some common DML operations are:

- Insert
- Update
- Delete
- Upsert

If a DML statement is placed inside a loop, Salesforce performs a separate database operation for every record.

Database operations are expensive, so executing them repeatedly quickly reaches governor limits.

---

## ❌ Bad Example

Suppose we want to mark multiple Tasks as completed.

```apex
for(Task t : taskList){

    t.Status = 'Completed';

    update t;

}
```

---

## 🚨 What Happens?

If there are **200 Task records**:

```
200 Task Records
          │
          ▼
Loop runs 200 times
          │
          ▼
200 Update Statements
          │
          ▼
❌ Governor Limit Exceeded
```

Salesforce allows only **150 DML statements** per transaction.

Because one update statement is executed for every record, the limit is exceeded.

---

# ✅ Best Practice

Modify all records first.

Store them in a collection.

Perform a single DML operation after the loop.

---

## ✅ Good Example

```apex
List<Task> tasksToUpdate = new List<Task>();

for(Task t : taskList){

    t.Status = 'Completed';

    tasksToUpdate.add(t);

}

update tasksToUpdate;
```

---

## ✅ Why Is This Better?

Instead of executing:

```
200 Update Statements
```

Salesforce executes only:

```
1 Update Statement
```

This approach is much faster, consumes fewer resources, and follows Salesforce best practices.

---

# 🚀 What is Bulkification?

**Bulkification** is the process of writing Apex code that can efficiently process **multiple records in a single transaction** instead of processing one record at a time.

Salesforce triggers, Batch Apex jobs, Data Loader imports, and API integrations often process hundreds of records simultaneously.

Well-written Apex code should work correctly whether it receives:

- 1 record
- 50 records
- 200 records
- Thousands of records (using Batch Apex)

Bulkified code ensures that your application remains efficient regardless of the number of records being processed.

---

# 📊 Bulkification Workflow

```
📥 Receive Multiple Records
            │
            ▼
🆔 Collect Required Record IDs
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
📋 Store Modified Records in a List
            │
            ▼
💾 Execute One DML Operation
```

---

# 🌟 Advantages of Bulkification

- ⚡ Reduces unnecessary database queries.
- ⚡ Minimizes DML operations.
- 🚀 Improves application performance.
- 📈 Supports processing of large data volumes.
- 🔒 Prevents Governor Limit exceptions.
- 💼 Follows Salesforce Apex best practices.
- 🧹 Produces cleaner, scalable, and maintainable code.

---

# 📝 Key Takeaways

- ✅ Never execute **SOQL queries inside loops**.
- ✅ Never perform **DML operations inside loops**.
- ✅ Collect record IDs using a **Set** before querying.
- ✅ Retrieve all required records using **one SOQL query**.
- ✅ Store queried records in a **Map** for quick access.
- ✅ Store modified records in a **List** and perform **one DML operation**.
- ✅ Always write **bulkified Apex code** so that it can efficiently handle large numbers of records without exceeding Salesforce Governor Limits.
