# Placement Management System

## Project Overview

This project demonstrates automation in Salesforce using declarative tools such as Record-Triggered Flows and Validation Rules. The objective is to automate the student placement application process while maintaining data quality and reducing manual work.

## Features

- Automatically sets Application Date when a new application is created.
- Sends an email notification to the Placement Officer.
- Prevents invalid application data using Validation Rules.
- Rejects applications with CGPA below the required minimum.
- Automatically creates an Offer Letter record when the application status changes to **Selected**.

## Technologies Used

- Salesforce Flow Builder
- Validation Rules
- Apex (if applicable)
- Trailhead Playground

## Project Structure

```text
Flow Screenshots/
Validation Rules/
Apex/
README.md
```

## Flow Automation

- Record-Triggered Flow
- Before-Save Flow for Application Date
- After-Save Flow for Email Notification
- Automatic Offer Letter Creation

## Validation Rules

- CGPA Validation
- Application Date Validation
- Mandatory Field Validation

## Screenshots

Include screenshots of:

- Flow Canvas
- Assignment Element
- Email Action
- Successful Execution
- Validation Rules

## Learning Outcomes

- Built Record-Triggered Flows.
- Implemented Validation Rules.
- Understood when to use Flow, Validation Rules, and Apex.
- Improved Salesforce automation skills.

## Author

**Your Name**
