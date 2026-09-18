# E-Commerce Sales & Customer Analytics

> **End-to-end Data Analytics project using Excel, MySQL/SQL and Power BI**

## 📌 Project Overview

This project analyzes e-commerce sales and customer transaction data to identify key business trends, customer behavior, product performance, regional performance, discount patterns, delivery performance, and return behavior.

The project follows an end-to-end analytics workflow:

**Data → Cleaning → SQL Analysis → Power BI Modeling & Visualization → Business Insights**

---

## 🎯 Business Objectives

- Analyze overall e-commerce sales performance
- Identify top-performing products and categories
- Understand customer purchasing behavior
- Identify repeat customers and spending segments
- Compare regional sales performance
- Analyze payment methods and return rates
- Examine discount bands and revenue performance
- Analyze delivery performance and return behavior
- Build an interactive executive dashboard
- Convert analysis into actionable business insights



## 📈 Dashboard Highlights

### Executive Overview

- Total Revenue
- Total Shipping Cost
- Total Orders
- Total Customers
- Average Order Value
- Monthly Revenue Trend
- Revenue by Category
- Regional Revenue Performance
- Return Rate by Category
- Interactive filters for Year, Category, Region and Payment Method

### Customer & Product Analysis

- Top 10 Products by Revenue
- Revenue by Discount Band
- Return Rate by Payment Method
- Customer Spending Segments
- Repeat Customer Analysis
- Customer purchasing behavior

---

## 🧠 SQL Analysis

The SQL analysis contains **48 business-focused queries** covering:

- Revenue and order KPIs
- Category and regional analysis
- Top products and customers
- Repeat customer analysis
- Customer segmentation
- Discount-band analysis
- Monthly revenue trends
- Month-over-month growth
- Delivery performance
- Return-rate analysis
- Payment-method analysis
- CTEs and subqueries
- INNER JOIN / LEFT JOIN
- RANK() and ROW_NUMBER()
- LAG() and cumulative revenue
- Executive-level KPI analysis

The SQL file is available here:

`sql/Ecommerce_Sales_Analysis_Queries.sql`

---

## 🗂️ Dataset

The dataset contains **34,500 e-commerce transaction records** covering orders, customers, products, sales, discounts, payments, delivery, returns, regions, and customer demographics.

### Dataset Columns

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| customer_id | Customer identifier |
| product_id | Product identifier |
| category | Product category |
| price | Product price |
| discount | Discount applied |
| quantity | Quantity purchased |
| payment_method | Payment method used |
| order_date | Date of order |
| delivery_time_days | Delivery time in days |
| region | Customer region |
| returned | Return status |
| total_amount | Total order amount |
| shipping_cost | Shipping cost |
| profit_margin | Recorded profit margin |
| customer_age | Customer age |
| customer_gender | Customer gender |

---

## 🛠️ Tools & Technologies

- **Microsoft Excel** — data cleaning and validation
- **MySQL / SQL** — business analysis and advanced querying
- **Power BI** — data modeling, KPI reporting and interactive visualization

---

## 🔄 Project Workflow

```text
Raw Dataset
    ↓
Excel Data Cleaning & Validation
    ↓
MySQL Data Import
    ↓
SQL Business Analysis
    ↓
Power BI Data Modeling
    ↓
Interactive Dashboard
    ↓
Business Insights
```

---

## 📁 Project Structure

```text
Ecommerce-Sales-Customer-Analytics/
│
├── data/
│   └── Ecommerce_Sales_Cleaned.csv
│
├── sql/
│   └── Ecommerce_Sales_Analysis_Queries.sql
│
├── powerbi/
│   └── Ecommerce_Sales_Analysis_Dashboard.pbix
│
├── screenshots/
│   ├── Dashboard_Page1.png
│   └── Dashboard_Page2.png
│
├── docs/
│   └── BUSINESS_INSIGHTS.md
│
└── README.md
```

---

## 💼 Skills Demonstrated

### Data Analytics

- Data Cleaning
- Data Validation
- Exploratory Data Analysis
- KPI Analysis
- Customer Segmentation
- Business Insights

### SQL

- SELECT, WHERE, GROUP BY, HAVING
- CASE WHEN
- Aggregate Functions
- Subqueries
- CTEs
- INNER JOIN / LEFT JOIN
- Window Functions
- RANK()
- ROW_NUMBER()
- LAG()
- Cumulative Analysis

### Power BI

- Data Modeling
- KPI Cards
- Interactive Filters
- Bar Charts
- Line Charts
- Donut Charts
- Business Dashboards
- Data Visualization

---

## ❓ Business Questions Answered

1. What are the overall sales and order performance?
2. Which product categories generate the highest revenue?
3. Which products are the top revenue generators?
4. Which customers have the highest total spending?
5. What percentage of customers are repeat purchasers?
6. How does revenue vary across regions?
7. Which categories have the highest return rates?
8. How does revenue vary across discount bands?
9. Does delivery speed show an association with order returns?
10. Which payment methods have different return-rate patterns?
11. What is the monthly revenue trend?
12. What is the month-over-month revenue growth?
13. What is the cumulative revenue trend?
14. Which customer spending segments contribute to the customer base?

---

## 🚀 How to Use the Project

### 1. SQL Analysis

Import the cleaned CSV into MySQL and run the queries from:

`sql/Ecommerce_Sales_Analysis_Queries.sql`

### 2. Power BI Dashboard

Open:

`powerbi/Ecommerce_Sales_Analysis_Dashboard.pbix`

Use the available filters to explore the dashboard by year, category, region and payment method.

### 3. Business Insights

Read:

`docs/BUSINESS_INSIGHTS.md`

for the key findings and business interpretation of the dashboard.

---

## 👨‍💻 Project Author

**Yash Baghel**

B.Tech ECE Student | Aspiring Data Analyst

---

## ⭐ Portfolio Note

This project demonstrates an end-to-end data analytics workflow from raw transaction data to SQL-based business analysis, interactive Power BI reporting, and business-focused insights.
