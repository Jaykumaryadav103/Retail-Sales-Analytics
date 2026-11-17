-- Online Store Sales Analysis | SQLite
-- All records are fictional synthetic data created for this portfolio project.
-- Revenue recognizes delivered orders only; returned/cancelled orders contribute zero realized revenue.

-- 1. Overall performance and order quality
SELECT
  COUNT(*) AS total_orders,
  SUM(CASE WHEN order_status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders,
  ROUND(100.0 * SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*), 2) AS return_rate_pct,
  ROUND(SUM(CASE WHEN order_status = 'Delivered' THEN quantity * unit_price_inr * (1 - discount_pct) ELSE 0 END), 2) AS realized_revenue_inr
FROM orders;

-- 2. Monthly realized revenue
SELECT substr(order_date, 1, 7) AS month,
       ROUND(SUM(CASE WHEN order_status = 'Delivered' THEN quantity * unit_price_inr * (1 - discount_pct) ELSE 0 END), 2) AS realized_revenue_inr
FROM orders
GROUP BY month
ORDER BY month;

-- 3. Revenue and order mix by product category
SELECT category,
       COUNT(*) AS orders,
       ROUND(SUM(CASE WHEN order_status = 'Delivered' THEN quantity * unit_price_inr * (1 - discount_pct) ELSE 0 END), 2) AS realized_revenue_inr,
       ROUND(100.0 * SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*), 2) AS return_rate_pct
FROM orders
GROUP BY category
ORDER BY realized_revenue_inr DESC;

-- 4. City performance (delivered revenue)
SELECT city,
       COUNT(*) AS total_orders,
       ROUND(SUM(CASE WHEN order_status = 'Delivered' THEN quantity * unit_price_inr * (1 - discount_pct) ELSE 0 END), 2) AS realized_revenue_inr
FROM orders
GROUP BY city
ORDER BY realized_revenue_inr DESC;

-- 5. Monthly order-status breakdown for operations follow-up
SELECT substr(order_date, 1, 7) AS month, order_status, COUNT(*) AS orders
FROM orders
GROUP BY month, order_status
ORDER BY month, order_status;
