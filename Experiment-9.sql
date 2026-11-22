CREATE TABLE RailwayBooking9 (
    booking_id INT PRIMARY KEY,
    passenger_name VARCHAR(50),
    train_id INT,
    journey_date DATE,
    source_station VARCHAR(50),
    destination_station VARCHAR(50),
    seat_no VARCHAR(10),
    booking_status VARCHAR(20)
 ) ENGINE=InnoDB;


INSERT INTO RailwayBooking9
(
    booking_id,
    passenger_name,
    train_id,
    journey_date,
    source_station,
    destination_station,
    seat_no,
    booking_status
)
SELECT
    n,
    CONCAT('Passenger ', n),
    100 + MOD(n, 20),
    DATE_ADD('2026-01-01', INTERVAL MOD(n, 365) DAY),
    CASE MOD(n, 4)
        WHEN 0 THEN 'Delhi'
        WHEN 1 THEN 'Mumbai'
        WHEN 2 THEN 'Lucknow'
        ELSE 'Chandigarh'
    END,
    CASE MOD(n, 4)
        WHEN 0 THEN 'Jaipur'
        WHEN 1 THEN 'Pune'
        WHEN 2 THEN 'Kanpur'
        ELSE 'Amritsar'
    END,
    CONCAT('S', MOD(n, 100)),
    CASE MOD(n, 3)
        WHEN 0 THEN 'Confirmed'
        WHEN 1 THEN 'Waiting'
        ELSE 'Cancelled'
    END
FROM
(
    SELECT
        a.d * 1000 + b.d * 100 + c.d * 10 + d.d + 1 AS n
    FROM
        (SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) a
    CROSS JOIN
        (SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
    CROSS JOIN
        (SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c
    CROSS JOIN
        (SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d
) AS numbers;


SELECT COUNT(*) AS Total_Bookings
FROM RailwayBooking9;

SELECT *
FROM RailwayBooking9
LIMIT 10;


SELECT *
FROM RailwayBooking9
WHERE passenger_name = 'Passenger 2500';

EXPLAIN
SELECT *
FROM RailwayBooking9
WHERE passenger_name = 'Passenger 2500';

SELECT *
FROM RailwayBooking9
WHERE train_id = 105
AND journey_date BETWEEN '2026-01-01' AND '2026-06-30';

EXPLAIN
SELECT *
FROM RailwayBooking9
WHERE train_id = 105
AND journey_date BETWEEN '2026-01-01' AND '2026-06-30';

CREATE INDEX idx_passenger_name
ON RailwayBooking9(passenger_name);

SHOW INDEX FROM RailwayBooking9;

CREATE INDEX idx_train_journey
ON RailwayBooking9(train_id, journey_date);

SELECT *
FROM RailwayBooking9
WHERE passenger_name = 'Passenger 2500';

EXPLAIN
SELECT *
FROM RailwayBooking9
WHERE passenger_name = 'Passenger 2500';

SELECT *
FROM RailwayBooking9
WHERE train_id = 105
AND journey_date BETWEEN '2026-01-01' AND '2026-06-30';

EXPLAIN
SELECT *
FROM RailwayBooking9
WHERE train_id = 105
AND journey_date BETWEEN '2026-01-01' AND '2026-06-30';

SHOW INDEX FROM RailwayBooking9;

SELECT
    booking_id,
    passenger_name,
    train_id,
    journey_date,
    booking_status
FROM RailwayBooking9
ORDER BY booking_id
LIMIT 20;

