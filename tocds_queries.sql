-- tpcds-schema.sql
--
customker
    c_customer_sk   -- unique key 100000

customer_address
    ca_address_sk -- unique key 50000 rows

inventory
    inv_item_sk -- non unique key 11745000 rows, 18000 unique
    inv_warehouse_sk -- warehouse
warehouse
    w_warehouse_sk
item
    i_item_sk


catalog_sales
    -- 1441548 non unique keys
    cs_bill_customer_sk    -- 79641 c_customer_sd keys
    cs_item_sk             -- 18000 item keys

store_sales
    ss_customer_sk    
    ss_item_sk


---- item ---- 8974 rpws
select count(*) recs, i_rec_start_date from item 
where i_rec_start_date between'1997-10-27' and
'1997-10-28'
group by i_rec_start_date;

---- inventory ---- 1575 rows
begin;
update inventory 
set inv_quantity_on_hand=inv_quantity_on_hand+1 
from item
where inv_item_sk =10 and i_item_sk = inv_item_sk and
i_rec_start_date between'1997-10-27' and
'1997-10-28';
rollback;


---- store_sales --- 70 rows
select count(*) recs, c_birth_year from customer,item,store_sales 
where c_customer_sk = ss_customer_sk and 
i_item_sk = ss_item_sk
group by c_birth_year;


---- warehouse --- this results in 10 rows
begin;
select count(*) recs, i_product_name
from warehouse,inventory,item 
where w_warehouse_sk=inv_warehouse_sk  and 
inv_item_sk =i_item_sk and
i_product_name between  'able' and
'ableprioughtpriought' and
i_manufact_id between 1 and 10
group by i_product_name
order by i_product_name;
rollback;





 call_center
 catalog_page
 catalog_returns
 catalog_sales
 customer
 customer_address
 customer_demographics
 date_dim
 household_demographics
 income_band
 inventory
 item
 promotion
 reason
 ship_mode
 store
 store_returns
 store_sales
 time_dim
 warehouse
 web_page
 web_returns
 web_sales
 web_site