--Analyze revenue trends over time
SELECT	DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') as month,
		COUNT(DISTINCT o.order_id) as order_count,
        SUM(p.payment_value) as monthly_revenue
FROM	orders	o
		JOIN	
        payments p
        ON	o.order_id = p.order_id
WHERE	o.order_status = 'delivered'
GROUP BY	1
ORDER BY	1;
