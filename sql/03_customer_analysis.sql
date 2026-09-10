-- E-Commerce Sales Analysis
-- Customer Analysis


-- 1. Top 10 customers by revenue
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ),
        2
    ) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 2. Repeat vs one-time customers
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customers
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) t
GROUP BY customer_type;


-- 3. Customers with no purchases
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.state,
    c.signup_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.signup_date;


-- 4. Customer segmentation by revenue
SELECT
    CASE
        WHEN total_revenue >= 700000 THEN 'High Value'
        WHEN total_revenue >= 500000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(total_revenue), 2) AS total_segment_revenue,
    ROUND(AVG(total_revenue), 2) AS average_customer_revenue
FROM (
    SELECT
        o.customer_id,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
) t
GROUP BY customer_segment
ORDER BY average_customer_revenue DESC;


-- 5. Top customers by Average Order Value
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ),
        2
    ) AS total_revenue,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY average_order_value DESC
LIMIT 10;
