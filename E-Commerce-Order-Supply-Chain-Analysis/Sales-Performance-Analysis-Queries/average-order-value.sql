--Goal: Average Order Value (AOV) Analysis
SELECT	DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') as month_year,
		COUNT(DISTINCT o.order_id) as total_orders,
        SUM(p.payment_value) as total_revenue,
        ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.order_id), 2) as average_order_value
FROM	orders o
		JOIN
        payments p
        ON	o.order_id = p.order_id
WHERE	o.order_status = 'delivered'
GROUP BY	1
HAVING month_year != '2016-12' --Excluding December 2016
ORDER BY	1;
