-- Calculating inventory turnover by product category
WITH product_sales AS ( SELECT  p.product_id, p.category, p.product_name,
        SUM(s.quantity) AS total_quantity_sold,
        SUM(s.total_amount) AS total_revenue
    FROM products p
    JOIN sales s ON p.product_id = s.product_id
    GROUP BY p.product_id, p.category, p.product_name)

SELECT category,
    COUNT(*) AS num_products,
    SUM(total_quantity_sold) AS total_units_sold,
    SUM(total_revenue) AS total_revenue,
    ROUND(SUM(total_quantity_sold) / COUNT(*), 2) AS avg_units_sold_per_product,
    ROUND(SUM(total_revenue) / SUM(total_quantity_sold), 2) AS avg_price_per_unit
FROM product_sales
GROUP BY category
ORDER BY total_revenue DESC;
