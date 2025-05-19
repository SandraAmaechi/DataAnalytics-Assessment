# Data Analytics Assessment

This project contains solutions to four SQL-based business questions designed to assess data querying, transformation, and insight generation skills. All queries were written using MySQL, and the dataset was provided as part of the task.

---

## 🔍 Questions & Approaches

### **Q1: Identify Customers with Both Funded Savings and Investment Plans**

**Task:**  
Find customers who have **at least one funded savings plan** and **one funded investment plan**, then sort the result by their **total deposits**.

**Approach:**  
- Joined the `users_customuser`, `savings_savingsaccount`, and `plans_plan` tables.
- Filtered for plans that are both **active** and funded.
- Used `plan_type_id` to distinguish between savings and investment.
- Grouped by customer to count how many of each type they had.
- Filtered to keep only customers who had **at least one of both**.
- Calculated total deposits per customer and sorted accordingly.

**Insight:**  
This helped identify **high-value, cross-engaged customers** who have committed to both savings and investment products.

---

### **Q2: Categorize Customers by Average Monthly Transaction Frequency**

**Task:**  
Calculate the **average number of transactions per customer per month** and categorize each customer as **Low, Medium, or High frequency**.

**Approach:**  
- Counted total transactions for each customer.
- Calculated the number of **months active** using their earliest and latest transaction dates.
- Computed average transactions per month.
- Applied rules:
  - **High**: ≥ 10
  - **Medium**: 5–9
  - **Low**: < 5

**Insight:**  
This categorization helps the business understand customer **engagement levels** and tailor communication or rewards accordingly.

---

### **Q3: Find Active Plans with No Transactions in the Past Year**

**Task:**  
Identify all active **savings or investment plans** with **no transactions in the last 365 days**.

**Approach:**  
- Retrieved the most recent transaction per plan from `savings_savingsaccount`.
- Compared that with the current date to calculate **inactivity_days**.
- Joined with `plans_plan` to ensure the plans are **active**.
- Filtered for inactivity greater than or equal to 365 days.
- Labeled the account as “Savings” or “Investment” using `plan_type_id`.

**Insight:**  
Helps pinpoint **dormant plans** that may require reactivation campaigns or account reviews.

---

### **Q4: Estimate Customer Lifetime Value (CLV)**

**Task:**  
Estimate CLV for each customer using the formula:

```

CLV = (total\_transactions / tenure\_months) \* 12 \* avg\_profit\_per\_transaction

```

Where `avg_profit_per_transaction = 0.1%` of each transaction.

**Approach:**  
- Calculated **account tenure** as months since signup using the `date_joined` field.
- Counted total transactions from `savings_savingsaccount`.
- Applied the formula with assumed average profit.
- Ordered customers by their estimated CLV in descending order.

**Insight:**  
Provides a data-backed estimate of each customer's **long-term value** to the business, aiding in prioritization of retention strategies.

---

## ⚙️ Challenges Encountered

- **Ambiguous Column Names:**  
  Columns like `owner_id` and `id` appear in multiple tables, requiring clear table aliases and careful joins.

- **Identifying Plan Types:**  
  The `plan_type_id` had no explicit mapping provided. I had to explore the distinct values and infer their meanings based on usage patterns and naming logic.

- **Inactive Accounts Detection:**  
  Required identifying the **last transaction per plan**, which involved subqueries and date comparisons.

- **CLV Calculation Logic:**  
  Handling edge cases where tenure might be zero (new signups) to avoid division errors.

---

## ✅ Project Structure

```

DataAnalytics-Assessment/
│
├── Assessment\_Q1.sql
├── Assessment\_Q2.sql
├── Assessment\_Q3.sql
├── Assessment\_Q4.sql
│
└── README.md

```

Each SQL file contains:
- A single query
- Proper formatting
- Comments where necessary

---

## 💡 Conclusion

This project demonstrates proficiency in using SQL to:
- Join complex tables
- Transform and aggregate data
- Extract actionable business insights

Thanks for reviewing!
```

