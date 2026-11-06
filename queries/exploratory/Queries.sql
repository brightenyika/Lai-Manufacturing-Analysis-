# Exploratory Queries

   ##--A. PRODUCTION ANALYSIS--
   
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


--B. Inventory and Sales Analysis--
/*E7. Which products have the highest sales volume, and what percentage of their production has been sold?*/

