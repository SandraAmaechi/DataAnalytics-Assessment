select * from users_customuser;
select * from savings_savingsaccount;

-- Question 2

WITH monthly_txns AS (
    SELECT 
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS txn_month,
        COUNT(*) AS txn_count
    FROM savings_savingsaccount
    WHERE transaction_status = 'successful'  
    GROUP BY owner_id, txn_month
),

avg_txns AS (
    SELECT 
        owner_id,
        AVG(txn_count) AS avg_monthly_txn
    FROM monthly_txns
    GROUP BY owner_id
),

categorized AS (
    SELECT 
        owner_id,
        CASE 
            WHEN avg_monthly_txn >= 10 THEN 'High'
            WHEN avg_monthly_txn >= 5 THEN 'Medium'
            ELSE 'Low'
        END AS frequency_category,
        avg_monthly_txn
    FROM avg_txns
)

SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_monthly_txn), 2) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High', 'Medium', 'Low');