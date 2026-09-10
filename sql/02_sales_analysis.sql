-- E-Commerce Sales Analysis
-- Sales Analysis

-- 1. Total discounted revenue
SELECT
    ROUND(
        SUM(
            quantity * unit_price
            * (1 - discount_pct / 100)
        ),
        2
    ) AS total_discounted_revenue
FROM order_items;


-- 2. Monthly discounted revenue
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ),
        2
    ) AS monthly_discounted_revenue
FROM order_items oi
JOIN orders o
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY order_month;


-- 3. Month-over-month revenue growth
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
),
revenue_with_previous AS (
    SELECT
        order_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY order_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    order_month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        (revenue - previous_month_revenue)
        * 100.0 / previous_month_revenue,
        2
    ) AS mom_growth_pct
FROM revenue_with_previous
ORDER BY order_month;


-- 4. Overall Average Order Value (AOV)
SELECT
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;


-- 5. Revenue by order status
SELECT
    o.status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ),
        2
    ) AS associated_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.status
ORDER BY associated_revenue DESC;
