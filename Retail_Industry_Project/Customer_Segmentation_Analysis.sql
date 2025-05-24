-- Identifing highvalue customers (top 10% by spend) and their purchasing patterns
WITH customer_spend AS ( SELECT c.customer_id, c.first_name, c.last_name,
        SUM(s.total_amount) AS total_spend,
        NTILE(10) OVER (ORDER BY SUM(s.total_amount) DESC) AS spend_decile 
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name)

SELECT customer_id, first_name, last_name, total_spend
FROM customer_spend
WHERE spend_decile = 1
ORDER BY total_spend DESC;
