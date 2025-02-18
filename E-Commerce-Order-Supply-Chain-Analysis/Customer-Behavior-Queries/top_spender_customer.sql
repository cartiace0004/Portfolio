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

--query to confirm that the top spender is a one-time purchase
--customer:
SELECT	c.customer_id, pr.product_id, pr.product_category_name, p.payment_value
from	customers c
JOIN	orders o
		ON	c.customer_id = o.customer_id
JOIN	payments p
		ON o.order_id = p.order_id
JOIN	order_items oi
		ON	oi.order_id = o.order_id
JOIN	products pr
		ON oi.product_id = pr.product_id
WHERE	c.customer_id = 'bmv1Lg65SUWP';

--in this query, we found out that the top spender was
-- bulk buying a specific product with a whopping
-- 31 units bought:
SELECT	pr.product_id, pr.product_category_name,
		oi.price, oi.shipping_charges
FROM	products pr
JOIN	order_items oi
		ON pr.product_id = oi.product_id
WHERE	pr.product_id = 'CM0S7dymD9yF';
