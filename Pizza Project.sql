--PROBLEM STATEMENT 1: KPI

USE [PizzaSales]

--Total Revenue calculation

SELECT 
ROUND(SUM(total_price),2) AS Total_revenue
FROM pizza_sales


--Average order value

SELECT 
 ROUND(SUM(total_price) / COUNT( DISTINCT order_id),2) AS Average_order_value
FROM pizza_sales

--Total pizzas sold

SELECT 
COUNT(quantity) AS Total_pizzas_sold
FROM pizza_sales 

--Total orders

SELECT 
COUNT(order_id) AS Total_orders
FROM pizza_sales

--Average number of pizzas per order

SELECT 
CAST(
CAST(SUM(quantity) AS decimal(10,2))
/ CAST(COUNT(DISTINCT order_id) AS decimal(10,2))
AS decimal(10,2))
AS average_number_of_pizzas_per_order
FROM pizza_sales


--PROBLEM STATEMENT 2:CHART REQUIREMENTS

USE PizzaSales	

1.--Daily trend for total orders

SELECT  DATENAME(DW, order_date) as Order_day , COUNT(DISTINCT order_id) as Total_orders

FROM pizza_sales

GROUP BY DATENAME(DW, order_date)


2.--Hourly trend for total orders

SELECT DATEPART(HH, order_time) AS Order_hour , COUNT(DISTINCT order_id) as Total_orders,

CASE  
	WHEN COUNT(DISTINCT order_id) >= 1500 THEN 'Peak times'
	WHEN COUNT(DISTINCT order_id) >= 500 AND COUNT(DISTINCT order_id) < 1500 THEN 'Normal'
	ELSE 'Slow'
	
	END AS Business_status

FROM pizza_sales

GROUP BY DATEPART(HH, order_time)

ORDER BY DATEPART(HH, order_time)


3--Total Sales per month

SELECT 
DATENAME(MONTH, order_date) AS order_month, ROUND(SUM(total_price),2) AS Total_revenue

FROM pizza_sales

GROUP BY DATENAME(MONTH, order_date)

ORDER BY DATENAME(MONTH, order_date) DESC 


4--Percentage of sales per category

SELECT  pizza_category,ROUND(SUM(total_price),2) AS Total_revenue, ROUND(SUM(total_price)*100 
/ (SELECT SUM(total_price) FROM pizza_sales),2) AS pct_sales

FROM pizza_sales

GROUP BY pizza_category


5--Percentage of sales by pizza size

SELECT pizza_size,
ROUND(SUM(total_price),2) AS Total_revenue, ROUND(SUM(total_price)*100 /
(SELECT SUM(total_price) FROM pizza_sales),2) AS pct_sales

FROM pizza_sales

GROUP BY pizza_size

ORDER BY pct_sales DESC

6--Total pizzas sold by category

SELECT pizza_category, ROUND(SUM(total_price),2) AS Total_sales

FROM pizza_sales

GROUP BY pizza_category


7--Top 5 Best sellers by total Pizzas sold

SELECT  TOP(5)
pizza_name , COUNT(quantity) AS 'total_pizzas_sold'

FROM pizza_sales

GROUP BY pizza_name

8--Bottom 5 worst sellers by total pizzas sold

SELECT  TOP(5)
pizza_name , COUNT(quantity) AS 'total_pizzas_sold'

FROM pizza_sales

GROUP BY pizza_name

ORDER BY total_pizzas_sold DESC
