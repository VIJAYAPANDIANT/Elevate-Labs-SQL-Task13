# 📊 Elevate Lab SQL Task 13: SQL Transactions & ACID Properties - Banking System

A professional SQL project demonstrating the core concepts of SQL Transactions, including ACID properties, Isolation Levels, and Concurrency Handling. It covers money transfers, rollback scenarios, and row-level locking to ensure data integrity and prevent race conditions within a practical banking context.

## 📌 Project Objective
The primary goal of this task is to understand how databases manage transactions and concurrency. It illustrates how to ensure that multiple operations succeed or fail as a single unit (Atomicity) and how to prevent simultaneous database operations from corrupting data (Isolation) using practical banking scenarios.

## 🛠️ Technical Scope
- **Database Management System**: SQL (MySQL / PostgreSQL / SQL Server compatible)
- **Core Concepts**: SQL Transactions, ACID Properties (Atomicity, Consistency, Isolation, Durability), `COMMIT`, `ROLLBACK`
- **Advanced Techniques**: Transaction Isolation Levels, Dirty Reads, Row-Level Locking (`FOR UPDATE`), Concurrency Handling

## 🗄️ Database Schema

### `accounts` Table
| Column | Data Type | Constraint / Description |
| :--- | :--- | :--- |
| `acc_id` | INT | Primary Key |
| `name` | VARCHAR(50) | Account holder name |
| `balance` | DECIMAL(10,2) | Current balance |

## 💻 SQL Implementations
Key operations demonstrated in the script:

- **Database & Schema Setup**: Creation of the `task13` database and the `accounts` table with initial seed data.
- **Basic Transactions**: Executing a standard money transfer between two accounts, utilizing `START TRANSACTION` and `COMMIT` to ensure both deduction and addition succeed together.
- **Simulate Failure & ROLLBACK**: Demonstrating atomicity by intentionally introducing a failure mid-transaction and using `ROLLBACK` to revert all changes, preventing partial transfers.
- **ACID Properties**: Providing practical examples and explanations for Atomicity, Consistency, Isolation, and Durability in the context of the banking system.
- **Transaction Isolation Levels**: Exploring how different levels (`READ UNCOMMITTED`, `READ COMMITTED`, `REPEATABLE READ`, `SERIALIZABLE`) handle visibility of uncommitted data, including a demonstration of "Dirty Reads".
- **Concurrency Handling (Row Locking)**: Applying row-level locks using `FOR UPDATE` to prevent race conditions when multiple sessions attempt to update the same account simultaneously.

## 🚀 Setup & Execution

- **Initialize**: Execute the script to create the `task13` database and `accounts` table.
- **Run Basic Transactions**: Observe the successful execution of the money transfer transaction.
- **Test Rollbacks**: Execute the failure scenario to see how `ROLLBACK` maintains original balances.
- **Experiment with Isolation Levels**: Open two separate database sessions to test the Dirty Read scenario and observe how changing isolation levels prevents read anomalies.
- **Test Concurrency**: Run the row-locking example to understand how concurrent updates are managed and prevented from overlapping.

> [!IMPORTANT]
> Understanding transaction isolation and concurrency control is critical for building robust applications. While setting a high isolation level like `SERIALIZABLE` prevents all read anomalies, it can severely impact performance due to heavy locking. Choosing the right isolation level involves carefully balancing data consistency requirements with system concurrency and performance.

*Developed for Elevate Lab Internship Program - SQL Practice and Interview Preparation.*
