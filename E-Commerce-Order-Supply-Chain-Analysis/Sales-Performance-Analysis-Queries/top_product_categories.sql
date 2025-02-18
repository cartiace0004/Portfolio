--Identify the top 5 product categories based on total revenue:
SELECT	p.product_category_name,
		COUNT(oi.order_id) as total_orders,
        SUM(oi.price) as total_revenue
FROM	order_items oi
		JOIN
		products p
        ON	oi.product_id = p.product_id
GROUP BY	1
ORDER BY	total_revenue DESC
LIMIT	5;
