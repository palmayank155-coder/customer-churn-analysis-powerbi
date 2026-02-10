-- =========================================
-- Telco Customer Churn Analysis
-- Author: Mayank
-- Purpose: SQL-based churn metrics and validation
-- =========================================

-- Overall churn metrics
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate_pct
FROM fact_customer;

-- Churn rate by customer type
SELECT
    customer_type,
    COUNT(*) AS total_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate_pct
FROM fact_customer
GROUP BY customer_type
ORDER BY churn_rate_pct DESC;

-- Churn rate by contract type
SELECT
    contract,
    COUNT(*) AS total_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate_pct
FROM fact_customer
GROUP BY contract
ORDER BY churn_rate_pct DESC;

-- Revenue at risk by customer segment
SELECT
    customer_type,
    ROUND(
        SUM(CASE WHEN churn = 'Yes' THEN monthly_charges ELSE 0 END),
        2
    ) AS revenue_at_risk
FROM fact_customer
GROUP BY customer_type
ORDER BY revenue_at_risk DESC;
