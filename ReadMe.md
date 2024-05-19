# Amazon Sales Analysis Using SQL

This project aims to analyze sales data from three branches of Amazon located in Mandalay, Yangon, and Naypyitaw. The dataset contains information on sales transactions, including details such as invoice ID, branch, city, customer type, gender, product line, unit price, quantity, VAT, total cost, date, time, payment method, cost of goods sold, gross margin percentage, gross income, and rating.

## Purpose
The primary objective of this project is to gain insights into Amazon's sales data to understand various factors influencing sales across different branches. Through analysis, we aim to identify trends, patterns, and areas for improvement in sales strategies and customer segmentation.

## Approach
### 1. Data Wrangling
- Built a database and created tables to store the sales data.
- Inspected the data to detect and handle NULL values and missing data.
- Selected columns with NULL values, which were then filtered out as the tables were created with NOT NULL constraints.

### 2. Feature Engineering
- Added new columns such as `timeofday`, `dayname`, and `monthname` to provide insights into sales patterns based on time of day, day of the week, and month of the year, respectively.

### 3. Exploratory Data Analysis (EDA)
Conducted exploratory data analysis to answer specific business questions and achieve project goals.

## Business Questions
- Count of distinct cities in the dataset.
- Corresponding city for each branch.
- Count of distinct product lines.
- Most frequently occurring payment method.
- Product line with the highest sales.
- Revenue generated each month.
- Month with peak cost of goods sold.
- Product line generating the highest revenue.
- City with the highest revenue.
- Product line with the highest Value Added Tax (VAT).
- Classification of product lines as "Good" or "Bad" based on sales performance.
- Branch exceeding the average number of products sold.
- Most frequently associated product line with each gender.
- Average rating for each product line.
- Sales occurrences for each time of day on every weekday.
- Customer type contributing the highest revenue.
- City with the highest VAT percentage.
- Customer type with the highest VAT payments.
- Count of distinct customer types and payment methods.
- Most frequently occurring customer type.
- Customer type with the highest purchase frequency.
- Predominant gender among customers.
- Distribution of genders within each branch.
- Time of day with the most ratings from customers.
- Time of day with the highest customer ratings for each branch.
- Day of the week with the highest average ratings overall and for each branch.

## Conclusion
Through comprehensive analysis of Amazon's sales data, this project aims to provide valuable insights and recommendations to improve sales strategies, customer segmentation, and overall business performance. The results obtained from this analysis can guide decision-making processes and drive future growth and profitability for Amazon.
