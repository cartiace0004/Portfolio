--Goal: Month-over-month Growth Analysis
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month_year,
        ROUND(SUM(payment_value), 2) AS total_revenue
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    WHERE order_status = 'delivered'
    GROUP BY month_year
	HAVING month_year != '2016-12'
),
mom_growth AS (
    SELECT 
        month_year,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY month_year) AS prev_month_revenue,
        ROUND(
            (total_revenue - LAG(total_revenue) OVER (ORDER BY month_year)) / 
            LAG(total_revenue) OVER (ORDER BY month_year) * 100, 
            2
        ) AS mom_growth_percentage
    FROM monthly_revenue
)
SELECT * FROM mom_growth;
