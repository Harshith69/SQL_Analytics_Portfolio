-- Calculating MoM growth for each product category to check progress
WITH monthly_sales AS (SELECT p.category,
        DATE_TRUNC('month', s.sale_date) AS month,
        SUM(s.total_amount) AS total_sales,
        LAG(SUM(s.total_amount), 1) OVER (PARTITION BY p.category ORDER BY DATE_TRUNC('month', s.sale_date)) AS prev_month_sales
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY p.category, DATE_TRUNC('month', s.sale_date))

SELECT category, month, total_sales, prev_month_sales, ROUND((total_sales - prev_month_sales) / prev_month_sales * 100, 2) AS growth_percentage
FROM monthly_sales
ORDER BY category, month;
