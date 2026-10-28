-- DWS层：数据服务层 轻度汇总

-- 按照客户所在州汇总
DROP TABLE IF EXISTS dws_sales_by_state;
create table dws_sales_by_state as 
select customer_state as state_name,
count(distinct order_id) as total_orders,
sum(price) as total_price,
sum(freight_value) as total_freight,
sum(total_amount) as total_gmv,
sum(total_amount)/count(distinct customer_unique_id) as arpu
from dwd_order_detail
group by customer_state;

select * from dws_sales_by_state;

-- 按照“年月”汇总
DROP TABLE IF EXISTS dws_sales_by_month;
create table dws_sales_by_month as
select 
extract(year from purchase_time) as sales_year,
extract(month from purchase_time) as sales_month,
count(distinct order_id) as total_orders,
sum(price) as total_price,
sum(freight_value) as total_freight,
sum(total_amount) as total_gmv
from dwd_order_detail
group by extract(year from purchase_time),extract(month from purchase_time)
order by extract(year from purchase_time),extract(month from purchase_time);

select * from dws_sales_by_month;

-- 按照商品品类汇总
DROP TABLE IF EXISTS dws_sales_by_category;
create table dws_sales_by_category as
select product_category_name,
count(distinct order_id) as total_orders,
sum(price) as total_price,
sum(freight_value) as total_freight,
sum(total_amount) as total_gmv,
avg(price) as avg_product_price
from dwd_order_detail
group by product_category_name;

select * from dws_sales_by_category;

-- 按照州+城市汇总
DROP TABLE IF EXISTS dws_sales_by_city;
create table dws_sales_by_city as 
select customer_state as state_name,
customer_city as city_name,
count(distinct order_id) as total_orders,
sum(price) as total_price,
sum(freight_value) as total_freight,
sum(total_amount) as total_gmv,
sum(total_amount)/count(distinct customer_unique_id) as arpu
from dwd_order_detail
group by customer_state,customer_city;

select * from dws_sales_by_city;