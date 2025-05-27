-- Segmenting the customers by transaction activity and balance

WITH customer_metrics AS (SELECT c.customer_id, c.first_name, c.last_name,
        COUNT(DISTINCT a.account_id) AS num_accounts,
        SUM(a.balance) AS total_balance,
        COUNT(t.transaction_id) AS num_transactions,
        SUM(CASE WHEN t.transaction_type = 'DEPOSIT' THEN t.amount ELSE 0 END) AS total_deposits,
        SUM(CASE WHEN t.transaction_type = 'WITHDRAWAL' THEN t.amount ELSE 0 END) AS total_withdrawals,
        DATE_DIFF('day', MAX(t.transaction_date), CURRENT_DATE) AS days_since_last_activity
    FROM customers c
    LEFT JOIN accounts a ON c.customer_id = a.customer_id
    LEFT JOIN transactions t ON a.account_id = t.account_id
    WHERE t.transaction_date >= CURRENT_DATE - INTERVAL '12 months'
    GROUP BY c.customer_id, c.first_name, c.last_name)

SELECT customer_id, first_name, last_name, num_accounts, total_balance, num_transactions, total_deposits, total_withdrawals, days_since_last_activity,
    CASE
        WHEN total_balance > 100000 AND num_transactions >= 10 THEN 'High Value Active'
        WHEN total_balance > 50000 AND num_transactions >= 5 THEN 'Medium Value Active'
        WHEN total_balance > 0 AND days_since_last_activity <= 30 THEN 'Low Value Active'
        WHEN days_since_last_activity > 90 THEN 'Dormant'
        ELSE 'Other'
    END AS customer_segment
FROM customer_metrics
ORDER BY total_balance DESC;
