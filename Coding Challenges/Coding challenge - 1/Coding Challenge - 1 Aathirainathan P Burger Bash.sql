create database burger_bash;
use burger_bash;

CREATE TABLE burger_names(
   burger_id   INTEGER  NOT NULL PRIMARY KEY 
  ,burger_name VARCHAR(10) NOT NULL
);

INSERT INTO burger_names(burger_id,burger_name) VALUES (1,'Meatlovers');
INSERT INTO burger_names(burger_id,burger_name) VALUES (2,'Vegetarian');   

CREATE TABLE runner_orders(
   order_id     INTEGER  NOT NULL PRIMARY KEY 
  ,runner_id    INTEGER  NOT NULL
  ,pickup_time  timestamp
  ,distance     VARCHAR(7)
  ,duration     VARCHAR(10)
  ,cancellation VARCHAR(23)
);

ALTER TABLE runner_orders
DROP COLUMN pickup_time;

ALTER TABLE runner_orders
ADD pickup_time DATETIME;

ALTER TABLE runner_orders
ALTER COLUMN distance VARCHAR(10);

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES (1, 1, '2021-01-01 18:15:34', '20km', '32 minutes', NULL);

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES (2, 1, '2021-01-01 19:10:54', '20km', '27 minutes', NULL);

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES (3, 1, '2021-01-03 00:12:37', '13.4km', '20 mins', NULL);

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES (4, 2, '2021-01-04 13:53:03', '23.4', '40', NULL);

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES (5, 3, '2021-01-08 21:10:57', '10', '15', NULL);

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES (6, 3, NULL, NULL, NULL, 'Restaurant Cancellation');

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES (7, 2, '2021-01-08 21:30:45', '25km', '25mins', NULL);

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES (8, 2, '2021-01-10 00:15:02', '23.4 km', '15 minute', NULL);

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES (9, 2, NULL, NULL, NULL, 'Customer Cancellation');

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES (10, 1, '2021-01-11 18:50:20', '10km', '10minutes', NULL);
      

CREATE TABLE burger_runner(
   runner_id   INTEGER  NOT NULL PRIMARY KEY 
  ,registration_date date NOT NULL
);

INSERT INTO burger_runner VALUES (1,'2021-01-01');
INSERT INTO burger_runner VALUES (2,'2021-01-03');
INSERT INTO burger_runner VALUES (3,'2021-01-08');
INSERT INTO burger_runner VALUES (4,'2021-01-15');   


CREATE TABLE customer_orders(
   order_id    INTEGER  NOT NULL 
  ,customer_id INTEGER  NOT NULL
  ,burger_id    INTEGER  NOT NULL
  ,exclusions  VARCHAR(4)
  ,extras      VARCHAR(4)
  ,order_time  datetime NOT NULL
);
INSERT INTO customer_orders VALUES (1,101,1,NULL,NULL,'2021-01-01 18:05:02');
INSERT INTO customer_orders VALUES (2,101,1,NULL,NULL,'2021-01-01 19:00:52');
INSERT INTO customer_orders VALUES (3,102,1,NULL,NULL,'2021-01-02 23:51:23');
INSERT INTO customer_orders VALUES (3,102,2,NULL,NULL,'2021-01-02 23:51:23');
INSERT INTO customer_orders VALUES (4,103,1,'4',NULL,'2021-01-04 13:23:46');
INSERT INTO customer_orders VALUES (4,103,1,'4',NULL,'2021-01-04 13:23:46');
INSERT INTO customer_orders VALUES (4,103,2,'4',NULL,'2021-01-04 13:23:46');
INSERT INTO customer_orders VALUES (5,104,1,NULL,'1','2021-01-08 21:00:29');
INSERT INTO customer_orders VALUES (6,101,2,NULL,NULL,'2021-01-08 21:03:13');
INSERT INTO customer_orders VALUES (7,105,2,NULL,'1','2021-01-08 21:20:29');
INSERT INTO customer_orders VALUES (8,102,1,NULL,NULL,'2021-01-09 23:54:33');
INSERT INTO customer_orders VALUES (9,103,1,'4','1, 5','2021-01-10 11:22:59');
INSERT INTO customer_orders VALUES (10,104,1,NULL,NULL,'2021-01-11 18:34:49');
INSERT INTO customer_orders VALUES (10,104,1,'2, 6','1, 4','2021-01-11 18:34:49'); 

select * from burger_names;
select * from runner_orders;
select * from burger_runner;
select * from customer_orders;

--Joins
SELECT co.order_id, co.customer_id, bn.burger_name, br.runner_id
FROM customer_orders co
JOIN burger_names bn ON co.burger_id = bn.burger_id
JOIN runner_orders ro ON co.order_id = ro.order_id
JOIN burger_runner br ON ro.runner_id = br.runner_id;


SELECT co.customer_id, co.order_id,  ro.runner_id,co.order_time, ro.pickup_time
FROM customer_orders co
JOIN runner_orders ro ON co.order_id = ro.order_id
ORDER BY co.order_time;

--Sub Queries

SELECT DISTINCT customer_id
FROM customer_orders
WHERE customer_id IN (
    SELECT customer_id
    FROM customer_orders
    WHERE burger_id = 1
) AND customer_id IN (
    SELECT customer_id
    FROM customer_orders
    WHERE burger_id = 2
);

SELECT runner_id
FROM runner_orders
GROUP BY runner_id
HAVING COUNT(order_id) = (
    SELECT MAX(order_count)
    FROM (
        SELECT runner_id, COUNT(order_id) AS order_count
        FROM runner_orders
        GROUP BY runner_id
    ) AS runner_order_counts
);

--Subtotals

SELECT br.runner_id, COUNT(ro.order_id) AS total_orders
FROM runner_orders ro
JOIN burger_runner br ON ro.runner_id = br.runner_id
GROUP BY br.runner_id WITH ROLLUP
ORDER BY br.runner_id;

--Group by and Having

SELECT customer_id, COUNT(order_id) AS total_orders
FROM customer_orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

SELECT burger_id, COUNT(order_id) AS total_orders
FROM customer_orders
GROUP BY burger_id
HAVING COUNT(order_id) > 2;

