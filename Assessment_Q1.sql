select * from  users_customuser;
select * from savings_savingsaccount;
select * from plans_plan;

-- question 1

SELECT 
    ssa.owner_id AS owner_id,
    CONCAT(first_name, ' ', last_name) AS name,
    COUNT(is_regular_savings) AS savings_count,
    COUNT(is_a_fund) AS investment_count,
    SUM(confirmed_amount) AS total_amount
FROM
    users_customuser AS uc
        JOIN
    savings_savingsaccount AS ssa ON uc.id = ssa.owner_id
        JOIN
    plans_plan AS pp ON pp.id = ssa.plan_id
GROUP BY owner_id , name
ORDER BY total_amount DESC;