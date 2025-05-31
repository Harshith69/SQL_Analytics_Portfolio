-- identifing the busy hours (most transactions hours) in last 3 months
WITH hourly_patterns AS (SELECT EXTRACT(DAY FROM transaction_date) AS week_day, EXTRACT(HOUR FROM transaction_date) AS hour_of_day, transaction_type,
        COUNT(*) AS transaction_count,
        SUM(amount) AS total_amount,
        AVG(amount) AS avg_amount
    FROM transactions
    WHERE transaction_date >= CURRENT_DATE - INTERVAL '3 months'
    GROUP BY 1, 2, 3)

SELECT week_day, hour_of_day,transaction_type, transaction_count, total_amount, avg_amount,
    ROUND(100.0 * transaction_count / SUM(transaction_count) OVER (PARTITION BY transaction_type), 2) AS pct_of_type,
    ROUND(100.0 * transaction_count / SUM(transaction_count) OVER (PARTITION BY hour_of_day), 2) AS pct_of_hour
FROM hourly_patterns
ORDER BY week_day, hour_of_day, transaction_type;
