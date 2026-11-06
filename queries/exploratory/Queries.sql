# Exploratory Queries

   A. PRODUCTION ANALYSIS
   
/*E1. Which product categories generate the highest total production volume?*/
   
SELECT
    product_category,
    SUM(production_quantity) AS total_production
FROM operations_data
GROUP BY product_category
ORDER BY total_production DESC;  


/*E2. Which products have the highest production volumes, and what percentage of total production do they represent?*/

SELECT
    product_id,
    product_name,
    SUM(production_quantity) AS total_production,
    ROUND(
        SUM(production_quantity) * 100.0 /
        SUM(SUM(production_quantity)) OVER (), 2
    ) AS production_percentage
FROM operations_data
GROUP BY
    product_id,
    product_name
ORDER BY total_production DESC;


/*E3. Which shifts have the highest production output?*/

SELECT
    shift_information,
    SUM(production_quantity) AS total_production,
    ROUND(AVG(production_quantity), 2)
        AS avg_production_per_operation
FROM operations_data
GROUP BY shift_information
ORDER BY total_production DESC;


/* E4. Which products have production efficiency below the overall average?*/

WITH product_efficiency AS (
    SELECT
        product_name,
        SUM(production_quantity) AS total_production,
        SUM(production_time) AS total_production_time,
        CAST(
            SUM(production_quantity) /
            NULLIF(SUM(production_time), 0)
            AS numeric(10,2)
        ) AS efficiency
    FROM operations_data
    GROUP BY product_name
)
SELECT
    product_name,
    total_production,
    total_production_time,
    efficiency
FROM product_efficiency
WHERE efficiency < (
    SELECT AVG(efficiency)
    FROM product_efficiency
)
ORDER BY efficiency;


/*E5. Which product categories have the highest average production quantity?*/

SELECT
    product_category,
    ROUND(AVG(production_quantity), 2)
        AS avg_production_quantity,
    SUM(production_quantity) AS total_production
FROM operations_data
GROUP BY product_category
ORDER BY avg_production_quantity DESC;


/*E6. Which products have production volumes above the overall average?*/

SELECT
    product_id,
    product_name,
    SUM(production_quantity) AS total_production,
    ROUND(AVG(production_quantity), 2) AS avg_production
FROM operations_data
GROUP BY
    product_id,
    product_name
HAVING SUM(production_quantity) > (
    SELECT AVG(production_volume)
    FROM (
        SELECT
            SUM(production_quantity) AS production_volume
        FROM operations_data
        GROUP BY product_id
    ) AS product_summary
)
ORDER BY avg_production DESC;


   B. PRODUCTION ANALYSIS

/*E7. Which products have the highest sales volume, and what percentage of their production has been sold?*/

SELECT
    product_name,
    SUM(production_quantity) AS total_produced,
    SUM(quantity_sold) AS total_sold,
    ROUND(
        100.0 * SUM(quantity_sold) /
        NULLIF(SUM(production_quantity), 0),
        2
    ) AS percentage_sold
FROM operations_data
GROUP BY product_name;


/*E8. Which products may be at risk of stockouts?*/

SELECT
    product_name,
    SUM(quantity_sold) AS total_sold,
    SUM(quantity_in_stock) AS total_stock,
    CASE
        WHEN SUM(quantity_in_stock) <
             SUM(quantity_sold) * 0.25
            THEN 'High Stock Risk'
        WHEN SUM(quantity_in_stock) <
             SUM(quantity_sold) * 0.50
            THEN 'Medium Stock Out'
        ELSE 'Low Stock Out'
    END AS stock_tier
FROM operations_data
GROUP BY product_name
ORDER BY total_stock;

/*E9. Which products have high production but relatively low sales?*/

WITH product_performance AS (
    SELECT
        product_name,
        SUM(production_quantity) AS total_production,
        SUM(quantity_sold) AS total_sold,
        SUM(quantity_sold) * 100.0 /
            NULLIF(SUM(production_quantity), 0) AS sales_rate
    FROM operations_data
    GROUP BY product_name
)
SELECT
    product_name,
    total_production,
    total_sold,
    ROUND(sales_rate, 2) AS sales_rate
FROM product_performance
WHERE total_production > (
    SELECT AVG(total_production)
    FROM product_performance
)
AND sales_rate < (
    SELECT AVG(sales_rate)
    FROM product_performance
)
ORDER BY sales_rate;


/*E10. Which products have high production but a low sales rate?*/ 

SELECT
    product_id,
    product_name,
    SUM(production_quantity) AS total_production,
    SUM(quantity_sold) AS total_sold,
    ROUND(
        SUM(quantity_sold) * 100.0 /
        NULLIF(SUM(production_quantity), 0),
        2
    ) AS sales_rate
FROM operations_data
GROUP BY
    product_id,
    product_name
HAVING SUM(production_quantity) > 0
   AND SUM(quantity_sold) * 100.0 /
       NULLIF(SUM(production_quantity), 0) < 50
ORDER BY sales_rate DESC;


 C. SUPPLIER ANALYSIS

/*E11. Which suppliers have the longest average lead times?*/
    
SELECT
    supplier_name,
    CAST(AVG(lead_time) AS numeric(10,2)) AS avg_lead_time,
    COUNT(DISTINCT product_id) AS products_supplied
FROM operations_data
GROUP BY supplier_name
ORDER BY avg_lead_time DESC;


/*E12. Which suppliers have above-average lead times?*/

SELECT
    supplier_id,
    supplier_name,
    ROUND(AVG(lead_time)::numeric, 2) AS avg_lead_time,
    COUNT(DISTINCT product_id) AS total_supply
FROM operations_data
GROUP BY
    supplier_id,
    supplier_name
HAVING AVG(lead_time) > (
    SELECT AVG(lead_time)
    FROM operations_data
)
ORDER BY avg_lead_time DESC;


/*E13. Which suppliers have the longest average lead time for each product category?*/

SELECT
    supplier_id,
    supplier_name,
    COUNT(DISTINCT product_id) AS total_product,
    product_category,
    ROUND(AVG(lead_time)::numeric, 2) AS avg_lead_time
FROM operations_data
GROUP BY
    supplier_id,
    supplier_name,
    product_category
ORDER BY
    product_category,
    avg_lead_time DESC;


/*E14. Which suppliers have both long lead times and high production volumes?*/

WITH supplier_metrics AS (
    SELECT
        supplier_id,
        supplier_name,
        AVG(lead_time) AS avg_lead_time,
        SUM(production_quantity) AS total_production
    FROM operations_data
    GROUP BY
        supplier_id,
        supplier_name
)
SELECT
    supplier_id,
    supplier_name,
    ROUND(avg_lead_time::numeric, 2) AS avg_lead_time,
    total_production
FROM supplier_metrics
WHERE avg_lead_time > (
    SELECT AVG(lead_time)
    FROM operations_data
)
AND total_production > (
    SELECT AVG(total_production)
    FROM (
        SELECT SUM(production_quantity) AS total_production
        FROM operations_data
        GROUP BY supplier_id
    ) AS supplier_summary
)
ORDER BY avg_lead_time DESC;
