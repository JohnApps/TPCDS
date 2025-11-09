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

