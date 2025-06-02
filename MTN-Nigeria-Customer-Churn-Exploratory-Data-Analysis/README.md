# MTN Nigeria Customer Churn Exploratory Data Analysis

## What is MTN Nigeria?
- MTN Nigeria Communications PLC is the leading telecommunications provider in Nigeria and a subsidiary of the **MTN Group**, a multinational telecom company headquartered in South Africa. Established in 2000, MTN Nigeria has grown to become the country's largest mobile network operator per [Emis](https://www.emis.com/php/company-profile/NG/Mtn_Nigeria_Communications_Plc_en_8352912.html).

## What is Customer Churn?
- Customer churn is a business phenomenon where customers stop doing business with a company or stop using a product/service over a given period of time. Also known as **customer attrition**.

### Why does it matter in Business?
- Churn is a key performance indicator for many businesses, especially in industries like:

  - Subscription services
  - Telecommunications
  - SaaS
  - Banking & Insurance
  - E-Commerce

### What are common causes of Churn?
- Causes vary as these range from `Poor customer service`, `High prices`, `Better offers from competitors`, `Lack of product engagement or perceived value` and `Bad user experience`.

## Relevance of the Analysis
- Given MTN Nigeria's extensive subscriber base and diverse service offerings, analyzing customer churn can provide insights into:

  - **Customer Retention**: Understanding why customers discontinue services can help in developing strategies to improve retention.
  - **Service Improvement**: Identifying patterns in churn can highlight areas where service enhancements are needed.
  - **Market Strategy**: Analyzingg churn across different demographics and regions can inform targeted marketing and service delivery.

## The Dataset
- The dataset was taken from [Kaggle](https://www.kaggle.com/datasets/oluwademiladeadeniyi/mtn-nigeria-customer-churn?resource=download). The dataset simulates the behaviour, preferences and churn patterns of MTN Nigeria customers in Q1 2025. It provides rich insight into device usage, data plan preferences, age, groups, tenure, churn drivers, and revenue patterns. The dataset contains 974 rows and possess the following columns:

  - Customer ID: A unique identifier assigned to each customer. It may appear more than once if the customer owns multiple devices.
  - Full Name: The full name of the customer. Names reflect a balance across Nigerian ethnicities and regions.
  - Date of Purchase: Month and year the device or plan was purchased. All entries are from 2025.
  - Age: Age of the customer (between 16 and 80). Rules apply to age and purchasing behaviour.
  - State: Nigerian state where the customer resides, including the FCT.
  - MTN Device: Device purchased by the customer. Includes: Mobile SIM Card, Broadband MiFi, 4G Router, 5G Broadband Router.
  - Gender: Gender of the customer (Male or Female).
  - Satisfaction Rate: A score from 0 to 5 reflecting the customer’s satisfaction.
  - Customer Review: Categorical review of the customer experience: Poor, Fair, Good, Very Good, Excellent.
  - Customer Tenure in months: How long the customer has been subscribed (in months).
  - Subscription Plan: The name of the MTN data plan purchased (e.g., 60GB Monthly Broadband Plan, 7GB Monthly Plan, etc.).
  - Unit Price: Cost of the data plan in Nigerian Naira (₦).
  - Data Usage: Estimated data usage in gigabytes (GB). Not necessarily equal to the plan size—it reflects usage behaviour.
  - Number of Times Purchased: How many times the plan was purchased within the month (simulates customer consumption rate).
  - Total Revenue: Total amount spent by the customer (calculated as Unit Price × Number of Times Purchased).
  - Customer Churn Status: Indicates whether the customer has churned (Yes) or is still active (No).
  - Reasons for Churn: If churned, this field shows the reason (e.g., Poor Network, Relocation, High Call Tariffs, etc.). Empty for active customers.

## Data Cleaning
- The dataset consisted of columns with their names not snake_cased. For it to be easier to code, we converted the column names to a much more efficient and easier to write on query snake_cased format:

<pre> ```sql 
ALTER TABLE mtn_customer_churn
CHANGE COLUMN `Date of Purchase` date_of_purchase VARCHAR(20),
CHANGE COLUMN `ï»¿Customer ID` customer_id VARCHAR(20),
CHANGE COLUMN `Age` age INT,
CHANGE COLUMN `State` state VARCHAR(20),
CHANGE COLUMN `MTN Device` mtn_device VARCHAR(20),
CHANGE COLUMN `Gender` gender VARCHAR(20),
CHANGE COLUMN `Satisfaction Rate` satisfaction_rate INT,
CHANGE COLUMN `Customer Review` customer_review VARCHAR(20),
CHANGE COLUMN `Customer Tenure in months` customer_tenure_mnths INT,
CHANGE COLUMN `Subscription Plan` subscription VARCHAR(500),
CHANGE COLUMN `Unit Price` unit_price INT,
CHANGE COLUMN `Number of Times Purchased` num_purchase INT,
CHANGE COLUMN `Total Revenue` total_revenue INT,
CHANGE COLUMN `Data Usage` data_usage DECIMAL(5, 2),
CHANGE COLUMN `Customer Churn Status` churn_status VARCHAR(20),
CHANGE COLUMN `Reasons for Churn` reason VARCHAR(500);

ALTER TABLE mtn_customer_churn
CHANGE COLUMN `Full Name` full_name VARCHAR(50);
``` </pre>
