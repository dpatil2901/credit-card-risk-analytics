# Credit Card Transaction and Customer Risk Analytics (Power BI)

### 🔍 Business Problem
The bank aims to analyze customer and transaction behavior across all issued credit cards to identify risks, optimize credit policies, and enhance customer insights.

### 📊 Scope of Analysis

#### 1. Fraud Detection & Risk Management
- Identify high-risk transactions using chip usage, error logs, and unusual merchant patterns.

#### 2. Customer Segmentation & Spending Behavior
- Analyze how age, income, and credit score influence spending frequency and transaction volume.

#### 3. Credit Policy Optimization
- Correlate credit scores, credit limits, and spending behavior to recommend data-driven credit limit adjustments.

#### 4. Card Performance Analysis
- Compare transaction success rates and profitability across card brands and types (Visa vs. Mastercard, Platinum vs. Gold).

### 🌐 Power BI Dashboard Link
[View Dashboard](https://app.powerbi.com/view?r=eyJrIjoiMGRlZTU3NzgtNmFhNC00ZGIwLWI1MGItODRmM2NmYmUwZmZmIiwidCI6IjgwNzkwOTIyLWJmY2EtNGE4OS1iYzJiLThhN2E5YzFkMDZiYSIsImMiOjZ9)

---

### 📁 Data Modeling-
<img width="1125" height="573" alt="Screenshot 2025-11-12 211831" src="https://github.com/user-attachments/assets/2aa940eb-a7ec-4ef0-83d5-d537db0ad982" />
---

## 🧮 DAX Measures Used

```DAX
1. Total Transactions

Total Transactions = COUNT(clean_transactions[id])

Counts the total number of transactions.

2. Total Amount
Total Amount = SUM(clean_transactions[amount])

Calculates the total transaction value across all records.

3. Error Transactions
Error Transactions =
COUNTROWS(
    FILTER(clean_transactions, clean_transactions[errors] <> BLANK())
)

Counts transactions that have any associated error.

4. Error % by State
Error % by State =
DIVIDE(
    [Error Transactions],
    CALCULATE([Total Transactions], ALL(clean_transactions[merchant_state]))
)

Computes the error transaction percentage for each state.

5. Avg Transaction per Customer
Avg Transaction per Customer =
DIVIDE([Total Transactions], DISTINCTCOUNT(clean_transactions[client_id]))

Calculates average number of transactions per unique customer.

6. Chip Transactions
Chip Transactions =
COUNTROWS(
    FILTER(clean_transactions, clean_transactions[use_chip] = "Yes")
)

Counts the number of chip-based transactions.

7. High Credit Score Customers
High Credit Score Customers =
COUNTROWS(
    FILTER(clean_users, clean_users[credit_score] >= 750)
)

Counts customers with credit scores of 750 and above.

8. High Debt Customers
High Debt Customers =
COUNTROWS(
    FILTER(clean_users, clean_users[total_debt] > 50000)
)

Counts customers whose total debt exceeds 50,000.

9. Avg Transaction Amount
Avg Transaction Amount = AVERAGE(clean_transactions[amount])

Calculates average transaction amount.

10. Total Customers
Total Customers = DISTINCTCOUNT(clean_users[id])

Counts unique customers in the dataset.

11. Transaction Success Rate
Transaction Success Rate =
1 - DIVIDE([Error Transactions], [Total Transactions])

Calculates the percentage of successful transactions.

12. Error Txn by Merchant
Error Txn by Merchant =
COUNTROWS(
    FILTER(clean_transactions, clean_transactions[errors] <> BLANK())
)

Counts error transactions grouped by merchant.

