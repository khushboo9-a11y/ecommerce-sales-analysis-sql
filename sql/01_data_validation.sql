-- E-Commerce Sales Analysis
-- Data Validation

-- 1. Total customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 2. Total products
SELECT COUNT(*) AS total_products
FROM products;

-- 3. Total orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 4. Total order items
SELECT COUNT(*) AS total_order_items
FROM order_items;

-- 5. Duplicate customer IDs
SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 6. Duplicate product IDs
SELECT product_id, COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- 7. Duplicate order IDs
SELECT order_id, COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 8. Duplicate order item IDs
SELECT order_item_id, COUNT(*) AS duplicate_count
FROM order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;
