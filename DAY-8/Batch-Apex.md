# 🚀 Batch Apex in Salesforce

![Salesforce](https://img.shields.io/badge/Salesforce-Batch%20Apex-blue?style=for-the-badge&logo=salesforce)
![Apex](https://img.shields.io/badge/Apex-Large%20Data-red?style=for-the-badge)
![Batch](https://img.shields.io/badge/Background-Processing-success?style=for-the-badge)

---

# 📖 Introduction

In enterprise applications, developers often work with thousands or even millions of records. Processing all these records in a single transaction can exceed Salesforce Governor Limits, resulting in exceptions and failed operations.

To solve this challenge, Salesforce provides **Batch Apex**, a powerful asynchronous processing feature designed specifically for handling large datasets.

Batch Apex divides a large collection of records into smaller groups called **batches**. Each batch is processed as an independent transaction, allowing Salesforce to efficiently manage system resources while staying within Governor Limits.

Batch Apex is commonly used for data maintenance, scheduled updates, report generation, data migration, and large-scale business operations.

---

# 🎯 Learning Objectives

After completing this topic, you will be able to:

- Understand Batch Apex.
- Learn why Batch Apex is needed.
- Understand the Batch Apex lifecycle.
- Implement Batch Apex classes.
- Process records in batches.
- Learn about Stateful Batch Apex.
- Monitor Batch Jobs.
- Apply Batch Apex in real-world scenarios.

---

# 📚 What is Batch Apex?

Batch Apex is an asynchronous Apex feature that processes **large numbers of records** by dividing them into smaller batches.

Instead of processing all records together, Salesforce processes one batch at a time.

Each batch executes independently, meaning Governor Limits are reset after every batch.

This makes Batch Apex ideal for processing very large datasets efficiently.

---

# 🤔 Why Batch Apex?

Imagine a university placement portal containing:

- 250,000 Students
- 8,000 Companies
- 500,000 Applications

Suppose the placement office wants to update the status of every application.

Processing all records in one transaction would exceed Salesforce Governor Limits.

Instead, Batch Apex divides the work into manageable batches.

Example:

```
500,000 Records

        │

        ▼

Batch 1 (200 Records)

        ▼

Batch 2 (200 Records)

        ▼

Batch 3 (200 Records)

        ▼

...

        ▼

Batch Completed
```

Each batch runs independently, making the process scalable and efficient.

---

# 🔄 How Batch Apex Works

The Batch Apex lifecycle consists of three methods.

```
Start()

      │

      ▼

Execute()

      │

      ▼

Finish()
```

Salesforce automatically calls these methods in sequence.

---

# 🏗 Database.Batchable Interface

Every Batch Apex class must implement the **Database.Batchable** interface.

```apex
public class StudentBatchJob implements Database.Batchable<SObject>{

}
```

This interface requires three methods:

- start()
- execute()
- finish()

---

# ⚙️ Method 1 – start()

The **start()** method identifies the records that need to be processed.

It returns either:

- Database.QueryLocator
- Iterable Collection

Example:

```apex
public Database.QueryLocator start(Database.BatchableContext bc){

    return Database.getQueryLocator(
        'SELECT Id, Name FROM Student__c'
    );

}
```

Salesforce retrieves the records and automatically divides them into batches.

---

# ⚙️ Method 2 – execute()

The **execute()** method processes one batch of records at a time.

```apex
public void execute(
    Database.BatchableContext bc,
    List<Student__c> students
){

    for(Student__c student : students){

        student.Status__c = 'Verified';

    }

    update students;

}
```

If the batch size is 200, this method receives 200 records at a time.

After completing one batch, Salesforce automatically starts the next batch.

---

# ⚙️ Method 3 – finish()

The **finish()** method executes after every batch has completed.

Typical tasks include:

- Sending completion emails.
- Updating reports.
- Logging execution details.
- Starting another Batch Job.

Example:

```apex
public void finish(Database.BatchableContext bc){

    System.debug('Batch Processing Completed');

}
```

---

# 📊 Batch Apex Execution Flow

```
User Starts Batch

        │

        ▼

start()

        │

        ▼

Retrieve Records

        │

        ▼

Divide Into Batches

        │

        ▼

execute()

        │

        ▼

Process Batch

        │

        ▼

Next Batch

        │

        ▼

finish()

        │

        ▼

Job Completed
```

---

# 📦 Batch Size

Salesforce automatically processes records in groups.

The default batch size is:

```
200 Records
```

Developers can specify a different size.

Example:

```apex
Database.executeBatch(
    new StudentBatchJob(),
    100
);
```

Now Salesforce processes:

```
100 Records

↓

100 Records

↓

100 Records
```

until all records are processed.

---

# 🌟 Stateful Batch Apex

Normally, Batch Apex treats every batch as a separate transaction.

If information needs to be preserved between batches, implement:

```apex
Database.Stateful
```

Example:

```apex
public class StudentBatchJob
implements Database.Batchable<SObject>,
           Database.Stateful{

    Integer totalUpdated = 0;

}
```

Now the variable **totalUpdated** retains its value across every batch.

---

# 🏢 Real-World Example

Imagine a company wants to archive inactive customer records every weekend.

Instead of updating 500,000 records simultaneously:

```
Retrieve Customers

        │

        ▼

Batch 1

Archive Records

        ▼

Batch 2

Archive Records

        ▼

Batch 3

Archive Records

        ▼

finish()

Send Completion Email
```

This approach keeps the application efficient and within Governor Limits.

---

# 📈 Advantages

Batch Apex provides many benefits.

### Processes Large Datasets

Suitable for millions of records.

---

### Governor Limits Reset

Every batch receives a fresh set of limits.

---

### Better Performance

Large operations are divided into smaller transactions.

---

### Automatic Error Isolation

If one batch fails, other batches continue processing.

---

### Supports Scheduling

Batch jobs can be combined with Scheduled Apex for automatic execution.

---

# ⚠️ Limitations

- Executes asynchronously.
- Slower than synchronous operations.
- Requires Batchable implementation.
- Complex debugging.
- Not suitable for small datasets.

---

# 💼 Best Practices

- Use Batch Apex only for large datasets.
- Keep execute() focused on one responsibility.
- Avoid unnecessary SOQL queries.
- Avoid DML inside loops.
- Handle exceptions carefully.
- Use Stateful only when required.
- Monitor Batch Jobs regularly.

---

# 🚫 Common Mistakes

Avoid these mistakes:

- Using Batch Apex for only a few records.
- Writing heavy logic inside one execute() method.
- Ignoring governor limits.
- Executing unnecessary SOQL queries.
- Performing DML inside loops.

---

# 📊 Batch Apex vs Queueable Apex

| Feature | Queueable Apex | Batch Apex |
|----------|----------------|------------|
| Best For | Medium Tasks | Very Large Datasets |
| Batch Processing | ❌ | ✅ |
| Millions of Records | ❌ | ✅ |
| Stateful Support | ❌ | ✅ |
| Job Chaining | ✅ | Limited |
| Scheduled Execution | Possible | Common |

---

# 🎤 Interview Questions

### What is Batch Apex?

Batch Apex is an asynchronous Apex feature used to process large numbers of records in smaller batches.

---

### Which interface is implemented?

```
Database.Batchable<SObject>
```

---

### Which three methods are required?

- start()
- execute()
- finish()

---

### What does start() do?

Retrieves the records to be processed.

---

### What does execute() do?

Processes one batch of records.

---

### What does finish() do?

Performs tasks after all batches have completed.

---

### What is the default batch size?

```
200 Records
```

---

### Why use Database.Stateful?

To preserve variable values across multiple batches.

---

### When should Batch Apex be used?

When processing thousands or millions of records that cannot be handled in a single transaction.

---

# 🌟 Key Takeaways

- Batch Apex processes large datasets efficiently.
- Records are divided into smaller batches.
- Each batch executes independently.
- Governor Limits reset for every batch.
- Batch Apex supports scheduling and stateful processing.
- It is the preferred solution for enterprise-scale data processing.

---

# 📝 Summary

Batch Apex is one of Salesforce's most powerful asynchronous processing tools for handling large volumes of data. By dividing records into smaller batches, it enables developers to process millions of records efficiently while staying within Governor Limits. With its structured lifecycle of **start()**, **execute()**, and **finish()**, Batch Apex provides a reliable, scalable, and maintainable solution for enterprise data processing tasks.
