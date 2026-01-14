
-- =========================================
-- DATA QUALITY CHECKS FOR OLIST E-COMMERCE
-- =========================================

-- 1. Orders
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ["order_id"]) AS unique_order_ids,
    COUNT(*) - COUNT(["order_id"]) AS missing_order_id,
    COUNT(*) - COUNT(["customer_id"]) AS missing_customer_id
FROM olist_orders_dataset;

-- 2. Order Items
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ["order_item_id"]) AS unique_order_item_ids,
    COUNT(*) - COUNT(["order_id"]) AS missing_order_id,
    COUNT(*) - COUNT(["product_id"]) AS missing_product_id,
    COUNT(*) - COUNT(["seller_id"]) AS missing_seller_id,
    SUM(
        CASE 
            WHEN TRY_CAST(["price"] AS FLOAT) <= 0 THEN 1 
            ELSE 0 
        END
    ) AS invalid_price_or_id
FROM olist_order_items_dataset;

-- 3. Customers
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ["customer_id"]) AS unique_customer_ids,
    COUNT(*) - COUNT(["customer_unique_id"]) AS missing_unique_id
FROM olist_customers_dataset;

-- 4. Products
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ["product_id"]) AS unique_product_ids,
    COUNT(*) - COUNT(["product_category_name"]) AS missing_category
FROM olist_products_dataset;

-- 5. Sellers
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ["seller_id"]) AS unique_seller_ids
FROM olist_sellers_dataset;

-- 6. Payments
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ["order_id"]) AS unique_payment_ids,
    COUNT(*) - COUNT(["order_id"]) AS missing_order_id,
    SUM(
        CASE 
            WHEN TRY_CAST(["payment_value"] AS FLOAT) <= 0 THEN 1 
            ELSE 0 
        END
    ) AS invalid_payment_values
FROM olist_order_payments_dataset;

-- 7. Reviews
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT review_id) AS unique_review_ids,
    COUNT(*) - COUNT(order_id) AS missing_order_id,
    SUM(
        CASE 
            WHEN TRY_CAST(review_score AS FLOAT) <= 0 THEN 1 
            ELSE 0 
        END
    ) AS invalid_scores
FROM olist_order_reviews_dataset;