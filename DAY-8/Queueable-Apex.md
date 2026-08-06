# 🚀 Queueable Apex in Salesforce

![Salesforce](https://img.shields.io/badge/Salesforce-Queueable%20Apex-blue?style=for-the-badge&logo=salesforce)
![Apex](https://img.shields.io/badge/Apex-Asynchronous-red?style=for-the-badge)
![Queueable](https://img.shields.io/badge/Background-Job-success?style=for-the-badge)

---

# 📖 Introduction

As Salesforce applications become larger and more complex, developers often need to perform background operations that require more flexibility than Future Methods can provide.

To address this need, Salesforce introduced **Queueable Apex**.

Queueable Apex is an asynchronous programming feature that allows developers to execute background jobs with greater control and flexibility. It supports complex data types, enables job chaining, provides job monitoring, and is considered the recommended replacement for Future Methods in many scenarios.

Queueable Apex is widely used in enterprise applications because it combines the simplicity of Future Methods with additional capabilities required for modern business applications.

---

# 🎯 Learning Objectives

After completing this topic, you will be able to:

- Understand what Queueable Apex is.
- Learn how Queueable Apex works.
- Implement Queueable Apex classes.
- Submit Queueable jobs for execution.
- Monitor background jobs.
- Understand Queueable Chaining.
- Identify real-world use cases.
- Follow Salesforce best practices.

---

# 📚 What is Queueable Apex?

Queueable Apex is a type of Asynchronous Apex that allows developers to execute background jobs by implementing the **Queueable** interface.

Instead of executing immediately, the job is added to Salesforce's asynchronous job queue and runs whenever system resources become available.

Unlike Future Methods, Queueable Apex supports complex objects, provides a Job ID, and allows multiple background jobs to be linked together.

---

# 🤔 Why Queueable Apex?

Future Methods work well for simple operations, but they have several limitations:

- Only primitive parameters are allowed.
- Jobs cannot be chained.
- Job status cannot be monitored easily.
- Complex business logic becomes difficult to manage.

Queueable Apex overcomes these limitations and provides a more flexible solution.

---

# 🔄 How Queueable Apex Works

```
User Performs Action
        │
        ▼
Queueable Job Created
        │
        ▼
Job Added to Queue
        │
        ▼
Current Transaction Ends
        │
        ▼
Salesforce Executes Queueable Job
        │
        ▼
Background Processing Completed
```

The user receives an immediate response while Salesforce processes the remaining work asynchronously.

---

# ⚙️ Queueable Interface

Every Queueable Apex class must implement the **Queueable** interface.

The interface contains a single required method:

```apex
execute(QueueableContext context)
```

This method contains all the business logic that Salesforce executes asynchronously.

---

# 🛠 Basic Queueable Apex Example

```apex
public class StudentQueueJob implements Queueable{

    public void execute(QueueableContext context){

        System.debug('Queueable Job Started');

    }

}
```

This class becomes eligible for background execution.

---

# 🚀 Enqueueing a Queueable Job

Queueable classes are started using:

```apex
System.enqueueJob(new StudentQueueJob());
```

Salesforce immediately returns a **Job ID**.

The job is then placed into the asynchronous queue.

---

# 📌 Real-World Example

Consider a Placement Management System.

When a company uploads placement results:

Immediate task:

- Save the uploaded data.

Background tasks:

- Update student placement status.
- Send notification emails.
- Refresh placement statistics.
- Create audit records.

These background operations are excellent candidates for Queueable Apex.

---

# 📊 Execution Flow

```
Placement Results Uploaded
            │
            ▼
Records Saved
            │
            ▼
Queueable Job Created
            │
            ▼
Job Added to Queue
            │
            ▼
Salesforce Executes Job
            │
            ▼
Notifications Sent
Statistics Updated
Audit Records Created
```

---

# 📦 Passing Objects

One major advantage of Queueable Apex is that it supports complex objects.

Example:

```apex
public class StudentQueueJob implements Queueable{

    private List<Account> accounts;

    public StudentQueueJob(List<Account> accList){

        accounts = accList;

    }

    public void execute(QueueableContext context){

        update accounts;

    }

}
```

Unlike Future Methods, Queueable Apex allows developers to pass collections of sObjects directly.

---

# 🔗 Queueable Chaining

One Queueable job can start another Queueable job after finishing.

```
Queueable Job 1
        │
        ▼
Queueable Job 2
        │
        ▼
Queueable Job 3
```

This process is known as **Queueable Chaining**.

It helps divide large business processes into smaller independent jobs.

---

# 💡 Example Scenario

Suppose an organization imports placement data.

Job 1:

- Validate uploaded records.

↓

Job 2:

- Update student records.

↓

Job 3:

- Generate reports.

↓

Job 4:

- Send email notifications.

Instead of one huge class, each responsibility is handled independently.

---

# 📊 Monitoring Queueable Jobs

Every Queueable Job receives a unique Job ID.

```apex
Id jobId = System.enqueueJob(new StudentQueueJob());
```

Developers can monitor execution using:

- Apex Jobs
- Setup → Apex Jobs

This helps identify:

- Job Status
- Start Time
- Completion Time
- Errors
- Failures

---

# 🌟 Advantages

Queueable Apex offers many benefits.

### Better than Future Methods

Supports more complex processing.

---

### Supports sObjects

Entire objects and collections can be passed.

---

### Job Monitoring

Every job has its own Job ID.

---

### Queueable Chaining

Jobs can execute sequentially.

---

### Better Maintainability

Large tasks can be divided into multiple smaller jobs.

---

### Improved Scalability

Handles enterprise workloads more efficiently.

---

# ⚠️ Limitations

Although Queueable Apex is powerful, it still has limitations.

- Jobs execute asynchronously.
- Execution time is not immediate.
- Subject to asynchronous governor limits.
- Long-running operations may require Batch Apex.

---

# 💼 Best Practices

- Keep Queueable classes focused on one responsibility.
- Divide large processes into smaller jobs.
- Use Queueable Chaining only when necessary.
- Handle exceptions properly.
- Monitor failed jobs regularly.
- Avoid unnecessary Queueable Jobs.

---

# 🚫 Common Mistakes

Avoid the following:

- Creating very large Queueable classes.
- Ignoring failed jobs.
- Writing unrelated business logic in one class.
- Using Queueable Apex for very small synchronous tasks.

---

# 🔍 Queueable Apex vs Future Methods

| Feature | Future Method | Queueable Apex |
|----------|--------------|----------------|
| Background Execution | ✅ | ✅ |
| Complex Objects | ❌ | ✅ |
| Job ID | ❌ | ✅ |
| Job Monitoring | Limited | ✅ |
| Job Chaining | ❌ | ✅ |
| Recommended Today | Limited | ✅ |

---

# 🎤 Interview Questions

### What is Queueable Apex?

Queueable Apex is an asynchronous Apex feature that executes background jobs using the Queueable interface.

---

### Why is Queueable Apex preferred over Future Methods?

Because it supports complex objects, provides Job IDs, allows monitoring, and supports job chaining.

---

### Which interface must a Queueable class implement?

```
Queueable
```

---

### Which method is required?

```
execute(QueueableContext context)
```

---

### How is a Queueable job started?

```
System.enqueueJob(new MyQueueableClass());
```

---

### What is Queueable Chaining?

Queueable Chaining is the process of starting another Queueable job from within an existing Queueable job.

---

### Where can Queueable jobs be monitored?

```
Setup → Apex Jobs
```

---

# 📚 Key Takeaways

- Queueable Apex executes background jobs asynchronously.
- It provides greater flexibility than Future Methods.
- Supports complex objects and collections.
- Every Queueable job receives a Job ID.
- Queueable Chaining enables multiple background jobs to execute sequentially.
- Queueable Apex is recommended for most enterprise asynchronous processing requirements.

---

# 📝 Summary

Queueable Apex is a powerful asynchronous processing feature that enables Salesforce developers to execute background tasks efficiently while providing advanced capabilities such as job monitoring, complex object support, and job chaining. By breaking large business operations into manageable background jobs, Queueable Apex improves application performance, scalability, and maintainability, making it one of the most widely used asynchronous technologies in enterprise Salesforce development.
