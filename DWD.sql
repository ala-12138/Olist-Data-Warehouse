-- OWD层：明细数据层（Transform 清洗与整合） 多表关联，清洗脏数据，构建分析用大宽表

DROP TABLE IF EXISTS dwd_order_detail;

create table dwd_order_detail as
select o.order_id,o.customer_id,c.customer_unique_id, 
o.order_status,i.order_item_id,i.product_id,
cast(o.order_purchase_timestamp as timestamp) as purchase_time,
coalesce(trim(c.customer_city),'unknown') as customer_city,
coalesce(trim(c.customer_state),'unknown') as customer_state ,
coalesce(i.price,0) as price,
coalesce(i.freight_value,0) as freight_value,
(coalesce(i.price,0)+coalesce(i.freight_value,0)) as total_amount,
coalesce(trim(p.product_category_name), 'unknown') as product_category_name
from olist.main.ods_orders o
join olist.main.ods_order_items i on o.order_id=i.order_id
join olist.main.ods_customers c on o.customer_id=c.customer_id
left join olist.main.ods_products p on i.product_id=p.product_id
where o.order_status='delivered' and o.order_purchase_timestamp>='2016-01-01';
