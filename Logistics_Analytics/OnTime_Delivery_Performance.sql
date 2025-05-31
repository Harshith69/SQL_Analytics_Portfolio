-- Calculating Customer wise delivery performance (ontime, late, overdue) in last 6 months
WITH delivery_metrics AS ( SELECT c.customer_id, c.customer_name, COUNT(*) AS total_orders,
        SUM(CASE WHEN s.actual_delivery <= o.required_date THEN 1 ELSE 0 END) AS on_time_deliveries,
        SUM(CASE WHEN s.actual_delivery > o.required_date THEN 1 ELSE 0 END) AS late_deliveries,
        SUM(CASE WHEN s.status != 'Delivered' AND o.required_date < CURRENT_DATE THEN 1 ELSE 0 END) AS overdue_orders
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN shipments s ON o.order_id = s.order_id
    WHERE o.status IN ('Shipped','Delivered') AND o.order_date >= CURRENT_DATE - INTERVAL '6 months'
    GROUP BY c.customer_id, c.customer_name)

SELECT customer_id, customer_name, total_orders, on_time_deliveries, late_deliveries, overdue_orders,
    ROUND(on_time_deliveries * 100.0 / total_orders, 2) AS on_time_percentage,
FROM delivery_metrics
WHERE total_orders >= 5
ORDER BY on_time_percentage DESC;
