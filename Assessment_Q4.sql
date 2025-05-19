select * from users_customuser;
select * from savings_savingsaccount;

-- Question 4

WITH customer_txns AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        AVG(s.amount * 0.001) AS avg_profit_per_transaction,
        SUM(s.amount * 0.001) AS total_profit
    FROM savings_savingsaccount s
    GROUP BY s.owner_id
),

customer_tenure AS (
    SELECT 
        u.id AS customer_id,
        u.name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months
    FROM users_customuser u
),

clv_calc AS (
    SELECT 
        ct.customer_id,
        ct.name,
        ct.tenure_months,
        tx.total_transactions,
        ROUND(
            (tx.total_transactions / NULLIF(ct.tenure_months, 0)) * 12 * tx.avg_profit_per_transaction, 
            2
        ) AS estimated_clv
    FROM customer_tenure ct
    JOIN customer_txns tx ON ct.customer_id = tx.owner_id
)

SELECT *
FROM clv_calc
ORDER BY estimated_clv DESC;