--------------------------------------------------------------------------------------------
-- Business Anlysis - Customers (behavior)
--------------------------------------------------------------------------------------------

--1. Repeat vs One time customer

SELECT
	CASE
		WHEN order_count = 1 THEN 'One-time Customer'
		ELSE 'Repeat Customer'
	END AS customer_type,
	COUNT (*) AS Customer_count
FROM(
	SELECT
		c.["customer_unique_id"],
		COUNT(DISTINCT o.["order_id"]) AS order_count
		FROM olist_orders_dataset o
		JOIN olist_customers_dataset c
			ON o.["customer_id"] = c.["customer_id"]
		WHERE o.["order_status"] = 'delivered'
		GROUP BY c.["customer_unique_id"]
) t
GROUP BY
	CASE
		WHEN order_count = 1 THEN 'One-time Customer'
		ELSE 'Repeat Customer'
	END;
--------------------------------------------------------------------------------------------
-- From this analysis we concluded that we have 90,557 One time customers 
-- and 2801 repeat customers.
--------------------------------------------------------------------------------------------


-- 2. Customers by State (Geography Analysis)

SELECT 
	c.["customer_state"],
	COUNT(DISTINCT ["customer_unique_id"]) AS total_customers
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
	ON o.["customer_id"] = c.["customer_id"]
WHERE o.["order_status"] = 'delivered'
GROUP BY c.["customer_state"]
ORDER BY total_customers DESC;

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------


-- 3. Average Spend per Customer (CLV proxy)

WITH customer_spend AS (
    SELECT 
        c.["customer_unique_id"],
        SUM(TRY_CAST(oi.["price"] AS FLOAT)) AS total_spent
    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c
        ON o.["customer_id"] = c.["customer_id"]
    JOIN olist_order_items_dataset oi
        ON o.["order_id"] = oi.["order_id"]
    WHERE o.["order_status"] = 'delivered'
    GROUP BY c.["customer_unique_id"]
)
SELECT 
    AVG(total_spent) AS avg_spend_per_customer
FROM customer_spend;


--------------------------------------------------------------------------------------------
-- On average, a customer spends 
-- around 142 on the platform (based on delivered orders).
--------------------------------------------------------------------------------------------
