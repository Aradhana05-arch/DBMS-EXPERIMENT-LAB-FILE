CREATE TABLE BankAccount8 (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(50),
    balance DECIMAL(12,2)
) ENGINE=InnoDB;

INSERT INTO BankAccount8 VALUES
(101, 'Aarav Sharma', 50000),
(102, 'Nisha Verma', 35000),
(103, 'Rohan Singh', 60000),
(104, 'Meera Gupta', 45000),
(105, 'Kunal Mehta', 40000);

SELECT * FROM BankAccount8;

START TRANSACTION;

UPDATE BankAccount8
SET balance = balance - 5000
WHERE account_id = 101;

UPDATE BankAccount8
SET balance = balance + 5000
WHERE account_id = 102;

COMMIT;

SELECT * FROM BankAccount8
WHERE account_id IN (101, 102);

START TRANSACTION;

UPDATE BankAccount8
SET balance = balance - 3000
WHERE account_id = 103;

UPDATE BankAccount8
SET balance = balance + 3000
WHERE account_id = 104;

ROLLBACK;

SELECT * FROM BankAccount8
WHERE account_id IN (103, 104);

START TRANSACTION;

UPDATE BankAccount8
SET balance = balance + 2000
WHERE account_id = 105;

SAVEPOINT sp1;

UPDATE BankAccount8
SET balance = balance - 1000
WHERE account_id = 102;

ROLLBACK TO SAVEPOINT sp1;

COMMIT;
SELECT * FROM BankAccount8
WHERE account_id IN (102, 105);

START TRANSACTION;

UPDATE BankAccount8
SET balance = balance - 2000
WHERE account_id = 101;

UPDATE BankAccount8
SET balance = balance + 2000
WHERE account_id = 999;

ROLLBACK;

SELECT *
FROM BankAccount8
WHERE account_id = 101;

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT @@transaction_isolation;

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT @@transaction_isolation;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SELECT @@transaction_isolation;

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SELECT @@transaction_isolation;

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

START TRANSACTION;

UPDATE BankAccount8
SET balance = balance + 5000
WHERE account_id = 101;

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT *
FROM BankAccount8
WHERE account_id = 101;
ROLLBACK;
SELECT *
FROM BankAccount8
WHERE account_id = 101;

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT balance
FROM BankAccount8
WHERE account_id = 102;

UPDATE BankAccount8
SET balance = balance + 2000
WHERE account_id = 102;

COMMIT;

SELECT balance
FROM BankAccount8
WHERE account_id = 102;

COMMIT;

SELECT
    account_id,
    account_holder,
    balance
FROM BankAccount8
ORDER BY account_id;