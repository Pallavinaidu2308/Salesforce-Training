# 🔍 Why Should SOQL Queries Be Kept Outside Loops?

Writing Apex code that works for a few records is easy. The real challenge is ensuring that the same code performs efficiently when hundreds of records are processed together.

One common mistake is placing a **SOQL query inside a loop**. Although the code may work for a small number of records, it can quickly exceed Salesforce Governor Limits when processing larger datasets.

---

# ❌ Inefficient Approach

Suppose we want to retrieve the related **Account** for every Opportunity.

```apex
for(Opportunity opp : Trigger.new){

    Account acc = [
        SELECT Id, Name
        FROM Account
        WHERE Id = :opp.AccountId
    ];

}
```

---

# 🚨 Why is This a Problem?

Imagine a data import creates **200 Opportunity records**.

```text
200 Opportunity Records
        │
        ▼
Loop Executes 200 Times
        │
        ▼
200 SOQL Queries Executed
        │
        ▼
Governor Limit Exception
```

Salesforce allows only **100 SOQL queries** in a synchronous transaction.

After the limit is exceeded, Salesforce throws an exception similar to:

```text
Too many SOQL queries: 101
```

The problem is not the query itself—it is executing the same query repeatedly inside the loop.

---

# ✅ Better Approach

Instead of querying one record at a time:

1. Collect all required record IDs.
2. Execute one SOQL query.
3. Store the records in a Map.
4. Access the required records from the Map inside the loop.

```text
Collect Record IDs
        │
        ▼
Execute One SOQL Query
        │
        ▼
Store Results in a Map
        │
        ▼
Process Each Record
```

This approach minimizes database access and keeps the code within Governor Limits.

---

# ⚠️ Why Should DML Statements Be Kept Outside Loops?

DML operations such as **insert**, **update**, **delete**, and **upsert** modify records in the Salesforce database.

Executing a DML statement inside a loop causes Salesforce to perform a separate database operation for every record.

---

# ❌ Inefficient Approach

Suppose we want to update the stage of multiple Opportunities.

```apex
for(Opportunity opp : opportunityList){

    opp.StageName = 'Closed Won';
    update opp;

}
```

---

# 🚨 Why is This a Problem?

If the list contains **200 Opportunity records**, Salesforce performs 200 separate update operations.

```text
200 Opportunity Records
        │
        ▼
200 Individual Updates
        │
        ▼
Governor Limit Exception
```

Salesforce allows only **150 DML statements** in a single transaction.

Updating records individually increases execution time and may exceed this limit.

---

# ✅ Better Approach

Modify all required records first and then execute a single DML statement.

```apex
List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();

for(Opportunity opp : opportunityList){

    opp.StageName = 'Closed Won';
    opportunitiesToUpdate.add(opp);

}

update opportunitiesToUpdate;
```

This approach performs only **one database update**, making the application more efficient.

---

# 🚀 Understanding Bulkification

**Bulkification** is the practice of writing Apex code that can process many records efficiently within a single transaction.

Rather than handling records one at a time, bulkified code processes collections, reducing unnecessary database operations and improving performance.

Bulkification is one of the most important principles of Salesforce development because Triggers, API requests, Batch Apex, and Data Loader operations often process multiple records simultaneously.

---

# 📊 Bulkified Processing Workflow

```text
Receive Multiple Records
        │
        ▼
Collect Required IDs
        │
        ▼
Execute One SOQL Query
        │
        ▼
Store Results in Collections
        │
        ▼
Apply Business Logic
        │
        ▼
Collect Modified Records
        │
        ▼
Execute One DML Operation
```

Each step is designed to minimize database interactions while maximizing performance.

---

# 🌟 Benefits of Bulkification

- ✅ Improves application performance.
- ✅ Reduces unnecessary database queries.
- ✅ Minimizes DML operations.
- ✅ Prevents Governor Limit exceptions.
- ✅ Handles large volumes of records efficiently.
- ✅ Supports enterprise-scale Salesforce applications.
- ✅ Produces cleaner and more maintainable Apex code.

---

# 💡 Key Takeaways

- Always execute **SOQL queries outside loops**.
- Perform **one SOQL query** whenever possible instead of many small queries.
- Avoid placing **DML statements inside loops**.
- Modify records in collections and save them using **a single DML operation**.
- Think in terms of **collections**, not individual records.
- Writing **bulkified Apex code** ensures that applications remain efficient, scalable, and compliant with Salesforce Governor Limits.

> **"Efficient Apex code is not measured by how well it processes one record, but by how reliably it processes hundreds of records in a single transaction."**
