SELECT*
FROM upi_transactions_2024 

#datacleaning
#check null value

select *
from upi_transactions_2024
where merchant_category is null
   AND transaction_status is null
   and transaction_type is null;

   #check duplicate

   select transaction_id,COUNT(*)
   from upi_transactions_2024
   group by transaction_id
   HAVING COUNT(*)>1;

   #alter

ALTER table upi_transactins_2024
ALTER COLUMN [amount_INR] DECIMAL(18,2);

ALTER TABLE upi_transaction_2024
ALTER COLUMN [timestamp] datetime;

##KPI Queries (SQL Server)##

# Total Transactions

SELECT  COUNT(*) AS total_transaction
FROM upi_transactions_2024

#Total Revenue

SELECT CAST(SUM([amount_INR]) AS DECIMAL(18,2)) AS total_revenue
FROM upi_transactions_2024;

#Success Rate %

SELECT 

   cast( SUM(CASE 
            WHEN transaction_status = 'SUCCESS' 
            THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(*) as decimal(18,2))AS success_percentage
FROM upi_transactions_2024;

#Fraud Rate %

SELECT 
CAST(SUM(fraud_flag)*100.0/count(*) as decimal(10,2))as fraud_rate
FROM upi_transactions_2024;

#Average Transaction Value

select
CAST(sum(amount_INR)/COUNT(transaction_status)as decimal(10,2))  as avg_transaction_value
from upi_transactions_2024;



#Transactions by Merchant Category

select Merchant_Category,
count(*) as total_transactions
from upi_transactions_2024
group by Merchant_Category
order by total_transactions desc

#Transactions by State

SELECT 
    sender_state,
    COUNT(*) AS total_transactions
FROM upi_transactions_2024
GROUP BY sender_state
ORDER BY total_transactions DESC;

#Revenue & Customer Insights

SELECT 
    merchant_category,
    cast(SUM([amount_INR])as decimal(10,2)) AS total_revenue
FROM upi_transactions_2024
GROUP BY merchant_category
ORDER BY total_revenue DESC;

#Fraud Risk Analysis

SELECT 
    sender_state,
    CAST(SUM(fraud_flag) * 100.0 / COUNT(*) AS DECIMAL(10,2))
        AS fraud_rate_percentage
FROM upi_transactions_2024
GROUP BY sender_state
ORDER BY fraud_rate_percentage DESC

#Fraud Heatmap Data

SELECT 
    hour_of_day,
    day_of_week,
    CAST(SUM(fraud_flag) * 100.0 / COUNT(*) AS DECIMAL(10,2))
        AS fraud_rate_percentage
FROM upi_transactions_2024
GROUP BY hour_of_day, day_of_week
ORDER BY hour_of_day;







