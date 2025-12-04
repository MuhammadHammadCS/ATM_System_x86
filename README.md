# ATM Management System – MASM x86 (Irvine32)

A fully functional **ATM Banking System** implemented in **MASM x86 Assembly Language** using the **Irvine32 library**.
This project simulates real-world ATM features including authentication, transactions, fund transfer, history logging, and an admin management panel.

---

## Group Members

* **Abdullah (24k-0859)**
* **Muhammad Hammad (24k-0544)**
* **Abdul Majid (24k-0895)**

**Submission Date:** 25 Nov 2025

---

## Executive Summary

This project demonstrates how complex banking operations can be implemented at a low level using MASM Assembly. The system includes:

* User login/signup
* Withdraw, deposit, transfers
* Balance inquiry
* Transaction history
* Admin tools for user/account management
* Manual memory management using arrays and registers

The system supports **20 users**, uses **unique ID generation**, and stores all data in memory.

---

# 1. Introduction

### Background

Assembly Language provides granular control over hardware, memory, and execution flow.
The project integrates structured programming concepts (modularity, abstraction, data organization) within MASM, mimicking OOP-style organization.

### Objectives

* Develop a complete ATM simulation in **MASM x86 Assembly**
* Implement user and admin features
* Use arrays, fixed memory blocks, and low-level I/O
* Strengthen understanding of registers, stack, and memory operations

---

# 2. Project Description

### Included Features

* User Signup (with **unique ID generation**)
* Login Authentication
* Balance Inquiry
* Cash Withdrawal (with validation)
* Deposit
* Fund Transfer
* Transaction History (inflow/outflow)
* PIN Reset
* **Admin Mode:**

  * View all balances
  * Reset accounts
  * View user details

### Excluded Features

* File-based permanent storage
* GUI interface
* ATM card simulation
* Multi-currency support

### Tools & Technologies

* **MASM32 / Irvine32**
* **Visual Studio**
* Registers: `EAX`, `EBX`, `ECX`, `EDX`, `ESI`, `EDI`
* Stack operations (push/pop)

---

# 3. Methodology

### Approach

* Developed features module-by-module
* Weekly testing and debugging
* Modular procedures for every operation
* String handling via Irvine32 routines

### Team Responsibilities

| Member   | Role                    | Contribution                     |
| -------- | ----------------------- | -------------------------------- |
| Hammad   | Logic & Flow            | Login system, ID matching, loops |
| Majid    | Feature Development     | Withdraw, Deposit, Transfer      |
| Abdullah | Admin & Transaction Log | Admin panel, History logging     |

---

# 4. Project Implementation

### Structure

#### **Data Section**

Contains parallel arrays for:

* User IDs
* Passwords
* Names
* Phone numbers
* Addresses
* Account types
* Balances
* Transaction logs

#### **Code Section**

Includes procedures:

* `Signup`
* `Login`
* `UserMenu`
* `Withdraw`, `Deposit`, `Transfer`
* `ShowHistory`
* `ResetPIN`
* `AdminMode`
* `ViewBalances`, `ResetAccounts`, `AdminViewUsers`

Utility procedures:

* `RandomID`
* `StringCopy`
* `LogTransaction`

---

# 5. Functional Features

### Signup System

* Generates unique ID
* Stores name, phone, address, account type
* Initializes balance

### Login System

* Matches ID & password from arrays

### Balance Inquiry

Displays current user balance

### Withdrawal

* Validates multiple of 500
* Checks sufficient balance

### Deposit

* Adds amount and logs transaction

### Fund Transfer

* Validates recipient ID
* Updates both accounts

### Transaction History

* Shows inflow/outflow
* Supports 5 latest entries

### Admin Mode

* View all balances
* Reset all accounts
* View all user details

---

# 6. Testing & Results

### Testing Performed

* Created multiple user accounts
* Tested incorrect and correct passwords
* Withdrawals above/below limits
* Transfers to valid/invalid IDs
* Verified logs and balance updates
* Checked admin reset and view functions

### Outcomes

* All core ATM features work correctly
* Secure and validated inputs
* Modular and readable Assembly code
* Demonstrates strong low-level programming understanding

---

# 7. Conclusion

### Key Learnings

* Low-level memory and register manipulation
* Stack operations & control flow
* Real-world logic written in Assembly
* String handling, indexing, and data structures
* Modular procedure-based design in MASM

### Future Improvements

* Permanent storage via files
* Better user interface
* PIN encryption
* ATM card system
* Expand user capacity
