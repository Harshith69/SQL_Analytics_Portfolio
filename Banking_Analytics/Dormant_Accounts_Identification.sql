-- Finding accounts with no activity in last 6 months
SELECT a.account_id, a.account_type, CONCAT(c.first_name, c.last_name) AS customer_name, a.balance, a.last_transaction_date
FROM accounts a
JOIN customers c ON a.customer_id = c.customer_id
WHERE a.last_transaction_date < CURRENT_DATE - INTERVAL '6 months' AND a.status = 'Active';
