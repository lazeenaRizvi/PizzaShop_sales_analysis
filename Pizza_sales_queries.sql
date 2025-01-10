
-- KPI Requirements 
select SUM(total_price) AS Total_Revenue from pizza_sales;
select SUM(total_price) / COUNT(DISTINCT order_id) as Avg_Order_Value from pizza_sales;
select SUM(quantity) AS Total_Pizza_Sold from pizza_sales;
select COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales;
select SUM(quantity) / COUNT(DISTINCT order_id)  from pizza_sales;

-- Queries for Chart Requirement 
-- Daily Trends for total orders 
SELECT DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS day_name, 
       COUNT(DISTINCT order_id ) AS Total_Orders
FROM pizza_sales
GROUP BY day_name;

-- Monthly trends for total orders 
SELECT MONTHNAME(STR_TO_DATE(order_date,'%d-%m-%Y')) AS Month_Name , 
	COUNT(DISTINCT order_id ) AS Total_Orders 
FROM pizza_sales 
GROUP BY Month_Name
ORDER BY Total_Orders DESC;

-- Percentage of Sales By Pizaa Category 

SELECT pizza_category,sum(total_price) as Total_Sales,  SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) As PCT
FROM  pizza_sales
GROUP BY pizza_category;

-- Percentage of Sales By Pizaa Size 
SELECT pizza_size ,sum(total_price) as Total_Sales,  SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) As PCT
FROM  pizza_sales
GROUP BY pizza_size
order by PCT DESC;

-- values uoto 2 decimal place 

SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales, 
    CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) from pizza_sales WHERE QUARTER( STR_TO_DATE (order_date, '%d-%m-%y')) =1 ) AS DECIMAL(10,2)) AS PCT
FROM  
    pizza_sales
WHERE 
	QUARTER(STR_TO_DATE (order_date, '%d-%m-%y')) =1 
GROUP BY 
    pizza_size
ORDER BY 
    PCT DESC;

-- top 5 best sellers by Revenue , Total Quantity, and Total orders --

SELECT 
   pizza_name,SUM(total_price) as Total_Revenue
FROM
    pizza_sales
GROUP BY
	pizza_name
order by
     Total_Revenue DESC limit 5;


-- total quantity --
SELECT 
   pizza_name,SUM(quantity) as Total_Quantity
FROM
    pizza_sales
GROUP BY
	pizza_name
order by
     Total_Quantity DESC limit 5;

-- total orders --
SELECT 
   pizza_name, count(distinct  order_id) as Total_Order
FROM
    pizza_sales
GROUP BY
	pizza_name
order by
     Total_Order DESC limit 5;
     
-- Similarly for bottom five use asc in place of desc --
SELECT 
   pizza_name, count(distinct  order_id) as Total_Order
FROM
    pizza_sales
GROUP BY
	pizza_name
order by
     Total_Order ASC limit 5;




