# SQL Transactions & ACID Properties - Banking System

This repository demonstrates the core concepts of **SQL Transactions**, including **ACID properties**, **Isolation Levels**, and **Concurrency Handling**, using a practical Banking System example.

## Table of Contents

- [Overview](#overview)
- [ACID Properties](#acid-properties)
- [Transaction Isolation Levels](#transaction-isolation-levels)
- [Concurrency Handling](#concurrency-handling)
- [How to Run](#how-to-run)

---

## Overview

The demonstration is based on a simple banking database with an `accounts` table. It includes:

- **Money Transfer**: A basic transaction moving funds between accounts.
- **Rollback Scenario**: Simulating failures to ensure data integrity.
- **Locking**: Using row-level locks to prevent race conditions.

```sql
-- Transfer ₹2000 from Alice → Bob
START TRANSACTION;
UPDATE accounts SET balance = balance - 2000 WHERE acc_id = 1;
UPDATE accounts SET balance = balance + 2000 WHERE acc_id = 2;
COMMIT;
```

## ACID Properties

This project illustrates the four pillars of database reliability:

1.  **Atomicity (A)**: All operations in a transaction succeed, or none do. If a system crash occurs mid-transfer, a `ROLLBACK` ensures no money is lost or created.
2.  **Consistency (C)**: The database remains valid according to predefined rules.
    - _Example_: A `CHECK (balance >= 0)` constraint prevents accounts from having negative balances.
3.  **Isolation (I)**: Transactions do not interfere with each other. This is managed through isolation levels.
4.  **Durability (D)**: Once a transaction is `COMMIT`ted, the changes are permanent, even in the event of a power failure or crash.

## Transaction Isolation Levels

The script demonstrates how different isolation levels affect data visibility and prevent common anomalies:

| Level                | Prevents                             |
| :------------------- | :----------------------------------- |
| **READ UNCOMMITTED** | Nothing (allows Dirty Reads)         |
| **READ COMMITTED**   | Dirty Reads                          |
| **REPEATABLE READ**  | Non-Repeatable Reads (MySQL Default) |
| **SERIALIZABLE**     | Phantom Reads                        |

### Dirty Read Example

A "Dirty Read" occurs when a transaction reads data that has been modified by another transaction but not yet committed.

```sql
-- Session B sees uncommitted changes from Session A
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT * FROM accounts;
```

## Concurrency Handling

To prevent multiple users from updating the same record simultaneously (race conditions), we use **Row Locking** with `FOR UPDATE`.

```sql
START TRANSACTION;
SELECT * FROM accounts WHERE acc_id = 1 FOR UPDATE;
-- This row is now locked until the transaction completes
UPDATE accounts SET balance = balance - 1000 WHERE acc_id = 1;
COMMIT;
```

## How to Run

1.  Open your MySQL client (e.g., MySQL Workbench or CLI).
2.  Execute the commands in `task13.sql` sequentially.
3.  The script will:
    - Create the `task13` database.
    - Create the `accounts` table.
    - Run various transaction scenarios for you to observe the results.

---

_Developed as part of SQL Training - Task 13_
