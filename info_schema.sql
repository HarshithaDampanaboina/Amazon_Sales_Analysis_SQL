-- information schema
SELECT * FROM information_schema.tables WHERE table_schema = 'AmazonSales';

-- List all tables in a database:
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'AmazonSales';

-- 'invoice' table shape
select
(select count(*) from invoices) as num_rows,
(SELECT COUNT(*) FROM information_schema.columns 
WHERE table_name = 'invoices') as num_cols;

-- List all columns and type in a specific table:
SELECT column_name, column_type
FROM information_schema.columns
WHERE table_schema = 'AmazonSales'
AND table_name = 'invoices';

-- numerical and categorical variables
SELECT 
SUM(CASE WHEN data_type IN ('int', 'decimal', 'float') THEN 1 ELSE 0 END) AS num_numerical,
SUM(CASE WHEN data_type IN ('varchar') THEN 1 ELSE 0 END) AS num_categorical
FROM information_schema.columns
WHERE table_schema = 'AmazonSales'
AND table_name = 'invoices';