-- Regional Spending Trends
-- goal: identify which regions (city/state) are contributing most to your total revenue. this helps uncover
-- regional differences in customer spending behavior by quartiles
WITH regional_spending AS (
    SELECT
        c.customer_city,
        c.customer_state,
        SUM(p.payment_value) AS total_spent
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_city, c.customer_state
)
SELECT *,
       NTILE(4) OVER(ORDER BY total_spent DESC) AS spending_segment
FROM regional_spending;
