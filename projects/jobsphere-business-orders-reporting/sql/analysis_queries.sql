-- Small retail order report (SQLite)
-- Sample data only; no customer names, contact details, or payment information.

CREATE TABLE IF NOT EXISTS orders (
    order_id TEXT PRIMARY KEY,
    order_date TEXT NOT NULL,
    region TEXT NOT NULL,
    sales_channel TEXT NOT NULL,
    category TEXT NOT NULL,
    product TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price_inr REAL NOT NULL,
    unit_cost_inr REAL NOT NULL,
    discount_pct REAL NOT NULL,
    order_status TEXT NOT NULL
);

-- Quick data check: row count, duplicate IDs, and missing fields.
SELECT COUNT(*) AS order_rows, COUNT(DISTINCT order_id) AS unique_orders
FROM orders;

SELECT * FROM orders
WHERE order_id IS NULL OR order_date IS NULL OR region IS NULL
   OR quantity IS NULL OR unit_price_inr IS NULL;

-- Delivered sales and gross profit by month.
SELECT strftime('%Y-%m', order_date) AS order_month,
       COUNT(*) AS delivered_orders,
       ROUND(SUM(quantity * unit_price_inr * (1 - discount_pct)), 2) AS net_sales_inr,
       ROUND(SUM(quantity * unit_price_inr * (1 - discount_pct)
                 - quantity * unit_cost_inr), 2) AS gross_profit_inr
FROM orders
WHERE order_status = 'Delivered'
GROUP BY strftime('%Y-%m', order_date)
ORDER BY order_month;

-- Compare category performance.
SELECT category,
       COUNT(*) AS delivered_orders,
       ROUND(SUM(quantity * unit_price_inr * (1 - discount_pct)), 2) AS net_sales_inr,
       ROUND(SUM(quantity * unit_price_inr * (1 - discount_pct)
                 - quantity * unit_cost_inr), 2) AS gross_profit_inr
FROM orders
WHERE order_status = 'Delivered'
GROUP BY category
ORDER BY net_sales_inr DESC;

-- Order status mix for the operations report.
SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Sales by region and channel.
SELECT region, sales_channel,
       COUNT(*) AS delivered_orders,
       ROUND(SUM(quantity * unit_price_inr * (1 - discount_pct)), 2) AS net_sales_inr
FROM orders
WHERE order_status = 'Delivered'
GROUP BY region, sales_channel
ORDER BY region, net_sales_inr DESC;
