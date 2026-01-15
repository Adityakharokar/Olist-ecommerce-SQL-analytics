------------------------------------------
-- Business Analysis - Orders and Revenue
------------------------------------------


-- Total Revenue

SELECT 
	SUM(TRY_CAST(oi.["price"] AS FLOAT)) AS Total_revenue
from olist_orders_dataset o
join olist_order_items_dataset oi
	on o.["order_id"] = oi.["order_id"]
where o.["order_status"] = 'delivered';

---------------------------------------------------------------------------
-- The platform generated ~13.22M in revenue from 
-- successfully delivered orders, representing actual realized earnings.
---------------------------------------------------------------------------



-- Monthly Revenue

SELECT
	CONVERT(VARCHAR(7), TRY_CAST(o.["order_purchase_timestamp"] AS DATETIME), 120) AS year_month,
	SUM(TRY_CAST(oi.["price"] AS float)) AS monthly_revenue
FROM olist_orders_dataset o
join olist_order_items_dataset oi
	ON o.["order_id"] = oi.["order_id"]
WHERE o.["order_status"] = 'delivered'
GROUP BY CONVERT(VARCHAR(7), TRY_CAST(o.["order_purchase_timestamp"] AS DATETIME), 120)
ORDER BY year_month;

-- Top revenue month

SELECT TOP 1
	CONVERT(VARCHAR(7), TRY_CAST(o.["order_purchase_timestamp"] AS DATETIME), 120) AS year_month,
	SUM(TRY_CAST(oi.["price"] AS float)) AS monthly_revenue
FROM olist_orders_dataset o
join olist_order_items_dataset oi
	ON o.["order_id"] = oi.["order_id"]
WHERE o.["order_status"] = 'delivered'
GROUP BY CONVERT(VARCHAR(7), TRY_CAST(o.["order_purchase_timestamp"] AS DATETIME), 120)
ORDER BY monthly_revenue DESC;

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------


-- Average Order Value (AOV)

SELECT
	SUM(TRY_CAST(oi.["price"] AS float)) / COUNT(DISTINCT o.["order_id"]) AS Average_order_value
FROM olist_orders_dataset o
join olist_order_items_dataset oi
	ON o.["order_id"] = oi.["order_id"]
WHERE o.["order_status"] = 'delivered';

-------------------------------------------------------------------------------------------------
-- On Average "Each delivered order" generated "$137.041585750261"
-------------------------------------------------------------------------------------------------


-- Orders Over Time (Monthly Order Volume)

SELECT 
	CONVERT(varchar(7), TRY_CAST(o.["order_purchase_timestamp"] AS datetime),120) AS year_month,
	COUNT(DISTINCT o.["order_id"]) AS total_orders
FROM olist_orders_dataset o
WHERE o.["order_status"] = 'delivered'
GROUP BY CONVERT(varchar(7), TRY_CAST(o.["order_purchase_timestamp"] AS datetime),120)
ORDER BY year_month;

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------