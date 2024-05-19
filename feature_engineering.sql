USE AmazonSales;


-- Adding a new column named timeofday to give insight of sales in the Morning, Afternoon and Evening.
ALTER TABLE invoices
ADD time_of_day VARCHAR(10);

-- Disabling safe update mode for current session
SET SQL_SAFE_UPDATES = 0; 

-- Updating column time of day
UPDATE invoices
SET time_of_day = 
CASE
    WHEN HOUR(time) >= 6 and HOUR(time) < 12 THEN 'Morning'
    WHEN HOUR(time) >= 12 AND HOUR(time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
END;


-- Adding a new column named dayname that contains the extracted days of the week. (Sun, Mon)
ALTER TABLE invoices
ADD day_name VARCHAR(3);

-- Updating column day name
UPDATE invoices
SET day_name = LEFT(DAYNAME(date), 3);


-- Adding a new column named monthname that contains the extracted months of the year. (Jan, Feb)
ALTER TABLE invoices
ADD month_name VARCHAR(3);

-- Updating column month name
UPDATE invoices
SET month_name = LEFT(MONTHNAME(date), 3);