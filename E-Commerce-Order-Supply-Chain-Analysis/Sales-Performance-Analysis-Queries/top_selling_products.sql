--Find the top 5 best selling products based on revenue:
SELECT 
    oi.product_id, 
    p.product_category_name, 
    COUNT(oi.order_id) AS total_orders, 
    SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.product_category_name
ORDER BY total_revenue DESC
LIMIT 5;
