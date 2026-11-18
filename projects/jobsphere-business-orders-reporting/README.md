# Retail Orders Reporting Project

A small, practical reporting exercise built with Excel and SQL. It looks at order activity, delivered sales, gross profit, product categories, regions, and sales channels.

## What is included

- data/orders_sample.csv: 180 fictional order records dated January to October 2026.
- excel/Business_Orders_Reporting.xlsx: an Excel dashboard and the order-level data behind it.
- sql/analysis_queries.sql: SQLite table setup, simple data checks, and reporting queries.
- insights.md: a short readout of the results.

## How the report is calculated

Only orders marked Delivered count toward sales, cost, and gross profit. Net sales are quantity multiplied by unit price after discount. Gross profit is net sales less unit cost. Pending and cancelled orders remain in the status count but do not add to delivered sales.

## Try it

1. Open the workbook and start on the Dashboard tab.
2. Review the Orders tab to see how the row-level values feed the summary.
3. To run the SQL, create a SQLite database, import the CSV into a table named orders, and run sql/analysis_queries.sql.

## Note

The records are made up for practice. They do not represent a real company or real customers. The analysis uses ordinary Excel formulas and SQL; it does not use AI or machine learning.
