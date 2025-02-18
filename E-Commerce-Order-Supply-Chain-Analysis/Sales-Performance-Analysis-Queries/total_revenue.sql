-- Find the total revenue and numbers of orders in the dataset:
SELECT 
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.price + oi.shipping_charges) AS total_revenue
FROM order_items oi;
