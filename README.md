# Validation Rules & Record-Triggered Flows

## 📌 Overview

The objective of Day 3 was to learn Salesforce declarative automation, build Record-Triggered Flows, design Validation Rules, and understand when to use Flow, Validation Rules, or Apex Triggers.

---

## 🛠️ Business Requirements

The Placement Management System required the following automation:

- Automatically populate the Application Date.
- Send a confirmation email to the Placement Officer.
- Prevent duplicate applications.
- Reject applications with low CGPA.
- Create an Offer Letter when the application status becomes **Selected**.

---

## 🚀 Features Implemented

### Record-Triggered Flows

- Before Save Flow to automatically populate Application Date.
- After Save Flow to send confirmation email.
- After Save Flow to create an Offer Letter record when Status becomes **Selected**.

### Validation Rules

- Student CGPA validation.
- Application Date validation.
- Mandatory field validation.

---

# Assignment Questions

## 1. Which requirements did you solve using Flow?

I used Record-Triggered Flows to:

- Automatically populate the Application Date.
- Send a confirmation email to the Placement Officer.
- Automatically create an Offer Letter record when the application status becomes **Selected**.

---

## 2. Which requirements required Validation Rules?

Validation Rules were used to:

- Validate Student CGPA.
- Ensure the Application Date is not after the Job Closing Date.
- Prevent mandatory fields from being left blank.

---

## 3. Which requirements still needed Apex?

For this assignment, Apex was not required because all requirements were implemented using Salesforce declarative tools.

Apex would be preferred only for:

- Complex business logic
- Advanced calculations
- Bulk processing
- External integrations

---

## 4. Why did you choose those solutions?

I followed Salesforce's **Clicks Before Code** approach.

- Validation Rules were used for data validation.
- Record-Triggered Flows were used for automation.
- Apex was not used because declarative tools were sufficient.

---

## 💡 Key Learnings

- Learned the difference between Validation Rules, Flows, and Apex Triggers.
- Built Before Save and After Save Flows.
- Automated business processes without writing Apex.
- Understood Salesforce automation best practices.

---

## 🏆 Outcome

Successfully enhanced the Placement Management System using Salesforce declarative automation and gained practical experience with Flow Builder and Validation Rules.
