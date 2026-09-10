-- E-Commerce Sales Analysis
-- Product & Category Analysis


-- 1. Top 10 products by revenue
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ),
        2
    ) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;


-- 2. Top 10 products by units sold
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_units_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_units_sold DESC
LIMIT 10;


-- 3. Revenue by category
SELECT
    p.category,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ),
        2
    ) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


-- 4. Gross profit by category
SELECT
    p.category,
    ROUND(
        SUM(
            oi.quantity *
            (
                oi.unit_price * (1 - oi.discount_pct / 100)
                - p.cost_price
            )
        ),
        2
    ) AS gross_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY gross_profit DESC;


-- 5. Profit margin by category
SELECT
    p.category,
    ROUND(
        SUM(
            oi.quantity *
            (
                oi.unit_price * (1 - oi.discount_pct / 100)
                - p.cost_price
            )
        ) * 100.0
        /
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ),
        2
    ) AS profit_margin_pct
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY profit_margin_pct DESC;


-- 6. Revenue by subcategory
SELECT
    p.category,
    p.subcategory,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ),
        2
    ) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category, p.subcategory
ORDER BY total_revenue DESC;


-- 7. Top 10 products by gross profit
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(
        SUM(
            oi.quantity *
            (
                oi.unit_price * (1 - oi.discount_pct / 100)
                - p.cost_price
            )
        ),
        2
    ) AS gross_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY gross_profit DESC
LIMIT 10;


-- 8. Top 10 products by profit margin
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(
        SUM(
            oi.quantity *
            (
                oi.unit_price * (1 - oi.discount_pct / 100)
                - p.cost_price
            )
        ),
        2
    ) AS gross_profit,
    ROUND(
        SUM(
            oi.quantity *
            (
                oi.unit_price * (1 - oi.discount_pct / 100)
                - p.cost_price
            )
        ) * 100.0
        /
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_pct / 100)
        ),
        2
    ) AS profit_margin_pct
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY profit_margin_pct DESC
LIMIT 10;
