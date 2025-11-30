-- 1. Total Transactions
CREATE OR REPLACE VIEW v_total_transactions AS
SELECT COUNT(id) AS total_transactions
FROM clean_transactions;


-- 2. Total Amount
CREATE OR REPLACE VIEW v_total_amount AS
SELECT SUM(amount) AS total_amount
FROM clean_transactions;


-- 3. Error Transactions
CREATE OR REPLACE VIEW v_error_transactions AS
SELECT COUNT(*) AS error_transactions
FROM clean_transactions
WHERE errors IS NOT NULL AND errors <> '';


-- 4. Error % by State
CREATE OR REPLACE VIEW v_error_pct_by_state AS
SELECT 
    merchant_state,
    (COUNT(CASE WHEN errors IS NOT NULL AND errors <> '' THEN 1 END) * 1.0 
     / COUNT(*)) AS error_percentage
FROM clean_transactions
GROUP BY merchant_state;


-- 5. Avg Transaction per Customer
CREATE OR REPLACE VIEW v_avg_txn_per_customer AS
SELECT 
    COUNT(*) * 1.0 / COUNT(DISTINCT client_id) AS avg_txn_per_customer
FROM clean_transactions;


-- 6. Chip Transactions
CREATE OR REPLACE VIEW v_chip_transactions AS
SELECT COUNT(*) AS chip_transactions
FROM clean_transactions
WHERE use_chip = 'Yes';


-- 7. High Credit Score Customers
CREATE OR REPLACE VIEW v_high_credit_score_customers AS
SELECT COUNT(*) AS high_credit_score_customers
FROM clean_users
WHERE credit_score >= 750;


-- 8. High Debt Customers
CREATE OR REPLACE VIEW v_high_debt_customers AS
SELECT COUNT(*) AS high_debt_customers
FROM clean_users
WHERE total_debt > 50000;


-- 9. Avg Transaction Amount
CREATE OR REPLACE VIEW v_avg_transaction_amount AS
SELECT AVG(amount) AS avg_transaction_amount
FROM clean_transactions;


-- 10. Total Customers
CREATE OR REPLACE VIEW v_total_customers AS
SELECT COUNT(DISTINCT id) AS total_customers
FROM clean_users;


-- 11. Transaction Success Rate
CREATE OR REPLACE VIEW v_transaction_success_rate AS
SELECT 
    1 - (
        COUNT(CASE WHEN errors IS NOT NULL AND errors <> '' THEN 1 END) * 1.0
        / COUNT(*)
    ) AS transaction_success_rate
FROM clean_transactions;


-- 12. Error Transactions by Merchant
CREATE OR REPLACE VIEW v_error_txn_by_merchant AS
SELECT 
    merchant_id,
    COUNT(*) AS error_transactions
FROM clean_transactions
WHERE errors IS NOT NULL AND errors <> ''
GROUP BY merchant_id;
