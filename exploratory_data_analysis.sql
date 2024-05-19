-- Exploratory Data Analysis (EDA)
USE AmazonSales;

-- 1. What is the count of distinct cities in the dataset?
SELECT COUNT(DISTINCT city) AS distinct_city_count
FROM invoices; -- There are 3 distinct city in dataset.


-- 2. For each branch, what is the corresponding city?
SELECT branch, city
FROM invoices
GROUP BY branch, city
ORDER BY branch; -- Return branch in alph order and their corresponding city.


-- 3. What is the count of distinct product lines in the dataset?
SELECT COUNT(DISTINCT product_line) AS distinct_product_line_count
FROM invoices; -- There are 6 unique product line in the dataset.


-- 4. Which payment method occurs most frequently?
SELECT payment_method, COUNT(*) AS frequency
FROM invoices
GROUP BY payment_method
ORDER BY frequency DESC
LIMIT 1; -- Ewallet occurs most frequently i.e. 345 times.


-- 5. Which product line has the highest sales?
SELECT product_line, SUM(total) AS total_sales
FROM invoices
GROUP BY product_line
ORDER BY total_sales DESC
LIMIT 1; -- Food and beverages product line has the highest sale.


-- 6. How much revenue is generated each month?
SELECT month_name, SUM(total) AS revenue
FROM invoices
GROUP BY month_name
ORDER BY revenue DESC; -- Jan has a total of 116292.11 as highest revenue followed by mar and feb.


-- 7. In which month did the cost of goods sold reach its peak?
SELECT month_name, SUM(cogs) AS total_cogs
FROM invoices
GROUP BY month_name
ORDER BY total_cogs DESC
LIMIT 1; -- Jan is the month having peak cost of goods sold.


-- 8. Which product line generated the highest revenue?
SELECT product_line, SUM(total) AS revenue
FROM invoices
GROUP BY product_line
ORDER BY revenue DESC
LIMIT 1; -- Food and beverages is the product line that generated the highest revenue. 


-- 9. In which city was the highest revenue recorded?
SELECT city
FROM invoices
GROUP BY city
ORDER BY SUM(total) DESC
LIMIT 1; -- The highest revenue recorded in Naypyitaw city.


-- 10. Which product line incurred the highest Value Added Tax?
SELECT product_line, SUM(vat) as total_vat
FROM invoices
GROUP BY product_line
ORDER BY total_vat desc
LIMIT 1; -- Food and beverages is the product line incurred the highest VAT. 


-- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
SELECT product_line, 
CASE
	WHEN total_sales > avg_sales THEN "GOOD"
    ELSE "BAD"
END AS sales_condition
FROM (
	SELECT product_line, SUM(total) AS total_sales, AVG(SUM(total)) OVER() AS avg_sales
    FROM invoices
    GROUP BY product_line
) AS subquery; -- All product line is doing good except health and beuty.


-- 12. Identify the branch that exceeded the average number of products sold.
SELECT branch
FROM invoices
GROUP BY branch
HAVING AVG(quantity) > (SELECT AVG(quantity) FROM invoices); -- Branch C exceeded the average number of products sold.


-- 13. Which product line is most frequently associated with each gender?
SELECT gender, product_line, frequency
FROM (
    SELECT gender, product_line, COUNT(*) AS frequency,
	ROW_NUMBER() OVER (PARTITION BY Gender ORDER BY COUNT(*) DESC) AS num_row
    FROM invoices
    GROUP BY gender, product_line
) AS ranked
WHERE num_row = 1; -- Female accosiated with fashion accesories frequently while male with health and beauty productline.


-- 14. Calculate the average rating for each product line.
SELECT product_line, AVG(rating) AS avg_rating
FROM invoices
GROUP BY product_line
ORDER BY avg_rating DESC; -- Food and beverages is most rated follwed by fashion accessories
-- then home and lifestyle productline is least rated although not much difference.


-- 15. Count the sales occurrences for each time of day on every weekday.
SELECT day_name, time_of_day, COUNT(*) AS num_sales
FROM invoices
WHERE DAYOFWEEK(date) not in (1,7)
GROUP BY day_name, time_of_day
ORDER BY FIELD(day_name, 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'), num_sales DESC;
-- Most of the sales happend in afternoon at each weekday followed by evening then morning.


-- 16. Identify the customer type contributing the highest revenue.
SELECT customer_type, SUM(total) AS revenue
FROM invoices
GROUP BY customer_type
ORDER BY revenue DESC 
LIMIT 1; -- Customers who are member type contributing the highest revenue.


-- 17. Determine the city with the highest VAT percentage.
SELECT city, AVG(vat) avg_vat
FROM invoices
GROUP BY city
ORDER BY avg_vat DESC
LIMIT 1; -- Naypyitaw is the city with highest VAT percentage.


-- 18. Identify the customer type with the highest VAT payments.
SELECT customer_type, SUM(VAT) AS total_vat_payments
FROM invoices
GROUP BY customer_type
ORDER BY total_vat_payments DESC
LIMIT 1; -- Member type customer has highest VAT payments.


-- 19. What is the count of distinct customer types in the dataset?
SELECT COUNT(DISTINCT customer_type) AS customer_type_count
FROM invoices; -- There are two distinct customer type in dataset. 


-- 20. What is the count of distinct payment methods in the dataset?
SELECT COUNT(DISTINCT payment_method) AS distinct_payment_methods_count
FROM invoices; -- There are three distinct payment methods. 


-- 21. Which customer type occurs most frequently?
SELECT customer_type, count(*) AS occurance_frequency
FROM invoices
GROUP BY customer_type
ORDER BY frequency DESC
LIMIT 1; -- Member type customers occurs most frequently.


-- 22. Identify the customer type with the highest purchase frequency.
SELECT customer_type, COUNT(*) AS purchase_frequency
FROM invoices
GROUP BY customer_type
ORDER BY purchase_frequency DESC
LIMIT 1; -- Member type customers purchase most frequently.


-- 23. Determine the predominant gender among customers.
SELECT gender, COUNT(*) AS gender_count
FROM invoices
GROUP BY gender
ORDER BY gender_count DESC
LIMIT 1; -- Women are predominat customers among gender.


-- 24. Examine the distribution of genders within each branch.
SELECT branch, gender, COUNT(*) AS gender_count
FROM invoices
GROUP BY branch, gender
ORDER BY branch, gender_count DESC;
-- Male are dominant in branch A, B and women in branch C. 


-- 25. Identify the time of day when customers provide the most ratings.
SELECT time_of_day, COUNT(*) AS rating_count
FROM invoices
GROUP BY time_of_day
ORDER BY rating_count DESC
LIMIT 1; -- In afternoon customers provides most rating.


-- 26. Determine the time of day with the highest customer ratings for each branch.
SELECT branch,time_of_day, rating_count
FROM (
	SELECT branch, time_of_day, COUNT(*) AS rating_count,
	ROW_NUMBER() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS rn
    FROM invoices
    GROUP BY branch, time_of_day
) AS ratings_by_time
WHERE rn = 1
ORDER BY branch; -- Afternoon is the time of day with the highest customer ratings for each branch.


-- 27. Identify the day of the week with the highest average ratings.
SELECT day_name, AVG(rating) AS avg_rating
FROM invoices
GROUP BY day_name
ORDER BY avg_rating DESC
LIMIT 1; -- Monday is the day of the week with the highest average ratings.


-- 28. Determine the day of the week with the highest average ratings for each branch.
SELECT branch, day_name, avg_rating
FROM (
    SELECT branch, day_name, AVG(rating) AS avg_rating,
	ROW_NUMBER() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rn
    FROM invoices
    GROUP BY branch, day_name
) AS ranked_days
WHERE rn = 1; -- For branch A and C Friday is the day with highest average rating 
-- and for branch B its Monday.