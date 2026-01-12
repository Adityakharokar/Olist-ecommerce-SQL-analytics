# Olist-ecommerce-SQL-analytics
Real-world SQL analytics on the Brazilian Olist e-commerce dataset to derive business insights.

-- Problem Statement

Perform real-world SQL analytics on an e-commerce dataset to answer
business questions related to sales performance, customer behavior,
delivery efficiency, and customer reviews.

-- Dataset
- Source: Brazilian E-commerce Public Dataset by Olist
- Size: ~100,000 orders
- Description: Includes orders, customers, sellers, payments, deliveries,
  and reviews data.

-- Tools & Technologies
- SQL Server (SSMS)
- SQL

-- Approach
- Explored table schemas to understand data grain and relationships.
- Combined multiple tables using appropriate join strategies to avoid
  duplication and aggregation errors.
- Applied filtering, aggregations, CTEs, subqueries, and date-based logic
  to answer analytical and business-oriented questions.
- Addressed real-world data ingestion challenges where the
  `olist_order_reviews` table failed to import via SSMS Import Wizard due
  to UTF-8 encoding and truncation issues.
- Resolved the issue by loading data through a raw staging table using
  `NVARCHAR(MAX)` and `BULK INSERT`.

-- Results
- Successfully analyzed order lifecycle metrics including delivery delays,
  customer purchasing behavior, seller performance, and review trends.
- Ensured accurate insights by maintaining correct data grain and
  aggregation logic across joins.

-- Key Learnings
- Importance of understanding table grain before joining datasets.
- Handling real-world data ingestion and encoding issues in SQL Server.
- Writing clean, readable, and logically correct analytical SQL queries.
