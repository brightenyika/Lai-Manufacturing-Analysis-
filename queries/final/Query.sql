# Final Queries

   D. QUALITY ANALYSIS
   
/*F1. Count passed quality metrics*/  
SELECT COUNT(*)
FROM operations_data
WHERE quality_metrics = 'Passed';


/*F2. Count failed quality metrics*/
SELECT COUNT(*)
FROM operations_data
WHERE quality_metrics = 'Failed';


/*F3. Count in-between quality metrics*/
SELECT COUNT(*)
FROM operations_data
WHERE quality_metrics = 'In-between';


/*F4. Which products have the highest number of failed quality metrics?*/

SELECT
    product_name,
    COUNT(*) AS total_metrics
FROM operations_data
WHERE quality_metrics = 'Failed'
GROUP BY product_name
ORDER BY total_metrics DESC;


/*F5. How does quality differ across production shifts?*/
SELECT
    shift_information,
    COUNT(*) AS total_quality_metrics,
    SUM(
        CASE
            WHEN quality_metrics = 'Passed' THEN 1
            ELSE 0
        END
    ) AS passed_metrics,
    SUM(
        CASE
            WHEN quality_metrics = 'Failed' THEN 1
            ELSE 0
        END
    ) AS failed_metrics,
    ROUND(
        SUM(
            CASE WHEN quality_metrics = 'Passed' THEN 1 ELSE 0 END
        ) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS pass_rate,
    ROUND(
        SUM(
            CASE WHEN quality_metrics = 'Failed' THEN 1 ELSE 0 END
        ) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS failure_rate
FROM operations_data
GROUP BY shift_information
ORDER BY shift_information DESC;


/*F5. Which downtime reasons are associated with failed quality metrics?*/
SELECT
    downtime_reason,
    quality_metrics,
    COUNT(*) AS total_failed_metrics
FROM operations_data
WHERE quality_metrics = 'Failed'
GROUP BY
    downtime_reason,
    quality_metrics;


   D. EMPLOYEE ANALYSIS

/*F6. Which employees handle the highest total production volume?*/
SELECT
    employee_id,
    employee_name,
    SUM(production_quantity) AS total_production,
    COUNT(DISTINCT operations_id) AS total_operations
FROM operations_data
GROUP BY
    employee_id,
    employee_name
ORDER BY total_production DESC
LIMIT 5;


/*F7. Which employees have above-average ratings?*/
SELECT
    employee_id,
    employee_name,
    ROUND(AVG(employee_rating), 2) AS avg_rating
FROM operations_data
GROUP BY
    employee_id,
    employee_name
HAVING AVG(employee_rating) > (
    SELECT AVG(employee_rating)
    FROM operations_data
)
ORDER BY avg_rating DESC;


/*F8 Which employees combine above-average production with above-average ratings?*/
WITH employee_metrics AS (
    SELECT
        employee_id,
        employee_name,
        ROUND(AVG(production_quantity), 2)
            AS total_avg_production,
        ROUND(AVG(employee_rating), 2)
            AS total_avg_rating
    FROM operations_data
    GROUP BY
        employee_id,
        employee_name
)
SELECT
    employee_id,
    employee_name,
    total_avg_production,
    total_avg_rating
FROM employee_metrics
WHERE total_avg_production > (
    SELECT AVG(production_quantity)
    FROM operations_data
)
AND total_avg_rating > (
    SELECT AVG(employee_rating)
    FROM operations_data
)
ORDER BY total_avg_rating DESC;


/*F9 Which employees have the highest average production efficiency?*/
SELECT
    employee_id,
    employee_name,
    SUM(production_quantity) AS total_production,
    SUM(production_time) AS total_production_time,
    ROUND(
        SUM(production_quantity) /
        NULLIF(SUM(production_time), 0)::numeric,
        2
    ) AS product_per_time_unit
FROM operations_data
GROUP BY
    employee_id,
    employee_name
ORDER BY product_per_time_unit DESC;


/*F10 Which shifts have the highest average employee ratings?*/
SELECT
    shift_information,
    ROUND(AVG(employee_rating), 2) AS avg_rating,
    COUNT(DISTINCT employee_id) AS employees,
    SUM(production_quantity) AS total_production
FROM operations_data
GROUP BY shift_information
ORDER BY avg_rating DESC;


  --E. DOWNTIME AND MAINTENANCE ANALYSIS

/*F10 Which downtime reasons contribute the most to total downtime?*/ 
SELECT
    downtime_reason,
    SUM(downtime_duration) AS total_downtime,
    COUNT(*) AS operation_records,
    ROUND(AVG(downtime_duration), 2) AS avg_downtime
FROM operations_data
WHERE downtime_reason IS NOT NULL
GROUP BY downtime_reason
ORDER BY total_downtime DESC;


/*Which products experience above-average downtime per operation?*/
SELECT
    product_id,
    product_name,
    downtime_reason,
    ROUND(AVG(downtime_duration), 2) AS avg_downtime,
    SUM(downtime_duration) AS total_downtime,
    COUNT(*) AS total_operation_records
FROM operations_data
GROUP BY
    product_id,
    product_name,
    downtime_reason
HAVING SUM(downtime_duration) > (
    SELECT AVG(downtime_duration)
    FROM operations_data
)
ORDER BY product_name, total_downtime;


/*F11. Which maintenance types have the highest average downtime?*/
SELECT
    maintenance_type,
    ROUND(AVG(downtime_duration), 2) AS avg_downtime,
    SUM(downtime_duration) AS total_downtime
FROM operations_data
GROUP BY maintenance_type
HAVING SUM(downtime_duration) > (
    SELECT AVG(downtime_duration)
    FROM operations_data
)
ORDER BY avg_downtime DESC;


/*F12. Which products have the highest number of downtime events?*/
SELECT
    product_id,
    product_name,
    SUM(downtime_events) AS total_downtime_events,
    SUM(downtime_duration) AS total_downtime,
    ROUND(AVG(downtime_duration), 2) AS avg_downtime
FROM operations_data
GROUP BY
    product_id,
    product_name
ORDER BY total_downtime_events DESC;


/*F13. Which shifts experience the most downtime?*/
SELECT
    shift_information,
    SUM(downtime_duration) AS total_downtime,
    ROUND(AVG(downtime_duration), 2) AS avg_downtime,
    SUM(downtime_events) AS total_downtime_events,
    SUM(production_quantity) AS total_production
FROM operations_data
GROUP BY shift_information
ORDER BY total_downtime DESC;


/*F14. What percentage of total downtime is attributable to each downtime reason?*/
WITH downtime_metric AS (
    SELECT
        downtime_reason,
        SUM(downtime_duration) AS total_downtime
    FROM operations_data
    GROUP BY downtime_reason
)

SELECT
    downtime_reason,
    total_downtime,
    ROUND(
        total_downtime * 100.0 /
        NULLIF(SUM(total_downtime) OVER (), 0),
        2
    ) AS downtime_percentage
FROM downtime_metric
ORDER BY downtime_percentage DESC;
