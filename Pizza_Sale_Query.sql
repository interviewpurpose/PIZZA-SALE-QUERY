SELECT * FROM pizza_sales;

--  --------------- KPI --------------------------------------------
-- 1. Total Revenue 
SELECT total_price FROM pizza_sales;

SELECT SUM(total_price) As TotalRevenue
FROM pizza_sales;

-- 2. Average Order Value

SELECT SUM(total_price)  / COUNT(DISTINCT order_id ) As AverageOrder
FROM pizza_sales;

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_sold 
FROM pizza_sales;

-- 4. Total Orders

SELECT COUNT(DISTINCT order_id) As Total_orders
FROM pizza_sales;

-- 5. Average Pizzas per Order
SELECT CAST(CAST(SUM(quantity) As DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) As DECIMAL(10,2)) As DECIMAL(10,2))  As Average_Pizza_per_order
FROM pizza_sales;
-- -----------------------------------------------------------------------------------------------------

--  ----------------------- CHART -------------------------------------------------------------------
-- 1. Daily Trend for Total Order

-- count total order by datewise
SELECT order_date, COUNT(DISTINCT(order_id)) As Total_Order
FROM pizza_sales
GROUP BY order_date;

-- count total order by daywise
SELECT DATENAME(DW, order_date) As Days,
COUNT(DISTINCT(order_id)) As daily_trend_for_totalOrder
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);
-- --------------------------------------------------------------------------
-- 2. Hourly Trend for Total Order
SELECT DATEPART(HOUR, order_time) As Order_Time,
COUNT(DISTINCT(order_id)) As Total_Order
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time) 
ORDER BY DATEPART(HOUR, order_time);

-- ------------------------------------------------------------------------------

-- 3. percentage of sales by pizza category

SELECT * FROM pizza_sales;

SELECT DISTINCT pizza_category, SUM(total_price) *100 / (SELECT SUM(total_price) FROM pizza_sales) As percentage_of_sale
FROM pizza_sales
GROUP BY pizza_category;

-- add sum of total sale also
SELECT pizza_category, SUM(total_price) As Total_sales,
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) As percentage_of_sale 
FROM pizza_sales
GROUP BY pizza_category;

-- find percentage of sales monthwise by pizza category
SELECT pizza_category, SUM(total_price) As Total_sales,
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) =1 )As percentage_of_sale
FROM pizza_sales
WHERE MONTH(order_date) =1 
GROUP BY pizza_category;

-- find percentage of sales quarterwise by pizza category
SELECT pizza_category, SUM(total_price) As Total_sales,
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER,order_date) =1 )As percentage_of_sale
FROM pizza_sales
WHERE DATEPART(QUARTER,order_date) =1 -- from jan to april
GROUP BY pizza_category;


-- ------------------------------------------------------------------------------

-- 4. percentage of sales by pizza size
SELECT DISTINCT pizza_size, SUM(total_price) As Total_sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) As percentage_of_sale 
FROM pizza_sales
GROUP BY pizza_size;

-- -------------------------------------------------------------------------------

--5. Total pizza sold by pizza category
SELECT pizza_category, SUM(quantity) As total_pizza_sold
FROM pizza_sales
GROUP BY pizza_category;

-- -------------------------------------------------------------------------------

-- 6. Top 5 Best sellers by total pizzsas sold

SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC;

-- -------------------------------------------------------------------------------

-- 7. Bottom 5 worst sellers by total pizzas sold
SELECT TOP 5 pizza_name, SUM(quantity) As total_pizza_sold 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold ASC;
-- --------------------------------------------------------------------------------






