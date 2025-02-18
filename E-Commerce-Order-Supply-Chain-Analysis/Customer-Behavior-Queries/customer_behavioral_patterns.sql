-- next query: behavioral patterns of customers
-- order frequency by region
-- returns which regions has the most frequent orders
SELECT
	c.customer_state,
    COUNT(o.order_id) as total_orders
FROM	orders o
JOIN	customers c
		ON o.customer_id = c.customer_id
GROUP BY	1
ORDER BY 	total_orders DESC;

-- popular purchase times
-- returns the time of the day where customers purchase
SELECT
	HOUR(order_purchase_timestamp) as peak_hour,
    COUNT(order_id) as total_orders
FROM	orders
GROUP BY	1
ORDER BY	total_orders DESC;

-- category preferences by region
SELECT
	c.customer_state,
    p.product_category_name,
    COUNT(o.order_id) as total_orders
FROM	orders o
JOIN	order_items oi
		ON o.order_id = oi.order_id
JOIN	products p
		ON oi.product_id = p.product_id
JOIN	customers c
		ON o.customer_id = c.customer_id
GROUP BY	1, 2
ORDER BY	1, 3 DESC;
