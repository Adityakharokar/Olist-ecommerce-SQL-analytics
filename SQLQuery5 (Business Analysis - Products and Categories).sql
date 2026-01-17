--------------------------------------------------------------------------------
-- Business Analysis - Products & Categories
--------------------------------------------------------------------------------

-- 1. Which product categories generate the highest revenue


SELECT
    p.["product_category_name"],
    SUM(TRY_CAST(oi.["price"] AS FLOAT)) AS total_revenue
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.["order_id"] = oi.["order_id"]
JOIN olist_products_dataset p
    ON oi.["product_id"] = p.["product_id"]
WHERE o.["order_status"] = 'delivered'
GROUP BY p.["product_category_name"]
ORDER BY total_revenue DESC;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- 2. Which categories have the highest order volume

SELECT
    p.["product_category_name"],
    COUNT(DISTINCT oi.["order_id"]) AS total_orders
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.["order_id"] = oi.["order_id"]
JOIN olist_products_dataset p
    ON oi.["product_id"] = p.["product_id"]
WHERE o.["order_status"] = 'delivered'
GROUP BY p.["product_category_name"]
ORDER BY total_orders DESC;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- 3. Low Volume but High Revenue Categories
-- Which categories don’t sell often, but make serious money per order?


SELECT
    p.["product_category_name"],
    COUNT(DISTINCT oi.["order_id"]) AS total_orders,
    SUM(TRY_CAST(oi.["price"] AS FLOAT)) AS total_revenue,
    SUM(TRY_CAST(oi.["price"] AS FLOAT)) 
        / COUNT(DISTINCT oi.["order_id"]) AS avg_revenue_per_order
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.["order_id"] = oi.["order_id"]
JOIN olist_products_dataset p
    ON oi.["product_id"] = p.["product_id"]
WHERE o.["order_status"] = 'delivered'
GROUP BY p.["product_category_name"]
HAVING COUNT(DISTINCT oi.["order_id"]) > 50   -- avoids noise
ORDER BY avg_revenue_per_order DESC;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------