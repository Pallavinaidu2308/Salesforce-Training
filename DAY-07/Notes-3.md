# 📚 Collections in Apex

Collections are special data structures in Apex that help developers work with **multiple values or records at the same time**. Instead of creating separate variables for each record, collections organize related data into a single object, making the code more efficient and easier to manage.

Collections play an important role in **Bulkification**, allowing Apex code to process many records in a single transaction while staying within Salesforce Governor Limits.

Salesforce provides three primary collection types:

- 📋 List
- 🎯 Set
- 🗺️ Map

Each collection serves a different purpose and should be used based on the application's requirements.

---

# 📋 List

A **List** is an ordered collection that stores multiple values or records in the order they are added.

Unlike some other collections, Lists can contain duplicate values and allow elements to be accessed using their index position.

### Key Features

- Maintains insertion order
- Allows duplicate values
- Supports index-based access
- Suitable for processing multiple records

---

## Example

```apex
List<String> products = new List<String>{
    'Laptop',
    'Keyboard',
    'Mouse'
};

System.debug(products);
```

### Output

```text
(Laptop, Keyboard, Mouse)
```

---

## When to Use a List

Lists are commonly used when you need to:

- Store multiple records
- Display records in order
- Process records from `Trigger.new`
- Perform bulk insert or update operations
- Iterate through a collection of records

---

# 🎯 Set

A **Set** is a collection that stores only **unique values**.

If the same value is added more than once, the duplicate is automatically ignored.

Sets are especially useful when collecting unique record IDs before executing a SOQL query.

### Key Features

- Stores only unique values
- Automatically removes duplicates
- Does not maintain insertion order
- Provides efficient searching

---

## Example

```apex
Set<String> technologies = new Set<String>();

technologies.add('Apex');
technologies.add('Flow');
technologies.add('Apex');

System.debug(technologies);
```

### Output

```text
(Apex, Flow)
```

Although **Apex** was added twice, it appears only once because Sets do not allow duplicate values.

---

## When to Use a Set

Sets are useful when you need to:

- Remove duplicate values
- Collect unique record IDs
- Prepare IDs for SOQL queries
- Validate unique data
- Improve search efficiency

---

# 🗺️ Map

A **Map** stores information as **key-value pairs**.

Each key is unique and is associated with a corresponding value.

Maps allow records to be retrieved directly using a key instead of searching through an entire collection, making data access much faster.

### Key Features

- Stores data as key-value pairs
- Keys must be unique
- Supports fast record lookup
- Frequently used in bulkified Apex code

---

## Example

```apex
Map<Integer, String> departments = new Map<Integer, String>();

departments.put(101, 'Sales');
departments.put(102, 'Support');

System.debug(departments);
```

### Output

```text
{101=Sales, 102=Support}
```

---

## Salesforce Example

```apex
Map<Id, Account> accountMap;
```

This allows an Account record to be retrieved quickly using its Salesforce Id without executing another SOQL query.

---

## When to Use a Map

Maps are commonly used to:

- Retrieve records using their Id
- Store related information
- Reduce repeated database queries
- Improve application performance
- Support bulk processing

---

# 🔄 Trigger Collections

When an Apex Trigger executes, Salesforce automatically provides collections containing the records involved in the transaction.

These collections make it possible to process multiple records efficiently.

---

# 📥 Trigger.new

`Trigger.new` contains the latest version of records that are being inserted or updated.

It is commonly used to access new field values.

## Example

```apex
for(Account acc : Trigger.new){

    System.debug(acc.Name);

}
```

Each iteration accesses one record from the collection.

---

# 📤 Trigger.old

`Trigger.old` contains the previous version of records before they were updated or deleted.

It is useful for comparing old and new values.

For example, you can determine whether a field has changed during an update operation.

---

# 🗂️ Trigger.newMap

`Trigger.newMap` stores the latest records in the form of a **Map<Id, SObject>**.

Because records are stored using their Id as the key, they can be accessed very quickly.

## Example

```apex
Account acc = Trigger.newMap.get(recordId);
```

---

# 🗂️ Trigger.oldMap

`Trigger.oldMap` stores the previous version of records using their Id as the key.

This is especially useful when comparing values before and after an update.

## Example

```apex
Account oldAcc = Trigger.oldMap.get(recordId);
```

---

# 🎯 Choosing the Right Collection

| Requirement | Recommended Collection |
|-------------|------------------------|
| Store multiple records in order | 📋 List |
| Remove duplicate values | 🎯 Set |
| Retrieve records quickly using a key | 🗺️ Map |

Selecting the appropriate collection improves both performance and code readability.

---

# 💼 Best Practices

- ✅ Use **Lists** to process multiple records together.
- ✅ Use **Sets** when duplicate values should be removed.
- ✅ Use **Maps** for efficient record lookup.
- ✅ Process records using Trigger collections instead of individual variables.
- ✅ Design Apex code to work with collections for better scalability.
- ✅ Combine Lists, Sets, and Maps to build efficient bulkified applications.

---

# 📊 Collection Summary

| Collection | Primary Purpose | Duplicate Values |
|------------|-----------------|-----------------|
| 📋 List | Stores ordered collections of records | ✅ Allowed |
| 🎯 Set | Stores unique values only | ❌ Not Allowed |
| 🗺️ Map | Stores key-value pairs for fast lookup | Keys must be unique |

---

# 🌟 Key Takeaway

Understanding **Lists**, **Sets**, **Maps**, and **Trigger Collections** is essential for writing efficient Apex code. By choosing the right collection for the right task, developers can build applications that are easier to maintain, process large volumes of data efficiently, and follow Salesforce bulkification best practices.
