# E-Commerce Sales Analysis using SQL

## 📌 Project Overview

This project analyzes e-commerce sales data using SQL to identify sales trends, customer behavior, product performance, profitability, and order patterns.

The analysis was performed using MySQL and DBeaver.

## 🎯 Business Objectives

The main objectives of this project were to:

- Analyze overall sales and revenue performance
- Identify top-performing products and categories
- Analyze customer purchasing behavior
- Identify repeat and one-time customers
- Evaluate order status, cancellations, and returns
- Analyze monthly sales trends and MoM growth
- Compare payment methods and customer spending
- Identify profitable categories and products
- Segment customers based on revenue contribution

## 📊 Dataset

The dataset contains four tables:

| Table | Records |
|---|---:|
| Customers | 1,000 |
| Products | 150 |
| Orders | 5,000 |
| Order Items | 8,518 |

### Tables

**Customers**
- customer_id
- customer_name
- email
- city
- signup_date
- state

**Products**
- product_id
- product_name
- category
- price
- stock
- subcategory
- cost_price

**Orders**
- order_id
- customer_id
- product_id
- order_date
- quantity
- status
- payment_method

**Order Items**
- order_item_id
- order_id
- product_id
- quantity
- unit_price
- discount_pct

## 🛠️ Tools & Technologies

- MySQL
- DBeaver
- SQL

## 🧠 SQL Concepts Used

- SELECT
- WHERE
- ORDER BY
- DISTINCT
- LIMIT
- Aggregate Functions
- GROUP BY
- HAVING
- INNER JOIN
- LEFT JOIN
- CASE WHEN
- Subqueries
- CTEs
- Window Functions
- ROW_NUMBER()
- RANK()
- LAG()
- COALESCE()
- UNION / UNION ALL
- Date Functions

## 💰 Revenue Analysis

The analysis calculated discounted revenue using:

`quantity × unit_price × (1 - discount_pct / 100)`

Total discounted order-item revenue was approximately **₹29.12 crore**.

## 🔍 Key Business Insights

- **Beauty** was the highest-revenue category, generating approximately **₹8.79 crore**.
- **Home & Kitchen** had the highest category profit margin at approximately **23.96%**.
- **Footwear_Product_121** was the top product by discounted revenue, generating approximately **₹55.16 lakh**.
- **Outdoor_Product_087** sold the highest number of units, with **165 units**.
- **January 2025** recorded the highest monthly revenue at approximately **₹1.21 crore**.
- The highest month-over-month revenue growth was **52.82%** from December 2024 to January 2025.
- **96.26%** of customers who made at least one purchase were repeat customers.
- **9.52%** of orders were either cancelled or returned.
- Cancelled and returned orders represented approximately **₹2.89 crore of associated order value**.
- **UPI** was the most frequently used payment method, accounting for **37.88%** of orders.
- **Maharashtra** generated the highest state-level revenue at approximately **₹5.26 crore**.

## 👥 Customer Segmentation

Customers were segmented based on their total revenue contribution:

| Segment | Customers | Average Revenue / Customer |
|---|---:|---:|
| High Value | 21 | ₹8,24,590.60 |
| Medium Value | 88 | ₹5,73,424.99 |
| Low Value | 881 | ₹2,53,576.85 |

This segmentation can help businesses identify high-value customers for retention and medium/low-value customers for upselling and cross-selling opportunities.

## 💡 Business Recommendations

Based on the analysis:

1. Focus on retaining high-value customers through targeted loyalty strategies.
2. Identify opportunities to move medium-value customers into the high-value segment.
3. Investigate the reasons behind cancelled and returned orders.
4. Analyze low-margin products for pricing, discount, or cost optimization.
5. Continue investing in high-performing categories such as Beauty.
6. Investigate monthly revenue fluctuations to understand seasonal or operational factors.

## 📁 Project Structure

```text
ecommerce-sales-analysis-sql/
│
├── README.md
│
├── data/
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   └── order_items.csv
│
└── sql/
    ├── data_validation.sql
    ├── sales_analysis.sql
    ├── customer_analysis.sql
    ├── product_analysis.sql
    └── business_insights.sql
