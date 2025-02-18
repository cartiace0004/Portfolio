# E-Commerce Order and Supply Chain Exploratory Data Analysis
This project analyzes e-commerce orders and payment data to uncover and provide insights on sales performance, customer behavior and order fulfillments.

## Project Overview

The dataset used was from kaggle called `Ecommerce Order & Supply Chain` focusing on a logistics company based in Brazil. This consists of information about customer orders, payment method, product details, and delivery timestamps. The dataset is flawed, however, with missing row values and dates ranging only from Q4 2016 - Q3 2018.
There are a wide variety of products found in this dataset ranging from home decors, personal necessities, to toys. This analysis focuses on:
- **Sales Performance:** Examining the total sales, top-selling products, analyzing revenue trends over time, month-over-month revenue growths, the average order values per month, and sales seasonality analysis.
- **Customer Behavior:** Understanding how customers behave in terms of sales whether if its dependent on the region they belong, their payment preferences, and the amount they spend on a single transaction.
- **Order Fulfillment Efficiency:** Investigating early vs. late deliveries and identifying regions with the most consistent delays.

## Key Insights

### 1. Sales Performance
- **Top-Selling Products:** the top 5 best selling products are mostly from the `Toys` category with a small niche of profitable market for `Garden Tools` being the only product that is a non-toy.
- **Top-Selling Product Categories:** `Toys` dominate in total revenue, followed by `Furniture Decorations` then `Garden Tools`. This could mean that the logistics company has a good reputation for handling and delivering large items safely from hubs to their respective buyers.
- **Analyzing Revenue Trends Overtime:** Revenue trends are greatly affected by seasons, holiday-promotion sales and market saturation.
- **Month-over-month Growth:** Ups and downs in terms of revenue growth, having a strong early start in the 1st quarter of 2017 followed by a Revenue spike mid to late 2017, stability in Q1 2018, then steady decline in Q2-Q3 of 2018 implying market saturation.
- **Average Order Value (AOV):** Relatively stable, peaks align with high-sale months such as November's infamous Black Friday.
- **Sales Seasonality Analysis:** Steady rise in AOV quarterly suggesting customers are spending slightly more per transaction, but revenue growth is still mainly *volume-driven*. The highest-grossing quarter was Q1 2018, telling us seasonal trends and holiday-promotion sales are a big factor.

### 2. Customer Behavior
- **Top-Spending Customers:** The dataset consists of unique `customer_id`'s per transaction, meaning it is hard to track repeating customers. But in each transaction, customers are capable of *bulk-buying*. As the top-spender in the dataset bought 31 units of a product that is priced R$231.8 (Price + Shipping Fee) summing up into R$7274.88.
- **Regional Spending Trends:** Top-spending regions were Sao Paulo, Rio de Janeiro, Belo Horizonte, Brazilia all indicate a dense customer base having significant purchasing power.
- **Payment Preferences:** *Credit Card* payment methods are the top choice, accounting forthe highest order volume indicating that customers prefer the convenience and security associated with credit cards followed by *Digital Wallets*, highlighting a growing trend in digital payment methods, suggesting customers are likely looking for faster and a more seamless way to pay online.
- **Behavioral Patterns of Customers:** In this analysis, we found out that customers tend to purchase online in a certain time of the day, where mostly the peak hour when customers do order is at 2:00 PM. Generally in the Afternoon mostly.
