--------------------------------------------------------------------------------
-- Business Analysis - Sellers & Logistics
--------------------------------------------------------------------------------

-- 1. Who are the top sellers by revenue?

SELECT
    oi.["seller_id"],
    SUM(TRY_CAST(oi.["price"] AS FLOAT)) AS total_revenue
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.["order_id"] = oi.["order_id"]
WHERE o.["order_id"] = 'delivered'
GROUP BY oi.["seller_id"]
ORDER BY total_revenue DESC;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- 2. Delivery Performance: On-time vs Late Deliveries
-- delivering orders on time, or are delays a problem

SELECT
    CASE 
        WHEN TRY_CAST(o.["order_delivered_customer_date"] AS DATETIME)
             <= TRY_CAST(o.["order_estimated_delivery_date"] AS DATETIME)
        THEN 'On-time Delivery'
        ELSE 'Late Delivery'
    END AS delivery_status,
    COUNT(*) AS total_orders
FROM olist_orders_dataset o
WHERE o.["order_status"] = 'delivered'
  AND o.["order_delivered_customer_date"] IS NOT NULL
  AND o.["order_estimated_delivery_date"] IS NOT NULL
GROUP BY 
    CASE 
        WHEN TRY_CAST(o.["order_delivered_customer_date"] AS DATETIME)
             <= TRY_CAST(o.["order_estimated_delivery_date"] AS DATETIME)
        THEN 'On-time Delivery'
        ELSE 'Late Delivery'
    END;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- 3. Do late deliveries receive worse reviews?

SELECT
    delivery_status,
    AVG(CAST(r.review_score AS FLOAT)) AS avg_review_score,
    COUNT(*) AS total_reviews
FROM (
    SELECT
        o.["order_id"],
        CASE 
            WHEN TRY_CAST(o.["order_delivered_customer_date"] AS DATETIME)
                 <= TRY_CAST(o.["order_estimated_delivery_date"] AS DATETIME)
            THEN 'On-time'
            ELSE 'Late'
        END AS delivery_status
    FROM olist_orders_dataset o
    WHERE o.["order_status"] = 'delivered'
      AND o.["order_delivered_customer_date"] IS NOT NULL
      AND o.["order_estimated_delivery_date"] IS NOT NULL
) d
JOIN olist_order_reviews_dataset r
    ON d.["order_id"] = r.order_id
GROUP BY delivery_status;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------