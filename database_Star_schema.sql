-- 1. Create a dedicated database for our retail analytics project
CREATE DATABASE IF NOT EXISTS retail_analytics;
USE retail_analytics;

-- 2. Create the Customer Dimension table to store demographic and RFM segments
CREATE TABLE dim_customers (
    CustomerID INT PRIMARY KEY,
    Country VARCHAR(100),
    Recency INT,
    Frequency INT,
    Monetary DECIMAL(15,2),
    R_Score INT,
    F_Score INT,
    M_Score INT,
    RFM_Cell VARCHAR(3),
    Segment VARCHAR(50)
);

-- 3. Create the Product Dimension table to store unique inventory items
CREATE TABLE dim_products (
    StockCode VARCHAR(50) PRIMARY KEY,
    Description VARCHAR(255)
);

-- 4. Create the Fact table to record individual sales transactions
-- Note the FOREIGN KEY constraints that link this table back to our dimensions
CREATE TABLE fact_sales (
    InvoiceLineID INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceNo VARCHAR(50),
    StockCode VARCHAR(50),
    CustomerID INT,
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    LineTotal DECIMAL(15,2),
    FOREIGN KEY (CustomerID) REFERENCES dim_customers(CustomerID),
    FOREIGN KEY (StockCode) REFERENCES dim_products(StockCode)
);

USE retail_analytics;

-- 1. Disable constraints so MySQL allows tables to be cleared out
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Clear out all rows and completely reset any counter indexes back to 1
TRUNCATE TABLE fact_sales;
TRUNCATE TABLE dim_products;
TRUNCATE TABLE dim_customers;

-- 3. Re-enable safety constraints to keep data safe
SET FOREIGN_KEY_CHECKS = 1;