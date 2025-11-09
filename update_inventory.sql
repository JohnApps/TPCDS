
 pragma enable_optimizer;


select  client_transaction_id,
        server_transaction_elapsed_time,
        server_query_elapsed_time,
--        server_query_progress,
        server_transaction_stage,
--        query_total_upload_size,
--        query_total_download_size,
--        client_query
        FROM md_active_server_connections()
        where client_connection_id != 
            md_current_client_connection_id();

--=========================== THE BIG ONE ===============--
begin;
select sum(sr_return_quantity), sr_item_sk
 from store_returns
 where sr_item_sk=19154
 and sr_customer_sk=1167006
 and sr_store_sk=127
 group by sr_item_sk;
rollback;

begin;
select sum(inv_quantity_on_hand) inv_qty
  from inventory
  where inv_item_sk = 19154
  group by inv_item_sk;
rollback;

begin;
update inventory set inv_quantity_on_hand =
       (select sum(sr_return_quantity)
       from store_returns
       where sr_item_sk = inv_item_sk
       and sr_item_sk=19154
       and inv_item_sk=sr_item_sk
       and sr_customer_sk=1167006
       and sr_store_sk=127
       group by sr_item_sk);
commit;

begin;
select sum(sr_return_quantity), sr_item_sk
 from store_returns
 where sr_item_sk=19154
 and sr_customer_sk=1167006
 and sr_store_sk=127
 group by sr_item_sk;
rollback;

begin;
select sum(inv_quantity_on_hand) inv_qty
  from inventory
  where inv_item_sk = 19154
  group by inv_item_sk;
rollback;

--=========================== THE BIG ONE ===============--

select year(d_date),d_year from date_dim where year(d_date) = 2100;

--------------- store_sale --------------

begin;
update inventory set
  inv_quantity_on_hand = inv_quantity_on_hand + ss_quantity
  from store_sales, customer
  where inv_item_sk = ss_item_sk
  and   inv_item_sk = 10721
  and   ss_quantity not null;
commit;

begin;
update inventory set 
  inv_quantity_on_hand = inv_quantity_on_hand - ss_quantity 
  from store_sales, customer 
  where inv_item_sk = ss_item_sk 
  and   inv_item_sk = 10721 
  and ss_item_sk = inv_item_sk 
  and ss_customer_sk between 1 and 400000
  and ss_store_sk = 127 ;
commit;

update inventory 
set inv_quantity_on_hand = sr_return_quantity+inv_quantity_on_hand  
from store_returns where inv_item_sk = sr_item_sk 
and sr_returned_date_sk = 2451984;

begin;
update inventory
set inv_quantity_on_hand  = inv_quantity_on_hand - ss_quantity 
from store_sales where inv_item_sk = ss_item_sk
and ss_sold_date_sk = 2451984;
commit;

------------- store_returns ----------
-- check out some joins
begin;
select c_customer_sk,inv_item_sk,inv_quantity_on_hand,sr_return_quantity
  from customer,store_returns,item,inventory
  where c_customer_sk = sr_customer_sk
  and sr_item_sk=i_item_sk
  and sr_item_sk = inv_item_sk
  and c_customer_sk = 1
  order by inv_item_sk
  limit 10;
rollback;

-- update inv_quantity_on_hand by adding returns to it
select sum(inv_quantity_on_hand) from inventory where inv_item_sk=10721;
-- this affects 171600 rows
begin;
 update inventory set
       inv_quantity_on_hand = sr_return_quantity + inv_quantity_on_hand
       from store_returns
       where inventory.inv_item_sk = sr_item_sk 
       and sr_item_sk = 10721
       and sr_return_quantity not null;
commit;

begin;
 update inventory set
       inv_quantity_on_hand = ss_quantity + inv_quantity_on_hand
       from store_sales
       where inventory.inv_item_sk = ss_item_sk 
       and ss_item_sk = 10721
       and ss_quantity not null;
commit;

begin;
select sum(inv_quantity_on_hand) from inventory where inv_item_sk=10721;
rollback;

---============ dekete abd insert the inventory table =-====

-- restore master from copy --
begin;
 SELECT SUM(inv_quantity_on_hand) AS total_inventory,
       current_time  AS timestamp
 FROM inventory  GROUP BY timestamp;
commit;

select client_transaction_id,server_transaction_stage, 
 from md_active_server_connections()
 where client_connection_id != md_current_client_connection_id();

begin;
insert into ver(verno) select max(verno) +1 from ver;
commit;
use tpcds0001;
begin;
  delete from inventory;
commit;
use tpcds0001;
begin; 
  insert into inventory select * from tpcds_copy10.inventory;
commit;
begin;
insert into ver(verno) select max(verno) +1 from ver;
commit;

begin;
 SELECT SUM(inv_quantity_on_hand) AS total_inventory,
       current_time  AS timestamp
 FROM inventory
 GROUP BY timestamp;
commit;
---============ dekete abd insert the inventory table =-====
----------------========== how to generate data from the version table DB
use verdb;
.changes off
.timer off
.mode csv
.output verb.csv
select 'T'||verno as verno, ver.tod - vertime as diff,
  vertime,ver.tod as tod from ver where diff < '00:03:00' 
  order by verno;
.output
.mode duckbox
.timer on
.changes on

-- list all tokens owned by johndapps
-- https://motherduck.com/docs/sql-reference/rest-api/users-token-list/

curl -L 'https://api.motherduck.com/v1/users/johndapps/tokens' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uIjoiam9obi5kLmFwcHMuZ21haWwuY29tIiwiZW1haWwiOiJqb2huLmQuYXBwc0BnbWFpbC5jb20iLCJ1c2VySWQiOiI3MjYyNzQxMS1lZjE4LTRkNGEtYTg3Ny1iM2U1ZDUxOTRhOWQiLCJpYXQiOjE3MTE4MjIzNTgsImV4cCI6MTc0MzM3OTk1OH0.t8dAyF9GLMxgMSPDGnMKRTO7_FUudxSw0Q3MXlVE8hU'


curl -L "https://api.motherduck.com/v1/users/johndapps/tokens" ^
-H "Accept: application/json" ^
-H "Authorization: Bearer "


-- create a new user called walt disney using john-d-apps token
curl -L "https://api.motherduck.com/v1/users" ^
-H "Content-Type: application/json" ^
-H "Accept: application/json" ^
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uIjoiam9obi5kLmFwcHMuZ21haWwuY29tIiwiZW1haWwiOiJqb2huLmQuYXBwc0BnbWFpbC5jb20iLCJ1c2VySWQiOiI3MjYyNzQxMS1lZjE4LTRkNGEtYTg3Ny1iM2U1ZDUxOTRhOWQiLCJpYXQiOjE3MTE4MjIzNTgsImV4cCI6MTc0MzM3OTk1OH0.t8dAyF9GLMxgMSPDGnMKRTO7_FUudxSw0Q3MXlVE8hU" ^
-d "{\"username\": "\"walt_disney\"}"

-- create a new user called walt disney using john-d-appstoken
curl -L "https://api.motherduck.com/v1/users" ^
-H "Content-Type: application/json" ^
-H "Accept: application/json" ^
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uIjoiam9obi5kLmFwcHMuZ21haWwuY29tIiwiZW1haWwiOiJqb2huLmQuYXBwc0BnbWFpbC5jb20iLCJ1c2VySWQiOiI3MjYyNzQxMS1lZjE4LTRkNGEtYTg3Ny1iM2U1ZDUxOTRhOWQiLCJpYXQiOjE3MTE4MjIzNTgsImV4cCI6MTc0MzM3OTk1OH0.t8dAyF9GLMxgMSPDGnMKRTO7_FUudxSw0Q3MXlVE8hU" ^
-d "{\"username\": "\"johndapps_1\"}"


-- issue a token to johndapps
curl -L 'https://api.motherduck.com/v1/users/zzz01/tokens' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uIjoiam9obi5kLmFwcHMuZ21haWwuY29tIiwiZW1haWwiOiJqb2huLmQuYXBwc0BnbWFpbC5jb20iLCJ1c2VySWQiOiI3MjYyNzQxMS1lZjE4LTRkNGEtYTg3Ny1iM2U1ZDUxOTRhOWQiLCJpYXQiOjE3MTE4MjIzNTgsImV4cCI6MTc0MzM3OTk1OH0.t8dAyF9GLMxgMSPDGnMKRTO7_FUudxSw0Q3MXlVE8hU' \
-d '{
  "ttl": 31536000,
  "name": "zzz01_rw_token",
  "token_type": "read_write"
}'

export motherduck_token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhLTk1ZjhhYzVmLWJlYTctNGExMy04ZjgyLTU0MGRlZThhMzE3N0BzYS5tb3RoZXJkdWNrLmNvbSIsInNlc3Npb24iOiJzYS05NWY4YWM1Zi1iZWE3LTRhMTMtOGY4Mi01NDBkZWU4YTMxNzcuc2EubW90aGVyZHVjay5jb20iLCJwYXQiOiI0NW1obFBodXgyYnNKdXRGdDl6Zkd3X05fRU1aRFVaa2xJNWxsNk5BcHI0IiwidXNlcklkIjoiZGJiNTJhYWUtNTVmYy00NzhiLTllYmMtNjgyMGEyMzgyYTI1IiwiaXNzIjoibWRfcGF0IiwicmVhZE9ubHkiOmZhbHNlLCJ0b2tlblR5cGUiOiJyZWFkX3dyaXRlIiwiaWF0IjoxNzM0OTYxMDYxLCJleHAiOjE3NjY0OTcwNjF9.bD8DzqyU0AoiE1NVgp5KqlhAl6GSLYb4N6LCjogQx4w'
----------------========== how to generate data from the version table DB
select ss_item_sk,count(ss_item_sk) 
  from store_sales 
  where ss_item_sk between 80000 and 90000 group by all;

select sr_item_sk,count(sr_item_sk) 
  from store_returns 
  where sr_item_sk between 800 and 900 group by all;


begin;
update tpcds.inventory t1
  set inv_quantity_on_hand = t2.inv_quantity_on_hand
  from tpcds_c.inventory t2
  where t1.inv_item_sk = t2.inv_item_sk;
commit;
  and t2.inv_item_sk = 10721;


select sr_item_sk,i_item_sk,inv_item_sk,sr_return_quantity,inv_quantity_on_hand
    from store_returns,inventory,item
    where inv_item_sk=sr_item_sk and
        sr_return_quantity not null and
        i_item_sk = 1
    limit 100;

---- restore inventory quantity on hand from DB copy ----
begin;
update tpcds.inventory ti set inv_quantity_on_hand = 
    (select inv_quantity_on_hand from tpcds_c.inventory t1i,
    store_returns sr, item I, warehouse
    where ti.inv_item_sk=t1i.inv_item_sk and
    sr_item_sk = i_item_sk and
    ti.inv_date_sk = t1i.inv_date_sk and
    ti.inv_date_sk = t1i.inv_date_sk and
    ti.inv_warehouse_sk = t1i.inv_warehouse_sk and
    w_warehouse_sk = 1 and
    t1i.inv_warehouse_sk = w_warehouse_sk and
    i_item_sk = 102000
    );
commit;

begin;
select count(*),c_last_name
    from customer, store_sales, item, inventory
    where ss_customer_sk = c_customer_sk and
    ss_customer_sk = i_item_sk and
    inv_item_sk = i_item_sk
    group by c_last_name,c_customer_sk, ss_customer_sk, i_item_sk;
rollback;
--------================== a big, nasty query for fun ======================
use tpcds;
begin;
select inventory.rowid, w_warehouse_sk, c_customer_sk, count(c_customer_sk) as C_C, sum(ss_quantity) as SS_Q, sum(i_current_price* inv_quantity_on_hand) as I_P, 
sum(inv_quantity_on_hand) as INV_Q,
ss_store_sk, i_item_sk,inv_item_sk, i_current_price
from customer, store, store_sales, item, inventory,warehouse
where 
c_customer_sk = ss_customer_sk and
inv_warehouse_sk = w_warehouse_sk and
ss_store_sk = s_store_sk and
i_item_sk = ss_item_sk and
i_item_sk = inv_item_sk and
c_customer_sk between 1 and 100000 and
w_warehouse_sk = 1 and
i_current_price * inv_quantity_on_hand > 1
group by all 
order by inventory.rowid
limit 100;
rollback;


select 
            client_connection_id,
            client_transaction_id,
            server_transaction_elapsed_time,
            server_query_elapsed_time,  
            server_transaction_stage 
            FROM md_active_server_connections() 
            where client_connection_id != 
            (md_current_client_connection_id()) 
            order by client_connection_id,
            client_transaction_id
;

--================== special commands for DuckDB ==================
pragma enable_optimizer;
SET scalar_subquery_error_on_multiple_rows=false;