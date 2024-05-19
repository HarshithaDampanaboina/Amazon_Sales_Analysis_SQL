-- Building a database
CREATE DATABASE IF NOT EXISTS AmazonSales;

-- selecting a database to use
USE AmazonSales;

-- Creating a table 
CREATE TABLE invoices (
    invoice_id VARCHAR(30) PRIMARY KEY,
    branch VARCHAR(5),
    city VARCHAR(30),
    customer_type VARCHAR(30),
    gender VARCHAR(10),
    product_line VARCHAR(100),
    unit_price DECIMAL(10, 2),
    quantity INT,
    vat FLOAT(6, 4),
    total DECIMAL(10, 2),
    date DATE,
    time TIME,
    payment_method VARCHAR(20),
    cogs DECIMAL(10, 2),
    gross_margin_percentage FLOAT(11, 9),
    gross_income DECIMAL(10, 2),
    rating FLOAT(3, 1)
);

-- followed by importing data from .csv with mysql import wizard
-- alternately can import data with sql query by enabling local data loading
LOAD DATA LOCAL INFILE '/Users/prince/Downloads/Amazon.csv'
INTO TABLE invoices
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Checking import results
SELECT * FROM invoices;

--  Columns and their null values count
SELECT COLUMN_NAME,
(SELECT count(*) FROM AmazonSales.invoices WHERE COLUMN_NAME IS NULL) AS num_null
FROM information_schema.columns
WHERE TABLE_SCHEMA = 'AmazonSales'
AND TABLE_NAME = 'invoices'
GROUP BY COLUMN_NAME;