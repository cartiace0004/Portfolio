-- measure early vs late deliveries:
WITH delivery_stats AS (
    SELECT 
        ROUND(AVG(DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date)), 2) AS avg_deviation,
        ROUND(STDDEV(DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date)), 2) AS std_deviation
    FROM orders
    WHERE order_status = 'delivered'
),
filtered_orders AS (
    SELECT 
        order_id,
        DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date) AS delivery_deviation
    FROM orders o
    CROSS JOIN delivery_stats ds
    WHERE o.order_status = 'delivered'
    AND DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date) BETWEEN 
        (ds.avg_deviation - 3 * ds.std_deviation) 
        AND 
        (ds.avg_deviation + 3 * ds.std_deviation)
)

SELECT 
    SUM(CASE WHEN delivery_deviation < 0 THEN 1 ELSE 0 END) AS early_deliveries,
    SUM(CASE WHEN delivery_deviation = 0 THEN 1 ELSE 0 END) AS on_time_deliveries,
    SUM(CASE WHEN delivery_deviation > 0 THEN 1 ELSE 0 END) AS late_deliveries,
    ROUND(100 * SUM(CASE WHEN delivery_deviation < 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS early_percentage,
    ROUND(100 * SUM(CASE WHEN delivery_deviation = 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS on_time_percentage,
    ROUND(100 * SUM(CASE WHEN delivery_deviation > 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS late_percentage
FROM filtered_orders;
