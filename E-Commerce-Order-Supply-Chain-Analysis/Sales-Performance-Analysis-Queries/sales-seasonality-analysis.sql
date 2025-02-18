--Goal: Analyze Sales Seasonality (quarterly/yearly patterns)

#Set mode ('quarterly' or 'yearly')
SET	@mode = 'quarterly';  #Change this to 'yearly' as needed

SELECT 
    CASE 
        WHEN	@mode = 'quarterly'
        THEN	CONCAT(YEAR(o.order_purchase_timestamp), '-Q', QUARTER(o.order_purchase_timestamp))	
        ELSE	YEAR(o.order_purchase_timestamp)
    END AS period,
		COUNT(DISTINCT o.order_id) AS total_orders,
		SUM(p.payment_value) AS total_revenue,
		ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.order_id), 2) AS average_order_value

FROM 	orders o
		JOIN payments p 
        ON o.order_id = p.order_id
WHERE 	o.order_status = 'delivered'
GROUP BY	period
ORDER BY 	period;
