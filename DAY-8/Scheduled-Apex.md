# ⏰ Scheduled Apex in Salesforce

![Salesforce](https://img.shields.io/badge/Salesforce-Scheduled%20Apex-blue?style=for-the-badge&logo=salesforce)
![Apex](https://img.shields.io/badge/Apex-Automation-red?style=for-the-badge)
![Scheduler](https://img.shields.io/badge/Background-Scheduler-success?style=for-the-badge)

---

# 📖 Introduction

Many business activities need to run automatically at specific times instead of waiting for a user to start them. Examples include generating daily reports, sending reminder emails, updating records overnight, or performing regular maintenance.

Salesforce provides **Scheduled Apex** to automate these recurring tasks.

Scheduled Apex allows developers to write Apex classes that execute automatically according to a predefined schedule. Instead of manually running the code every day or every week, Salesforce executes it at the specified time using a scheduling mechanism.

This feature is especially useful for recurring operations that need to run consistently without user intervention.

---

# 🎯 Learning Objectives

After completing this topic, you will be able to:

- Understand Scheduled Apex.
- Learn why Scheduled Apex is used.
- Implement Scheduled Apex classes.
- Understand the Schedulable interface.
- Learn CRON expressions.
- Schedule Apex jobs.
- Monitor scheduled jobs.
- Apply Scheduled Apex in real-world business scenarios.

---

# 📚 What is Scheduled Apex?

Scheduled Apex is an asynchronous Apex feature that allows developers to execute Apex code automatically at a specified date and time.

Instead of relying on users to run a process manually, Salesforce executes the scheduled job according to the defined schedule.

Scheduled Apex is commonly used for tasks that must occur repeatedly, such as every day, every week, or every month.

---

# 🤔 Why Use Scheduled Apex?

Imagine a placement management system where recruiters expect a placement summary report every morning.

Without Scheduled Apex:

- A user must remember to generate the report manually.
- Reports may be delayed or forgotten.
- Business processes become inconsistent.

With Scheduled Apex:

- Salesforce automatically generates the report every morning.
- The process runs consistently.
- No user action is required.

---

# 🔄 How Scheduled Apex Works

```
Administrator Creates Schedule
            │
            ▼
Salesforce Stores Schedule
            │
            ▼
Specified Time Arrives
            │
            ▼
Scheduled Apex Executes
            │
            ▼
Background Task Completed
```

---

# 🏗 Schedulable Interface

Every Scheduled Apex class must implement the **Schedulable** interface.

This interface requires one method:

```apex
execute(SchedulableContext context)
```

Salesforce automatically calls this method when the scheduled time is reached.

---

# ⚙️ Basic Scheduled Apex Example

```apex
public class DailyReportScheduler implements Schedulable{

    public void execute(SchedulableContext context){

        System.debug('Generating Daily Placement Report');

    }

}
```

This class can now be scheduled to execute automatically.

---

# 📅 Scheduling the Job

Scheduled Apex jobs are started using:

```apex
String cron =
'0 0 8 * * ?';

System.schedule(
    'Daily Report',
    cron,
    new DailyReportScheduler()
);
```

Salesforce stores the schedule and executes the class every day at **8:00 AM**.

---

# 📌 Understanding CRON Expressions

Salesforce uses **CRON expressions** to define when a scheduled job should execute.

General format:

```
Seconds
Minutes
Hours
Day of Month
Month
Day of Week
Optional Year
```

Example:

```
0 0 8 * * ?
```

Meaning:

| Value | Meaning |
|--------|---------|
| 0 | At second 0 |
| 0 | At minute 0 |
| 8 | At 8 AM |
| * | Every day of month |
| * | Every month |
| ? | No specific weekday |

This schedules the job every day at **8:00 AM**.

---

# 🏢 Real-World Example

Suppose a company wants to send weekly placement statistics every Monday morning.

Scheduled Apex can automatically:

- Calculate placement statistics.
- Generate reports.
- Email placement coordinators.
- Archive previous reports.

No manual execution is required.

---

# 📊 Execution Flow

```
Create Schedule
        │
        ▼
Store CRON Expression
        │
        ▼
Wait Until Scheduled Time
        │
        ▼
execute() Method Runs
        │
        ▼
Business Process Completed
```

---

# 🌟 Common Business Use Cases

Scheduled Apex is commonly used for:

- Daily report generation.
- Weekly placement summaries.
- Monthly data cleanup.
- Nightly record updates.
- Sending reminder emails.
- Archiving old records.
- Synchronizing external systems.
- Running Batch Apex automatically.

---

# 📈 Advantages

### Automation

Business processes execute automatically.

---

### Consistency

Tasks always execute at the correct time.

---

### Time Saving

Eliminates manual execution.

---

### Better Productivity

Developers automate repetitive work.

---

### Integration

Can automatically start Batch Apex or Queueable Apex jobs.

---

# ⚠️ Limitations

- Jobs execute only at scheduled times.
- Incorrect CRON expressions may result in unexpected schedules.
- Scheduled jobs consume asynchronous resources.
- Governor limits still apply during execution.

---

# 💼 Best Practices

- Schedule jobs only when required.
- Keep the execute() method simple.
- Use Scheduled Apex to start Batch Apex for large datasets.
- Monitor scheduled jobs regularly.
- Remove obsolete schedules.
- Use meaningful job names.

---

# 🚫 Common Mistakes

Avoid these mistakes:

- Creating duplicate schedules.
- Using incorrect CRON expressions.
- Scheduling unnecessary jobs.
- Writing complex logic directly inside execute().
- Ignoring failed scheduled jobs.

---

# 🔍 Scheduled Apex vs Batch Apex

| Feature | Scheduled Apex | Batch Apex |
|----------|----------------|------------|
| Purpose | Execute at a specific time | Process large datasets |
| Runs Automatically | ✅ | Only if scheduled or started |
| Handles Millions of Records | ❌ | ✅ |
| Uses CRON Expression | ✅ | ❌ |
| Common Use | Automation | Data Processing |

---

# 🎤 Interview Questions

### What is Scheduled Apex?

Scheduled Apex allows Apex classes to execute automatically at specified times.

---

### Which interface must be implemented?

```
Schedulable
```

---

### Which method is required?

```apex
execute(SchedulableContext context)
```

---

### What is a CRON expression?

A CRON expression defines the schedule for executing a Scheduled Apex job.

---

### Can Scheduled Apex start Batch Apex?

Yes. Scheduled Apex is commonly used to execute Batch Apex automatically.

---

### Where can scheduled jobs be monitored?

```
Setup → Scheduled Jobs
```

---

# 📚 Key Takeaways

- Scheduled Apex automates recurring business processes.
- Jobs execute according to CRON expressions.
- The `Schedulable` interface is required.
- Scheduled Apex reduces manual work.
- It is commonly used with Batch Apex for large-scale automation.
- Monitoring scheduled jobs helps ensure reliable execution.

---

# 📝 Summary

Scheduled Apex enables Salesforce developers to automate recurring business tasks by executing Apex code at predefined times. By implementing the **Schedulable** interface and defining a CRON expression, developers can ensure that reports, maintenance tasks, notifications, and data processing jobs run automatically. Scheduled Apex plays an important role in enterprise Salesforce applications by improving automation, consistency, and operational efficiency.
