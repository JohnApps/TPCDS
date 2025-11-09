-- update_inventory_from_store_returns.sql

WITH ReturnedItems AS ( 
    SELECT 
        sr_item_sk, 
        SUM(sr_return_quantity) AS total_returned_quantity 
    FROM 
        store_returns where sr_item_sk = 1
    GROUP BY 
        sr_item_sk ) 
UPDATE inventory 
SET inv_quantity_on_hand = ii.inv_quantity_on_hand + r.total_returned_quantity 
FROM inventory ii 
INNER JOIN ReturnedItems r ON ii.inv_item_sk = r.sr_item_sk;"
;
