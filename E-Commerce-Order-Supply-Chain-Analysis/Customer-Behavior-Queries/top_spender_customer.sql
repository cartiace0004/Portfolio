--Goal: Identify customers who spent the most:
SELECT	o.customer_id,
		c.customer_city,
        c.customer_state,
        SUM(p.payment_value) as total_spent
FROM	orders o
		JOIN
        payments p
        ON	o.order_id = p.order_id
        JOIN
        customers c
        ON	o.customer_id = c.customer_id
GROUP BY	1, 2, 3
ORDER BY	total_spent DESC
LIMIT	5;
