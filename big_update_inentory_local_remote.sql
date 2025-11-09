
-- attach 'h:\duckdb\tpcds\tpcds.db' as tpcdslocal (read_only);

attach 'h:\duckdb\tpcds\tpcds.db' as tpcdslocal;


begin;
update tpcds.inventory as t 
set inv_quantity_on_hand = 
(select inv_quantity_on_hand from tpcdslocal.inventory l 
where 
    l.inv_date_sk = t.inv_date_sk and 
    t.inv_item_sk = l.inv_item_sk and 
    t.inv_warehouse_sk = l.inv_warehouse_sk
)
--commit;


update tpcdslocal.inventory as l set inv_quantity_on_hand = 
(select inv_quantity_on_hand from tpcds.inventory t 
where l.inv_date_sk = t.inv_date_sk and 
      t.inv_item_sk = l.inv_item_sk and 
      t.inv_warehouse_sk = l.inv_warehouse_sk
);
commit;

