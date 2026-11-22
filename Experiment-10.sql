CREATE TABLE SalesPerf10 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    region VARCHAR(30),
    order_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    status VARCHAR(20)
) ENGINE=InnoDB;

INSERT INTO SalesPerf10
(
    order_id,
    customer_id,
    product_id,
    region,
    order_date,
    quantity,
    unit_price,
    status
)
SELECT
    n,
    1000 + MOD(n, 500),
    200 + MOD(n, 50),

    CASE MOD(n, 4)
        WHEN 0 THEN 'North'
        WHEN 1 THEN 'South'
        WHEN 2 THEN 'East'
        ELSE 'West'
    END,

    DATE_ADD('2025-01-01', INTERVAL MOD(n, 730) DAY),

    1 + MOD(n, 10),

    500 + MOD(n, 10000),

    CASE MOD(n, 3)
        WHEN 0 THEN 'Confirmed'
        WHEN 1 THEN 'Pending'
        ELSE 'Cancelled'
    END

FROM
(
    SELECT
        a.d * 1000 + b.d * 100 + c.d * 10 + d.d + 1 AS n
    FROM
        (SELECT 0 d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a

    CROSS JOIN
        (SELECT 0 d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b

    CROSS JOIN
        (SELECT 0 d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c

    CROSS JOIN
        (SELECT 0 d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d
) AS numbers;


SELECT COUNT(*) AS Total_Records
FROM SalesPerf10;

SELECT *
FROM SalesPerf10
LIMIT 10;

SELECT *
FROM SalesPerf10
WHERE YEAR(order_date) = 2025;

EXPLAIN
SELECT *
FROM SalesPerf10
WHERE YEAR(order_date) = 2025;

SELECT *
FROM SalesPerf10
WHERE UPPER(status) = 'CONFIRMED';

EXPLAIN
SELECT *
FROM SalesPerf10
WHERE UPPER(status) = 'CONFIRMED';

SELECT *
FROM SalesPerf10
WHERE region = 'North'
OR region = 'South';

EXPLAIN
SELECT *
FROM SalesPerf10
WHERE region = 'North'
OR region = 'South';

SELECT
    order_id,
    customer_id,
    quantity * unit_price AS order_value
FROM SalesPerf10
WHERE quantity * unit_price > (
    SELECT AVG(quantity * unit_price)
    FROM SalesPerf10
);

EXPLAIN
SELECT
    order_id,
    customer_id,
    quantity * unit_price AS order_value
FROM SalesPerf10
WHERE quantity * unit_price > (
    SELECT AVG(quantity * unit_price)
    FROM SalesPerf10
);

SELECT
    region,
    COUNT(*) AS total_orders,
    SUM(quantity * unit_price) AS total_sales
FROM SalesPerf10
GROUP BY region;

EXPLAIN
SELECT
    region,
    COUNT(*) AS total_orders,
    SUM(quantity * unit_price) AS total_sales
FROM SalesPerf10
GROUP BY region;

CREATE INDEX idx_order_date10
ON SalesPerf10(order_date);

CREATE INDEX idx_status10
ON SalesPerf10(status);

CREATE INDEX idx_region10
ON SalesPerf10(region);

CREATE INDEX idx_region_date10
ON SalesPerf10(region, order_date);

CREATE INDEX idx_customer10
ON SalesPerf10(customer_id);

SHOW INDEX FROM SalesPerf10;

SELECT *
FROM SalesPerf10
WHERE order_date >= '2025-01-01'
AND order_date < '2026-01-01';

EXPLAIN
SELECT *
FROM SalesPerf10
WHERE order_date >= '2025-01-01'
AND order_date < '2026-01-01';

SELECT *
FROM SalesPerf10
WHERE status = 'Confirmed';

EXPLAIN
SELECT *
FROM SalesPerf10
WHERE status = 'Confirmed';

SELECT *
FROM SalesPerf10
WHERE region IN ('North', 'South');

EXPLAIN
SELECT *
FROM SalesPerf10
WHERE region IN ('North', 'South');

SELECT
    s.order_id,
    s.customer_id,
    s.quantity * s.unit_price AS order_value
FROM SalesPerf10 s
CROSS JOIN (
    SELECT AVG(quantity * unit_price) AS avg_value
    FROM SalesPerf10
) a
WHERE s.quantity * s.unit_price > a.avg_value;

EXPLAIN
SELECT
    s.order_id,
    s.customer_id,
    s.quantity * s.unit_price AS order_value
FROM SalesPerf10 s
CROSS JOIN (
    SELECT AVG(quantity * unit_price) AS avg_value
    FROM SalesPerf10
) a
WHERE s.quantity * s.unit_price > a.avg_value;


SELECT
    region,
    COUNT(*) AS total_orders,
    SUM(quantity * unit_price) AS total_sales
FROM SalesPerf10
GROUP BY region
ORDER BY region;

EXPLAIN
SELECT
    region,
    COUNT(*) AS total_orders,
    SUM(quantity * unit_price) AS total_sales
FROM SalesPerf10
GROUP BY region
ORDER BY region;

SHOW INDEX FROM SalesPerf10;

