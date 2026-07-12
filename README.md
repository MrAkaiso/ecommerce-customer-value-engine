# E-Commerce Customer Analytics Pipeline & Dashboard

## 📌 What This Project Does
A global e-commerce business was sitting on over 500,000 raw transaction logs but couldn't answer basic questions about their customers, like who their top buyers were or where they were losing money.

To fix this, I built an end-to-end data pipeline from scratch. It cleans up the raw sales data, calculates a custom customer segmentation model (RFM Analysis) using Python, stores everything cleanly in a MySQL relational database, and plugs into Power BI to show exactly where the business can save leaking revenue.

---

## 🛠️ Tech Stack
* **Data Cleaning & RFM Modeling:** Python (Pandas)
* **Database & Storage:** MySQL Workbench (Star Schema architecture)
* **Database Connector:** SQLAlchemy & PyMySQL
* **Dashboard & Visuals:** Power BI Desktop (DAX Calculations)

```text
        ┌────────────────────────┐      ┌────────────────────────┐      ┌────────────────────────┐
        │   1. Raw Excel Log     │ ───► │  2. Python Engine      │ ───► │ 3. MySQL Warehousing  │
        │ (500k chaotic sales)   │      │ (Cleaning & RFM Data)  │      │ (Structured Star Repo) │
        └────────────────────────┘      └────────────────────────┘      └────────────────────────┘
                                                                                    │
                                                                                    ▼
                                                                        ┌────────────────────────┐
                                                                        │  4. Power BI Front     │
                                                                        │ (Dynamic Executive UI) │
                                                                        └────────────────────────┘
💻 How I Built It
1. Cleaning & Processing the Data (Python)
Raw data is always messy. I used Pandas to handle several data quality issues:

Dropped any transactions that didn't have a valid CustomerID.

Excluded negative quantities and prices to remove canceled orders and product returns.

Used Regular Expressions (RegEx) to filter out manual administrative records like postage fees.

Aggregated the data by customer to calculate their Recency, Frequency, and Monetary (RFM) scores. I then grouped them into clear segments like Champions, At Risk, and Lost.

2. Designing the Database (MySQL)
Instead of just throwing a flat table into Power BI, I designed a professional Star Schema relational database to make sure queries run fast and efficiently.

Fact Table: fact_sales holds the core transaction data (quantities, dates, prices, and line totals).

Dimension Tables: dim_customers holds the customer profiles (including our newly engineered RFM segments and countries) and dim_products holds item descriptions.

Database Rules: Enforced strict PRIMARY KEY and FOREIGN KEY relationships so the tables link together perfectly without losing data integrity.

📈 What the Data Reveals (Business Insights)
I connected Power BI straight to the MySQL database and used DAX formulas to create dynamic business metrics. Here is what the numbers actually show:

Total Revenue: The business has generated a total of $8.76M in sales.

High Risk of Concentration: A massive 66.68% of total revenue comes entirely from our Champions segment. This is a big vulnerability—if even a few of these top buyers walk away, it hurts the company's bottom line significantly.

Leaking Revenue: There is $243.36K sitting in the At Risk and Can't Lose Them categories. This gives the marketing team an exact list of customers they need to target immediately with retention campaigns to keep them from churning.

🔧 Real-World Challenges I Solved
The Missing Location Bug: During the Python aggregation step, the Country column accidentally got dropped. I caught this when my SQL table showed NULL values. I patched it by extracting a clean customer-to-country mapping dataframe, merging it back into the final RFM table, and running a TRUNCATE script in SQL to reload the corrected data.

SQLAlchemy 2.0 Syntax Updates: Ran into minor compatibility issues with the latest database drivers, which I resolved by switching from standard connection strings to wrapping explicit execution protocols in text blocks.

📊 Live Dashboard Interface
