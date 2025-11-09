select c_customer_sk,inv_item_sk,inv_quantity_on_hand,sr_return_quantity
  from customer,store_returns,item,inventory
  where c_customer_sk = sr_customer_sk 
  and sr_item_sk=i_item_sk 
  and sr_item_sk = inv_item_sk
  and sr_return_quantity > inv_quantity_on_hand 
  and c_customer_sk = 1
  order by inv_item_sk;
  
  
select sum(inv_quantity_on_hand) from inventory where inv_item_sk=1;
begin;
 update inventory set 
       inv_quantity_on_hand = sr_return_quantity + inv_quantity_on_hand
       from store_returns
       where inv_item_sk = sr_item_sk and sr_item_sk = 1;
commit;
select sum(inv_quantity_on_hand) from inventory where inv_item_sk=1;



update tpcds.inventory t1
  set inv_quantity_on_hand = t2.inv_quantity_on_hand
  from tpcds_c.inventory t2
  where t2.inv_item_sk = t1.inv_item_sk;
  
