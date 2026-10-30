-- DataPencil SQL 7 Days Challenge
-- Day 3: Mini Project 2
-- Project: Online Store Sales, Revenue and Payment Analysis
-- Database: sql7challenge
--
-- Run this script in MySQL Workbench.
-- It uses the existing tables: orders, order_items, products, payments.
-- Cancelled orders are excluded from sales/revenue calculations.

USE sql7challenge;

-- PART 1: SALES AND REVENUE ANALYSIS

-- 1. Total Sales Value
SELECT
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled';


-- 2. Revenue by Product Category
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status <> 'Cancelled'
GROUP BY p.category
ORDER BY revenue DESC;


-- 3. Top 10 Products by Revenue
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 10;


-- 4. Monthly Revenue
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;


-- 5. Revenue by Sales Channel
SELECT
    o.channel,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled'
GROUP BY o.channel
ORDER BY revenue DESC;


-- 6. Total Quantity Sold by Product Category
SELECT
    p.category,
    SUM(oi.quantity) AS total_quantity_sold
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status <> 'Cancelled'
GROUP BY p.category
ORDER BY total_quantity_sold DESC;


-- PART 2: PAYMENT SYSTEM ANALYSIS

-- 7. Number of Payments by Payment Method
SELECT
    payment_method,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_method
ORDER BY total_payments DESC;


-- 8. Payment Status Analysis
SELECT
    status,
    COUNT(*) AS total_payments
FROM payments
GROUP BY status
ORDER BY total_payments DESC;


-- 9. Average Payment Amount
SELECT
    ROUND(AVG(amount), 2) AS average_payment_amount
FROM payments;


-- 10. Total Payment Amount by Payment Method
SELECT
    payment_method,
    ROUND(SUM(amount), 2) AS total_payment_amount
FROM payments
GROUP BY payment_method
ORDER BY total_payment_amount DESC;


-- END OF DAY 3 MINI PROJECT
