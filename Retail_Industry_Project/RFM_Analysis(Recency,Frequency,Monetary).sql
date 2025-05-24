-- Creating RFM segments for customer marketing strategy
WITH rfm_data AS (SELECT c.customer_id, c.first_name, c.last_name,
        MAX(s.sale_date) AS last_purchase_date,
        COUNT(*) AS frequency,
        SUM(s.total_amount) AS monetary,
        DATE_DIFF('day', MAX(s.sale_date), CURRENT_DATE) AS recency
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name),
  
-- Creating ntiles for customer as score
rfm_scores AS (SELECT customer_id, first_name, last_name, recency, frequency, monetary,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency) AS f_score,
        NTILE(5) OVER (ORDER BY monetary) AS m_score
    FROM rfm_data)
  
-- Creating Customer segments using score conditions
SELECT customer_id, first_name, last_name, recency, frequency, monetary, r_score, f_score, m_score,
    CASE WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Loyal Customers'
        WHEN r_score >= 3 AND f_score >= 1 AND m_score >= 2 THEN 'Potential Loyalists'
        WHEN r_score >= 2 AND f_score >= 2 AND m_score >= 2 THEN 'Recent Customers'
        WHEN r_score >= 1 AND f_score >= 1 AND m_score >= 1 THEN 'At Risk Customers'
        ELSE 'Hibernating' END AS rfm_segment
FROM rfm_scores
ORDER BY r_score DESC, f_score DESC, m_score DESC;
