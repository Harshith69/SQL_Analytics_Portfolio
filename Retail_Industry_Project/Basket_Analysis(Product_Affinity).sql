-- Finding products which are frequently purchased together (more than 10 times)
SELECT p1.product_name AS product1,p 2.product_name AS product2, COUNT(*) AS times_purchased_together
FROM sales s1
JOIN sales s2 ON s1.sale_id = s2.sale_id AND s1.product_id < s2.product_id
JOIN products p1 ON s1.product_id = p1.product_id
JOIN products p2 ON s2.product_id = p2.product_id
GROUP BY p1.product_name, p2.product_name
HAVING COUNT(*) > 10
ORDER BY times_purchased_together DESC;
