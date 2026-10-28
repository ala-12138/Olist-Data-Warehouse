-- ODS层:贴源层（Extract） 提取数据建表

DROP TABLE IF EXISTS ods_orders;
DROP TABLE IF EXISTS ods_order_items;
DROP TABLE IF EXISTS ods_customers;
DROP TABLE IF EXISTS ods_products;

-- 建立ODS订单表
create table ods_orders as 
select * from read_csv_auto('D:\\project\\olist_project\\data\\olist_orders_dataset.csv');

-- 建立ODS订单明细表
create table ods_order_items as 
select * from read_csv_auto('D:\\project\\olist_project\\data\\olist_order_items_dataset.csv');

-- 建立ODS客户表
create table ods_customers as 
select * from read_csv_auto('D:\\project\\olist_project\\data\\olist_customers_dataset.csv');

-- 建立ODS商品表
create table ods_products as 
select * from read_csv_auto('D:\\project\\olist_project\\data\\olist_products_dataset.csv');

