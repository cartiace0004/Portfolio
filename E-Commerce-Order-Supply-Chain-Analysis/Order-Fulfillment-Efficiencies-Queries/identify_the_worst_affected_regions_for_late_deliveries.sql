-- identify the worst-affected regions for late deliveries:
WITH delivery_stats AS (
    SELECT 
        ROUND(AVG(DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date)), 2) AS avg_deviation,
        ROUND(STDDEV(DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date)), 2) AS std_deviation
    FROM orders
    WHERE order_status = 'delivered'
),
filtered_orders AS (
    SELECT 
        o.order_id,
        o.customer_id,
        DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date) AS delivery_deviation
    FROM orders o
    CROSS JOIN delivery_stats ds
    WHERE o.order_status = 'delivered'
    AND DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date) BETWEEN 
        (ds.avg_deviation - 3 * ds.std_deviation) 
        AND 
        (ds.avg_deviation + 3 * ds.std_deviation)
),
late_analysis AS (
    SELECT 
        fo.order_id,
        c.customer_state,
        CASE 
            WHEN fo.delivery_deviation > 0 THEN 1 
            ELSE 0 
        END AS is_late
    FROM filtered_orders fo
    JOIN customers c 
        ON fo.customer_id = c.customer_id
)
SELECT 
    la.customer_state,
    COUNT(*) AS total_filtered_orders,
    SUM(la.is_late) AS total_late_orders,
    ROUND((SUM(la.is_late) / COUNT(*)) * 100, 2 ) AS late_percentage
FROM late_analysis la
GROUP BY la.customer_state
ORDER BY late_percentage DESC
LIMIT 10;
