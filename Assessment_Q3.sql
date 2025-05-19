select * from plans_plan;
select * from savings_savingsaccount;

-- Question 3

WITH last_txn_per_plan AS (
    SELECT 
        plan_id,
        MAX(transaction_date) AS last_transaction_date
    FROM savings_savingsaccount
    GROUP BY plan_id
),

active_plans AS (
    SELECT 
        id AS plan_id,
        owner_id,
        plan_type_id
    FROM plans_plan
    WHERE is_deleted = FALSE  -- optional, assuming this marks inactive
),

joined AS (
    SELECT 
        ap.plan_id,
        ap.owner_id,
        CASE 
            WHEN ap.plan_type_id = 1 THEN 'Savings'
            WHEN ap.plan_type_id = 2 THEN 'Investment'
            ELSE 'Other'
        END AS type,
        ltp.last_transaction_date
    FROM active_plans ap
    LEFT JOIN last_txn_per_plan ltp ON ap.plan_id = ltp.plan_id
)

SELECT 
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days
FROM joined
WHERE last_transaction_date IS NOT NULL
  AND DATEDIFF(CURDATE(), last_transaction_date) > 365
ORDER BY inactivity_days DESC;