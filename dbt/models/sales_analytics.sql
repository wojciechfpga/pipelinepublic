{{ config(materialized='table') }}

WITH raw_sales AS (
    SELECT * FROM {{ source('clickhouse', 'raw_sales') }}
),
dim_products AS (
    SELECT DISTINCT product AS product_name
    FROM raw_sales
),
fact_sales AS (
    SELECT
        sale_id,
        product,
        quantity,
        sale_date,
        customer_id
    FROM raw_sales
)
SELECT
    f.sale_id,
    f.quantity,
    f.sale_date,
    f.customer_id,
    p.product_name
FROM fact_sales f
JOIN dim_products p ON f.product = p.product_name