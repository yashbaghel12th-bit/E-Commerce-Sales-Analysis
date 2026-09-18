USE ecommerce;
-- =========================================================
-- E-COMMERCE SALES & CUSTOMER ANALYSIS
-- 48 BUSINESS-FOCUSED SQL QUERIES
-- =========================================================
-- Q1. What are the overall sales, order volume, quantity sold, and calculated profit?
SELECT
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(total_amount * profit_margin / 100), 2) AS total_profit
FROM ecommerce_sales;
-- Q2. What is the average revenue generated per order?
SELECT
    ROUND(SUM(total_amount) / COUNT(order_id), 2) AS average_order_value
FROM ecommerce_sales;
-- Q3. What is the average quantity purchased per order?
SELECT
    ROUND(AVG(quantity), 2) AS average_quantity_per_order
FROM ecommerce_sales;
-- Q4. What percentage of orders are returned?
SELECT
    COUNT(CASE WHEN returned = 'Yes' THEN 1 END) AS returned_orders,
    COUNT(order_id) AS total_orders,
    ROUND(
        COUNT(CASE WHEN returned = 'Yes' THEN 1 END) * 100.0
        / COUNT(order_id), 2
    ) AS return_rate_percentage
FROM ecommerce_sales;
-- Q5. How does sales performance vary across product categories?
SELECT
    category,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(total_amount * profit_margin / 100), 2) AS total_profit
FROM ecommerce_sales
GROUP BY category
ORDER BY total_revenue DESC;
-- Q6. Which product categories have the highest calculated profit margin?
SELECT
    category,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(total_amount * profit_margin / 100), 2) AS total_profit,
    ROUND(
        SUM(total_amount * profit_margin / 100)
        / SUM(total_amount) * 100, 2
    ) AS profit_margin_percentage
FROM ecommerce_sales
GROUP BY category
ORDER BY profit_margin_percentage DESC;
-- Q7. Which categories have a calculated profit margin above 10%?
SELECT
    category,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(total_amount * profit_margin / 100), 2) AS total_profit,
    ROUND(
        SUM(total_amount * profit_margin / 100)
        / SUM(total_amount) * 100, 2
    ) AS profit_margin_percentage
FROM ecommerce_sales
GROUP BY category
HAVING profit_margin_percentage > 10
ORDER BY profit_margin_percentage DESC;
-- Q8. Which regions generate the highest revenue and profit?
SELECT
    region,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(total_amount * profit_margin / 100), 2) AS total_profit
FROM ecommerce_sales
GROUP BY region
ORDER BY total_revenue DESC;
-- Q9. Which regions have the highest order return rates?
SELECT
    region,
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN returned = 'Yes' THEN 1 END) AS returned_orders,
    ROUND(
        COUNT(CASE WHEN returned = 'Yes' THEN 1 END) * 100.0
        / COUNT(order_id), 2
    ) AS return_rate
FROM ecommerce_sales
GROUP BY region
ORDER BY return_rate DESC;
-- Q10. Which 10 products generate the highest revenue?
SELECT
    product_id,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM ecommerce_sales
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;
-- Q11. Which 10 products have the highest calculated profit?
SELECT
    product_id,
    ROUND(SUM(total_amount * profit_margin / 100), 2) AS total_profit
FROM ecommerce_sales
GROUP BY product_id
ORDER BY total_profit DESC
LIMIT 10;
-- Q12. Which products generate above-average revenue but below-average calculated profit?
SELECT
    product_id,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(total_amount * profit_margin / 100), 2) AS total_profit
FROM ecommerce_sales
GROUP BY product_id
HAVING total_revenue > (
    SELECT AVG(product_revenue)
    FROM (
        SELECT SUM(total_amount) AS product_revenue
        FROM ecommerce_sales
        GROUP BY product_id
    ) AS product_sales
)
AND total_profit < (
    SELECT AVG(product_profit)
    FROM (
        SELECT SUM(total_amount * profit_margin / 100) AS product_profit
        FROM ecommerce_sales
        GROUP BY product_id
    ) AS product_profits
)
ORDER BY total_revenue DESC;
-- Q13. Who are the top 10 customers by total spending?
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_spent
FROM ecommerce_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;
-- Q14. Which customers are repeat purchasers?
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_spent
FROM ecommerce_sales
GROUP BY customer_id
HAVING total_orders > 1
ORDER BY total_orders DESC;
-- Q15. How can customers be segmented based on their total spending?
SELECT
    customer_id,
    ROUND(SUM(total_amount), 2) AS total_spent,
    CASE
        WHEN SUM(total_amount) >= 5000 THEN 'High Value'
        WHEN SUM(total_amount) >= 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM ecommerce_sales
GROUP BY customer_id
ORDER BY total_spent DESC;
-- Q16. How does revenue vary across different discount bands?
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN '0-10%'
        WHEN discount <= 0.20 THEN '10-20%'
        ELSE 'Above 20%'
    END AS discount_band,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(total_amount * profit_margin / 100), 2) AS total_profit
FROM ecommerce_sales
GROUP BY discount_band
ORDER BY total_revenue DESC;
-- Q17. How does the recorded profit margin vary across discount bands?
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN '0-10%'
        WHEN discount <= 0.20 THEN '10-20%'
        ELSE 'Above 20%'
    END AS discount_band,
    ROUND(AVG(profit_margin), 2) AS average_profit_margin,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM ecommerce_sales
GROUP BY discount_band
ORDER BY average_profit_margin DESC;
-- Q18. How do revenue, orders, and profit vary by month?
-- Note: order_date is stored as DD-MM-YYYY text.
SELECT
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_year,
    MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(total_amount * profit_margin / 100), 2) AS total_profit
FROM ecommerce_sales
GROUP BY
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')),
    MONTH(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY order_year, order_month;
-- Q19. What is the month-over-month revenue growth?
WITH monthly_sales AS (
    SELECT
        YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_year,
        MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month,
        SUM(total_amount) AS monthly_revenue
    FROM ecommerce_sales
    GROUP BY
        YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')),
        MONTH(STR_TO_DATE(order_date, '%d-%m-%Y'))
)
SELECT
    order_year,
    order_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        LAG(monthly_revenue) OVER (
            ORDER BY order_year, order_month
        ), 2
    ) AS previous_month_revenue,
    ROUND(
        (monthly_revenue -
            LAG(monthly_revenue) OVER (
                ORDER BY order_year, order_month
            )) * 100.0
        / LAG(monthly_revenue) OVER (
            ORDER BY order_year, order_month
        ), 2
    ) AS growth_percentage
FROM monthly_sales
ORDER BY order_year, order_month;
-- Q20. Which regions have the fastest average delivery times?
SELECT
    region,
    ROUND(AVG(delivery_time_days), 2) AS average_delivery_days
FROM ecommerce_sales
GROUP BY region
ORDER BY average_delivery_days;
-- Q21. Does delivery speed have an association with order returns?
SELECT
    CASE
        WHEN delivery_time_days <= 3 THEN 'Fast Delivery'
        WHEN delivery_time_days <= 7 THEN 'Standard Delivery'
        ELSE 'Slow Delivery'
    END AS delivery_category,
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN returned = 'Yes' THEN 1 END) AS returned_orders,
    ROUND(
        COUNT(CASE WHEN returned = 'Yes' THEN 1 END) * 100.0
        / COUNT(order_id), 2
    ) AS return_rate
FROM ecommerce_sales
GROUP BY delivery_category
ORDER BY return_rate DESC;
-- Q22. Which payment methods generate the highest revenue and average order value?
SELECT
    payment_method,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM ecommerce_sales
GROUP BY payment_method
ORDER BY total_revenue DESC;


-- Q23. What is the revenue rank of each product?
SELECT
    product_id,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(total_amount) DESC
    ) AS revenue_rank
FROM ecommerce_sales
GROUP BY product_id;
-- Q24. What is each product's revenue rank within its category?
WITH product_sales AS (
    SELECT
        category,
        product_id,
        SUM(total_amount) AS total_revenue
    FROM ecommerce_sales
    GROUP BY category, product_id
)
SELECT
    category,
    product_id,
    ROUND(total_revenue, 2) AS total_revenue,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_revenue DESC
    ) AS category_rank
FROM product_sales;
-- Q25. What is the cumulative revenue generated over the analysis period?
WITH monthly_sales AS (
    SELECT
        YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_year,
        MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month,
        SUM(total_amount) AS monthly_revenue
    FROM ecommerce_sales
    GROUP BY
        YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')),
        MONTH(STR_TO_DATE(order_date, '%d-%m-%Y'))
)
SELECT
    order_year,
    order_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        SUM(monthly_revenue) OVER (
            ORDER BY order_year, order_month
        ), 2
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY order_year, order_month;


-- Q26. Which customers spend more than the average customer?
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM ecommerce_sales
    GROUP BY customer_id
)
SELECT
    customer_id,
    ROUND(total_spent, 2) AS total_spent
FROM customer_sales
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_sales
)
ORDER BY total_spent DESC;


-- Q27. Which customers have the highest order frequency?
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    RANK() OVER (
        ORDER BY COUNT(order_id) DESC
    ) AS order_rank
FROM ecommerce_sales
GROUP BY customer_id;


-- Q28. How can customer-level purchasing activity be summarized?
CREATE TABLE customer_summary AS
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_spent
FROM ecommerce_sales
GROUP BY customer_id;
-- Q29. How can product-level sales performance be summarized?
CREATE TABLE product_summary AS
SELECT
    product_id,
    category,
    SUM(quantity) AS total_quantity,
    SUM(total_amount) AS total_revenue
FROM ecommerce_sales
GROUP BY product_id, category;


-- Q30. How can customer-level summaries be joined with transaction data?
SELECT
    s.order_id,
    s.customer_id,
    c.total_orders,
    c.total_spent,
    s.total_amount
FROM ecommerce_sales s
INNER JOIN customer_summary c
    ON s.customer_id = c.customer_id;


-- Q31. How can product-level summaries be joined with transaction data?
SELECT
    s.order_id,
    s.product_id,
    p.category,
    p.total_quantity,
    p.total_revenue,
    s.total_amount
FROM ecommerce_sales s
LEFT JOIN product_summary p
    ON s.product_id = p.product_id;
-- Q32. What are the top 3 revenue-generating products within each category?
WITH product_sales AS (
    SELECT
        category,
        product_id,
        SUM(total_amount) AS total_revenue
    FROM ecommerce_sales
    GROUP BY category, product_id
),
ranked_products AS (
    SELECT
        category,
        product_id,
        total_revenue,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_revenue DESC
        ) AS category_rank
    FROM product_sales
)
SELECT
    category,
    product_id,
    ROUND(total_revenue, 2) AS total_revenue,
    category_rank
FROM ranked_products
WHERE category_rank <= 3
ORDER BY category, category_rank;
-- Q33. How can exactly three top products be selected from each category?
WITH product_sales AS (
    SELECT
        category,
        product_id,
        SUM(total_amount) AS total_revenue
    FROM ecommerce_sales
    GROUP BY category, product_id
),
ranked_products AS (
    SELECT
        category,
        product_id,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_revenue DESC
        ) AS product_number
    FROM product_sales
)
SELECT
    category,
    product_id,
    ROUND(total_revenue, 2) AS total_revenue,
    product_number
FROM ranked_products
WHERE product_number <= 3
ORDER BY category, product_number;
-- Q34. What percentage of total revenue does each category contribute?
SELECT
    category,
    ROUND(SUM(total_amount), 2) AS category_revenue,
    ROUND(
        SUM(total_amount) * 100.0 /
        (SELECT SUM(total_amount)
         FROM ecommerce_sales),
        2
    ) AS revenue_contribution_percentage
FROM ecommerce_sales
GROUP BY category
ORDER BY revenue_contribution_percentage DESC;
-- Q35. Which categories perform above or below the average category revenue?
WITH category_sales AS (
    SELECT
        category,
        SUM(total_amount) AS total_revenue
    FROM ecommerce_sales
    GROUP BY category
)
SELECT
    category,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        (SELECT AVG(total_revenue)
         FROM category_sales), 2
    ) AS average_category_revenue,
    CASE
        WHEN total_revenue > (
            SELECT AVG(total_revenue)
            FROM category_sales
        )
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS performance
FROM category_sales
ORDER BY total_revenue DESC;
-- Q36. Which customers have the highest total number of orders?
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_spent
FROM ecommerce_sales
GROUP BY customer_id
ORDER BY total_orders DESC, total_spent DESC
LIMIT 10;
-- Q37. What is the spending rank of each customer?
SELECT
    customer_id,
    ROUND(SUM(total_amount), 2) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(total_amount) DESC
    ) AS spending_rank
FROM ecommerce_sales
GROUP BY customer_id;
-- Q38. What percentage of customers are repeat purchasers?
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders
    FROM ecommerce_sales
    GROUP BY customer_id
)
SELECT
    COUNT(CASE WHEN total_orders > 1 THEN 1 END) AS repeat_customers,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(CASE WHEN total_orders > 1 THEN 1 END) * 100.0
        / COUNT(*), 2
    ) AS repeat_customer_percentage
FROM customer_orders;
-- Q39. Which product categories have the highest return rates?
SELECT
    category,
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN returned = 'Yes' THEN 1 END) AS returned_orders,
    ROUND(
        COUNT(CASE WHEN returned = 'Yes' THEN 1 END) * 100.0
        / COUNT(order_id), 2
    ) AS return_rate
FROM ecommerce_sales
GROUP BY category
ORDER BY return_rate DESC;
-- Q40. Which products have the highest return rates among products with at least 10 orders?
SELECT
    product_id,
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN returned = 'Yes' THEN 1 END) AS returned_orders,
    ROUND(
        COUNT(CASE WHEN returned = 'Yes' THEN 1 END) * 100.0
        / COUNT(order_id), 2
    ) AS return_rate
FROM ecommerce_sales
GROUP BY product_id
HAVING COUNT(order_id) >= 10
ORDER BY return_rate DESC;
-- Q41. Which payment methods have the highest return rates?
SELECT
    payment_method,
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN returned = 'Yes' THEN 1 END) AS returned_orders,
    ROUND(
        COUNT(CASE WHEN returned = 'Yes' THEN 1 END) * 100.0
        / COUNT(order_id), 2
    ) AS return_rate
FROM ecommerce_sales
GROUP BY payment_method
ORDER BY return_rate DESC;
-- Q42. How does order volume and revenue vary by delivery-speed category?
SELECT
    CASE
        WHEN delivery_time_days <= 3 THEN 'Fast'
        WHEN delivery_time_days <= 7 THEN 'Standard'
        ELSE 'Slow'
    END AS delivery_category,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(delivery_time_days), 2) AS average_delivery_days,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM ecommerce_sales
GROUP BY delivery_category
ORDER BY average_delivery_days;
-- Q43. Which delivery-speed category has the highest return rate?
SELECT
    CASE
        WHEN delivery_time_days <= 3 THEN 'Fast'
        WHEN delivery_time_days <= 7 THEN 'Standard'
        ELSE 'Slow'
    END AS delivery_category,
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN returned = 'Yes' THEN 1 END) AS returned_orders,
    ROUND(
        COUNT(CASE WHEN returned = 'Yes' THEN 1 END) * 100.0
        / COUNT(order_id), 2
    ) AS return_rate
FROM ecommerce_sales
GROUP BY delivery_category
ORDER BY return_rate DESC;
-- Q44. Which categories generate the highest calculated profit?
SELECT
    category,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(total_amount * profit_margin / 100), 2) AS total_profit,
    ROUND(
        SUM(total_amount * profit_margin / 100) * 100.0
        / SUM(total_amount),
        2
    ) AS profit_margin
FROM ecommerce_sales
GROUP BY category
ORDER BY total_profit DESC;
-- Q45. How does recorded profit margin vary across discount bands?
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN '0-10%'
        WHEN discount <= 0.20 THEN '10-20%'
        ELSE 'Above 20%'
    END AS discount_band,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS revenue,
    ROUND(
        SUM(total_amount * profit_margin / 100),
        2
    ) AS profit,
    ROUND(AVG(profit_margin), 2) AS average_profit_margin
FROM ecommerce_sales
GROUP BY discount_band
ORDER BY average_profit_margin DESC;
-- Q46. What is the monthly revenue and order performance across the analysis period?
SELECT
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_year,
    MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(
        SUM(total_amount * profit_margin / 100),
        2
    ) AS total_profit
FROM ecommerce_sales
GROUP BY
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')),
    MONTH(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY order_year, order_month;
-- Q47. What is the cumulative revenue trend over time?
WITH monthly_sales AS (
    SELECT
        YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_year,
        MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month,
        SUM(total_amount) AS monthly_revenue
    FROM ecommerce_sales
    GROUP BY
        YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')),
        MONTH(STR_TO_DATE(order_date, '%d-%m-%Y'))
)
SELECT
    order_year,
    order_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        SUM(monthly_revenue) OVER (
            ORDER BY order_year, order_month
        ), 2
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY order_year, order_month;
-- Q48. What are the key executive-level sales, customer, product,delivery, and return KPIs?
SELECT
    COUNT(order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT product_id) AS total_products,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value,
    ROUND(AVG(delivery_time_days), 2) AS average_delivery_days,
    ROUND(
        COUNT(CASE WHEN returned = 'Yes' THEN 1 END)
        * 100.0 / COUNT(order_id),
        2
    ) AS return_rate
FROM ecommerce_sales;