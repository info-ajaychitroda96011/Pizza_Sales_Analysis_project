use Pizza_db;

select * from pizza_sales;

ALTER TABLE pizza_sales
ALTER COLUMN total_price DECIMAL(10,2);


-- Q-1 Total Revenue :-
SELECT sum(total_price)AS Total_Revenue from pizza_sales;

-- Q-2 Average Order value :-
-- Order ID contains Duplicate value so that we count o_id with DISTINCT
select sum(total_price) / count(distinct order_id) as Avg_order_val from pizza_sales;

-- Q-3 Total Pizza Sold :-
select sum(quantity) as Total_pizza_sold from pizza_sales;

-- Q-4 Total Orders :-
select count(distinct order_id) as Total_orders from pizza_sales;

-- Q-5 Average Pizza Per order :-
-- CAST is used to display only 2 numbers after decimal points
select cast(cast(sum(quantity)AS decimal(10,2)) / cast(count(distinct order_id)as decimal(10,2)) as decimal(10,2))as Avg_pizza_order from pizza_sales;


------------------------ CHARTS REQUIREMENTS :---------------------------------

-- Q-1 :- Daily Trends for total orders :
select DATENAME(dw,order_date) as order_day,count(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME(dw,order_date);

-- Q-2 Monthly trend of Total orders :-
select DATENAME(MONTH,order_date) as Month_name,count(distinct order_id) as Total_order
from pizza_sales
group by DATENAME(MONTH,order_date)
order by Total_order desc;

-- Q-3 Percentage of Sales by Pizza category :-
select pizza_category,sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales where MONTH(order_date) = 1) as Percentage_Total_Sales
from pizza_sales 
where MONTH(order_date) = 1
group by pizza_category
 -- Here MONTH = 1 indicates that the o/p is for the month of JANUARY

 -- Q-4 Percentage of Sales by Pizza Size :-
select pizza_size,sum(total_price) as Total_sales,
cast(sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales where DATEPART(quarter,order_date) = 1)as decimal(10,2)) as Percentage_Total_Sales
from pizza_sales
where DATEPART(quarter,order_date) = 1
group by pizza_size
order by Percentage_Total_Sales desc

-- Q-5 Total Pizza sold by Pizza category :
select top 5 pizza_name,sum(total_price) as Total_revenue
from pizza_sales
group by pizza_name
order by Total_revenue desc

select top 5 pizza_name,count(distinct order_id) as Total_orders
from pizza_sales
group by pizza_name
order by Total_orders desc
