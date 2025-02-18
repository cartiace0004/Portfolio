-- Goal: Assess delivery accuracy
SELECT 
    ROUND(AVG(DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date)), 2) AS avg_delivery_deviation_days,
    MIN(DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date)) AS min_delivery_deviation_days,
    MAX(DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date)) AS max_delivery_deviation_days
FROM orders o
WHERE o.order_status = 'delivered';

-- at this point, we encountered unrealistic values such as minimum delivery 
-- deviation is -147 days early and maximum delivery deviation days
-- is 188 days late:
SELECT 
    order_id, 
    customer_id,
    order_purchase_timestamp, 
    order_delivered_timestamp, 
    order_estimated_delivery_date, 
    DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date) AS delivery_deviation_days
FROM orders
WHERE order_status = 'delivered'
AND (DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date) <= -100 
     OR DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date) >= 100)
ORDER BY delivery_deviation_days ASC; -- Shows earliest to latest deviations

-- we have extreme cases of delivery deviation which are unrealistic to real life point of view.
-- we filter these cases out with this query
-- first off we defined a reasonable timeframe for early and late deliveries by using 
-- standard deviation of delivery deviation days. this approach will
-- filter out extreme outliers beyond 3 standard deviation.
-- these outliers are rare occurences only as there are only 31 cases
-- out of thousands.

SELECT 
    YEAR(order_purchase_timestamp) AS order_year,
    COUNT(*) AS count_of_valid_cases
FROM orders
WHERE order_status = 'delivered'
AND DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date) BETWEEN -42 AND 18
GROUP BY order_year
ORDER BY order_year;

-- the query we used to apply the standard deviation of 3 in order to filter
-- the outliers out:

WITH delivery_stats AS (
    SELECT 
        ROUND(AVG(DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date)), 2) AS avg_deviation,
        ROUND(STDDEV(DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date)), 2) AS std_deviation
    FROM orders
    WHERE order_status = 'delivered'
)

SELECT 
    ROUND(AVG(DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date)), 2) AS avg_delivery_deviation_days,
    MIN(DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date)) AS min_delivery_deviation_days,
    MAX(DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date)) AS max_delivery_deviation_days
FROM orders o
CROSS JOIN delivery_stats ds
WHERE o.order_status = 'delivered'
AND DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date) BETWEEN 
    (ds.avg_deviation - 3 * ds.std_deviation) 
    AND 
    (ds.avg_deviation + 3 * ds.std_deviation);
