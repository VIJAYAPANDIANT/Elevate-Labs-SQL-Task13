--Create Sample Banking Table
CREATE DATABASE task13;
USE task13;

CREATE TABLE accounts (
    acc_id INT PRIMARY KEY,
    name VARCHAR(50),
    balance DECIMAL(10,2)
);

INSERT INTO accounts VALUES
(1, 'Alice', 10000),
(2, 'Bob', 5000);

--Basic Transaction Example (Money Transfer)
--Goal: Transfer ₹2000 from Alice → Bob
START TRANSACTION;

UPDATE accounts
SET balance = balance - 2000
WHERE acc_id = 1;

UPDATE accounts
SET balance = balance + 2000
WHERE acc_id = 2;

COMMIT;


Check result:

SELECT * FROM accounts;

--Simulate Failure + ROLLBACK
--Suppose system crashes before second update
START TRANSACTION;

UPDATE accounts
SET balance = balance - 3000
WHERE acc_id = 1;

-- simulate error (wrong account id)
UPDATE accounts
SET balance = balance + 3000
WHERE acc_id = 99;

ROLLBACK;


Now verify:

SELECT * FROM accounts;


--Alice balance will return to original → Atomicity proven

--ACID Properties Demonstration
-- A — Atomicity

All operations succeed OR none.

Example → money transfer uses rollback if one fails.

-- C — Consistency

Database rules always valid.

Example:

ALTER TABLE accounts ADD CONSTRAINT chk_balance CHECK (balance >= 0);


--Prevents negative balances.

-- I — Isolation

Transactions do not interfere with each other.

Handled using isolation levels (shown below).

--D — Durability

After COMMIT → changes are permanent even after crash.

--Isolation Levels
SELECT @@transaction_isolation;


Set level:

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

--Types:
Level	Prevents
READ UNCOMMITTED	Nothing
READ COMMITTED	Dirty reads
REPEATABLE READ	Non-repeatable reads
SERIALIZABLE	Phantom reads

--MySQL default → REPEATABLE READ

--PART 6 — Dirty Read Demo (2 Sessions)
--Session A
START TRANSACTION;
UPDATE accounts SET balance = 20000 WHERE acc_id = 1;
-- do not commit

--Session B
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT * FROM accounts;


--Sees uncommitted value → dirty read

Prevent by:

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--Concurrent Update Handling

Use row locking:

START TRANSACTION;

SELECT * FROM accounts
WHERE acc_id = 1
FOR UPDATE;

UPDATE accounts
SET balance = balance - 1000
WHERE acc_id = 1;

COMMIT;


--Prevents two users updating same row simultaneously.

--PART 8 — Banking System Mapping

Transaction = ATM transfer:

--Deduct from sender
--Add to receiver
--If network fails → rollback
--Prevents partial transfer
--Ensures money not lost