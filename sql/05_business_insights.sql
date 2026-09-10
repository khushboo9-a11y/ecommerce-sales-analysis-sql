-- E-Commerce Sales Analysis
-- Business Insights


-- 1. Revenue by state
SELECT
    c.state,
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
GROUP BY c.state
ORDER BY total_revenue DESC;


-- 2. Orders by payment method
SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT order_id) * 100.0
        / (SELECT COUNT(DISTINCT order_id) FROM orders),
        2
    ) AS order_share_pct
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;


-- 3. Revenue by payment method
SELECT
    o.payment_method,
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
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.payment_method
ORDER BY total_revenue DESC;


-- 4. Cancelled and returned orders
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
WHERE o.status IN ('Cancelled', 'Returned')
GROUP BY o.status
ORDER BY associated_revenue DESC;


-- 5. Cancellation and return rate by category
SELECT
    p.category,
    COUNT(DISTINCT CASE
        WHEN o.status IN ('Cancelled', 'Returned')
        THEN o.order_id
    END) AS cancelled_returned_orders,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN o.status IN ('Cancelled', 'Returned')
            THEN o.order_id
        END) * 100.0
        / COUNT(DISTINCT o.order_id),
        2
    ) AS issue_rate_pct
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY issue_rate_pct DESC;


-- 6. Customer order frequency
SELECT
    order_count,
    COUNT(*) AS customers
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) t
GROUP BY order_count
ORDER BY order_count;


-- 7. Top customers by revenue and AOV
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
ORDER BY total_revenue DESC
LIMIT 10;
