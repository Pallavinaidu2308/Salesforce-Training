# Salesforce Interview Readiness Bootcamp – Day 4
# 🚀 Your First Lightning Web Component (LWC)

## 📌 Project Overview

This project is part of the **Salesforce Interview Readiness Bootcamp**. The objective was to build the first **Lightning Web Component (LWC)** and understand how Salesforce develops modern, reusable, and interactive user interfaces using web technologies.

---

# 🎯 Objectives

- Understand the fundamentals of Lightning Web Components (LWC)
- Learn the structure of an LWC
- Build a reusable Lightning Web Component
- Display dynamic data using data binding
- Handle user interactions with JavaScript
- Deploy the component using Lightning App Builder

---

# 🛠️ Technologies Used

- Salesforce Platform
- Lightning Web Components (LWC)
- HTML
- JavaScript (ES6)
- XML (Configuration File)

---

# 📂 Project Structure

```
force-app
└── main
    └── default
        └── lwc
            └── placementHome
                ├── placementHome.html
                ├── placementHome.js
                └── placementHome.js-meta.xml
```

---

# 📄 File Responsibilities

## 📌 placementHome.html
Responsible for designing the user interface.

- Displays headings and labels
- Shows student information
- Displays application status
- Contains buttons
- Uses template expressions for data binding

---

## 📌 placementHome.js
Responsible for component logic.

- Stores variables
- Handles button click events
- Updates application status
- Displays welcome message
- Implements reactive data binding

---

## 📌 placementHome.js-meta.xml
Configuration file that makes the component available in Salesforce.

- Exposes the component
- Defines supported Lightning Pages
- Enables deployment through Lightning App Builder

---

# 🚀 Features Implemented

## ✅ Welcome Section

Displays:

```
Welcome to Vishnu Placement Portal
```

---

## ✅ Student Information

Displays the following details:

- Student Name : Kommula Durga Aravind
- Roll Number : 23PA1A0484
- Department : ECE

---

## ✅ Welcome Message

Button:

```
Show Welcome Message
```

Output:

```
Welcome to Salesforce Development
```

---

## ✅ Application Status

Initial Status

```
Not Applied
```

After clicking the Apply button

```
Applied
```

---

## ✅ Placement Dashboard

Displays:

- Placement Portal
- Today's Date
- Welcome Student
- Number of Companies
- Number of Jobs
- Applications Submitted

---

# 💡 Concepts Demonstrated

- Lightning Web Components Architecture
- Component-Based Development
- HTML Template
- JavaScript Controller
- Meta Configuration File
- Data Binding
- Event Handling
- Reactive Properties
- Lightning App Builder Deployment

---

# 📚 What I Learned

During this project, I learned:

- What Lightning Web Components (LWC) are
- How HTML, JavaScript, and XML work together
- Creating reusable Salesforce UI components
- Implementing data binding
- Handling button click events
- Deploying components using Lightning App Builder
- Difference between frontend (LWC) and backend (Apex)
- Importance of component-based development in Salesforce

---

# ❓ Interview Questions Covered

### What is Lightning Web Components (LWC)?

LWC is Salesforce's modern UI framework built using standard web technologies such as HTML, JavaScript, and CSS. It enables developers to create fast, lightweight, reusable, and maintainable components.

---

### Why did Salesforce introduce LWC?

- Better performance
- Faster rendering
- Uses modern web standards
- Easier to learn for web developers
- More secure architecture

---

### LWC vs Aura Components

| Lightning Web Components | Aura Components |
|---------------------------|-----------------|
| Faster | Comparatively slower |
| Based on Web Standards | Uses Aura Framework |
| Better Performance | Higher Framework Overhead |
| Easier to Maintain | More Complex |

---

### What are the three files inside an LWC?

1. HTML File
2. JavaScript File
3. Meta XML File

---

### Why is JavaScript required?

JavaScript handles:

- Business logic
- Variables
- Event handling
- Dynamic updates
- Data manipulation

---

### What is Data Binding?

Data Binding connects JavaScript variables with the HTML template so that any change in data is automatically reflected in the user interface.

---

### Can LWC execute SOQL directly?

No.

LWC cannot execute SOQL directly. It communicates with Apex classes, and Apex performs SOQL operations.

---

### Why does LWC need Apex?

Apex is required for:

- Database operations
- SOQL queries
- DML operations
- Business logic
- Calling Salesforce services

---

### Where is an LWC deployed?

An LWC can be deployed on:

- Lightning App Pages
- Home Pages
- Record Pages
- Experience Cloud Sites
- Utility Bar (supported scenarios)

---

### Explain your project.

I developed a Lightning Web Component named **placementHome** that displays student details, a welcome message, application status, and a simple placement dashboard. The project demonstrates component creation, data binding, event handling, and deployment using Lightning App Builder.

---

# 📖 README Questions

## 1. What is LWC?

Lightning Web Components (LWC) is Salesforce's modern component framework that uses HTML, JavaScript, and CSS to build fast, reusable, and scalable user interfaces.

---

## 2. What did you build?

I built my first Lightning Web Component named **placementHome**. It displays student information, placement details, application status, and demonstrates data binding with JavaScript event handling.

---

## 3. Which file contains HTML?

**placementHome.html**

This file defines the component's user interface including layout, labels, buttons, and dynamic content.

---

## 4. Which file contains JavaScript?

**placementHome.js**

This file contains variables, event handlers, and component logic.

---

## 5. What did you learn today?

I learned:

- Lightning Web Components architecture
- HTML, JavaScript, and Meta XML structure
- Data Binding
- Event Handling
- Component Deployment
- Relationship between LWC and Apex

---

# 🎯 Key Takeaways

✔ Built the first Lightning Web Component

✔ Learned component architecture

✔ Implemented data binding

✔ Added JavaScript event handling

✔ Deployed using Lightning App Builder

✔ Understood the role of Apex in Salesforce development

---

# 🔮 Future Enhancements

This component can be enhanced by integrating:

- Apex Classes
- SOQL Queries
- Salesforce Database
- Lightning Data Service (LDS)
- Dynamic Record Display
- Record Creation & Update
- Navigation Service
- Toast Notifications
- Form Validation

---

# 📌 Conclusion

This project provided a strong foundation in Lightning Web Components by combining HTML, JavaScript, and XML to build an interactive Salesforce application. It also prepared the groundwork for future topics such as Apex integration, SOQL queries, and real-time Salesforce database operations.
