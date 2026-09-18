# Business Insights — E-Commerce Sales & Customer Analytics

## Executive Summary

The Power BI dashboard provides a business view of e-commerce sales, customers, products, regions, discounts, payment methods, delivery performance and returns.

> **Note:** The figures below are based on the current dashboard view and are intended as portfolio-level observations. They describe patterns in this dataset and should not be treated as causal conclusions.

---

## 1. Overall Business Performance

- **Total Revenue:** 5.87M
- **Total Orders:** 35K
- **Total Customers:** 7,903
- **Average Order Value:** 170.01
- **Total Shipping Cost:** 212.25K

### Business Interpretation

The dashboard indicates a sizable transaction base with revenue distributed across multiple product categories and regions. Average Order Value can be used as a baseline KPI for monitoring customer basket size and sales performance.

---

## 2. Category Performance

The category dashboard shows the following revenue pattern:

- **Electronics:** approximately 3.3M
- **Home:** approximately 1.1M
- **Sports:** approximately 0.6M
- **Fashion:** approximately 0.5M
- **Beauty:** approximately 0.2M
- **Toys:** approximately 0.1M
- **Grocery:** approximately 0.1M

### Business Interpretation

Electronics contributes the largest share of category revenue in the current dashboard. This makes Electronics an important category for revenue monitoring, product-level analysis and inventory planning.

---

## 3. Regional Performance

Revenue by region is approximately:

| Region | Revenue |
|---|---:|
| South | 1.30M |
| North | 1.26M |
| West | 1.19M |
| East | 1.18M |
| Central | 0.94M |

### Business Interpretation

South has the highest displayed regional revenue, while Central has the lowest among the five regions. Regional performance can therefore be monitored separately for sales planning, marketing allocation and operational analysis.

---

## 4. Product Performance

The Customer & Product dashboard includes a **Top 10 Products by Revenue** view.

The leading displayed products are:

- P217031
- P242326
- P224743
- P216077
- P225406
- P204291
- P208695
- P236988
- P247897
- P218759

### Business Interpretation

The top-product view helps identify products contributing most strongly to revenue. These products can be investigated further using order volume, quantity sold, return rate and profitability to avoid relying on revenue alone.

---

## 5. Customer Behavior

The dashboard shows:

- **Total Customers:** 7,903
- **Repeat Customers:** 7,428
- **Average Customer Spend:** 742.16

The customer spending visualization also segments customers into Low Value, Medium Value and High Value groups.

### Business Interpretation

The dashboard shows a large repeat-customer base in this dataset. Customer segmentation can be used to analyze purchasing behavior and identify different customer groups for retention and engagement analysis.

---

## 6. Discount Analysis

Revenue by discount band is approximately:

| Discount Band | Revenue |
|---|---:|
| 0–10% | 4.4M |
| 10–20% | 1.1M |
| 20–30% | 0.3M |
| 30%+ | 0.1M |

### Business Interpretation

Most displayed revenue comes from orders in the 0–10% discount band. Higher discount bands contribute progressively less revenue in this dataset.

This observation describes the dataset; it does **not** establish that lower discounts cause higher revenue. A controlled analysis would be required to evaluate causality.

---

## 7. Return Rate by Category

The dashboard displays category-level return rates:

| Category | Return Rate |
|---|---:|
| Fashion | 8.28% |
| Electronics | 7.30% |
| Home | 5.65% |
| Toys | 4.94% |
| Sports | 4.94% |
| Beauty | 3.78% |
| Grocery | 1.31% |

### Business Interpretation

Fashion has the highest displayed return rate, while Grocery has the lowest. High-return categories can be investigated further by product, customer segment, payment method and delivery performance.

---

## 8. Return Rate by Payment Method

The dashboard compares return rates across:

- PayPal
- Debit Card
- Credit Card
- UPI
- Wallet
- COD

The displayed return rates are all relatively close, with the highest bars around the upper-5% range and COD around the low-5% range.

### Business Interpretation

Payment method alone does not provide enough evidence to explain why an order is returned. It is better analyzed together with category, region, product and customer behavior.

---

## 9. Monthly Revenue Trend

The monthly revenue chart shows revenue generally fluctuating around the 0.2M–0.28M range for much of the displayed period, with a final displayed value of approximately **0.09M**.

### Business Interpretation

The monthly trend can be used to monitor seasonality, unusual changes and periods requiring deeper investigation. The sharp final-month drop should be checked against data completeness, reporting-period boundaries and actual sales activity before drawing a business conclusion.

---

## 10. SQL Analysis Capabilities

The project contains 48 business-focused SQL queries covering:

- Revenue and order KPIs
- Product and category analysis
- Customer spending and repeat purchases
- Customer segmentation
- Regional analysis
- Discount-band analysis
- Monthly revenue and MoM growth
- Delivery performance
- Return rates
- Payment methods
- CTEs and subqueries
- JOINs
- Ranking with RANK() and ROW_NUMBER()
- LAG() for time-series comparison
- Cumulative revenue

---

## 11. Recommended Business Actions for Further Analysis

These are **analysis directions**, not conclusions about the business:

1. Investigate high-return products within Fashion and Electronics.
2. Compare return rates with delivery-speed categories.
3. Analyze whether high-revenue products also generate strong calculated profit.
4. Examine regional differences in return rates and average order value.
5. Analyze customer segments by order frequency, total spend and recency.
6. Investigate the final-month revenue drop for possible data or business causes.
7. Compare discount bands using both revenue and calculated profit rather than revenue alone.

---

## Conclusion

The dashboard provides a consolidated view of sales, customers, products, regions, discounts, delivery and returns. The combination of **SQL business analysis + Power BI visualization + written business interpretation** makes the project suitable for demonstrating practical Data Analyst skills.
