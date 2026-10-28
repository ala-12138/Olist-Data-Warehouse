-- ADS层：应用数据层 出业务报表

-- 1.全局大盘 按月看GMV和客单价
drop table if exists ads_monthly_trend;
create table ads_monthly_trend as 
select 
sales_year as '年份',
sales_month as '月份',
total_orders as '订单总数',
total_gmv as '交易总额',
total_gmv/total_orders as '客单价'
from dws_sales_by_month
order by sales_year,sales_month;
select * from ads_monthly_trend;

-- 2.地域营收排行
drop table if exists ads_state_rank;
create table ads_state_rank as 
select state_name as '州',
total_orders as '订单总数',
total_gmv as '交易总额GMV',
total_gmv/total_orders as '客单价',
arpu as '人均消费ARPU'
from dws_sales_by_state
order by total_gmv desc;
select *from ads_state_rank;

-- 3.畅销商品top10
drop table if exists ads_category_top10;
create table ads_category_top10 as 
select product_category_name as '商品品类',
total_orders as '订单总数',
total_gmv as '交易总额GMV',
total_price/total_orders as '平均单价'
from dws_sales_by_category
where product_category_name !='unknown'
order by total_gmv desc
limit 10;
select *from ads_category_top10;

-- 4.城市下钻明细
DROP TABLE IF EXISTS ads_all_state_city_top3;
CREATE TABLE ads_all_state_city_top3 AS
with cityranking as(
select state_name,city_name,total_orders,total_gmv,
rank()over(partition by state_name order by total_gmv desc) as rank_nbr
from dws_sales_by_city)
SELECT state_name as '州',
    city_name AS '城市',
    total_orders as '订单量',
    total_gmv as '总交易额GMV',
    rank_nbr as '州内排名'
FROM cityranking
WHERE rank_nbr<=3;
select *from ads_all_state_city_top3;
