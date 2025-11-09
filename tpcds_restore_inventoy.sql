-- tpcds_restore_inventoy.sql
-- Copy INVENTORY data from a backup of the database being restore
--
use tpcds_30;
SET scalar_subquery_error_on_multiple_rows=false;
update inventory
 set inv_quantity_on_hand =
 (select inv_quantity_on_hand
 from tpcds_30_c.inventory
 where inv_item_sk = tpcds_30.inventory.inv_item_sk);


use tpcds_10;
SET scalar_subquery_error_on_multiple_rows=false;
update inventory
 set inv_quantity_on_hand =
 (select inv_quantity_on_hand
 from tpcds_30_c.inventory
 where inv_item_sk = tpcds_10.inventory.inv_item_sk);

use tpcds_05;
SET scalar_subquery_error_on_multiple_rows=false;
update inventory
 set inv_quantity_on_hand =
 (select inv_quantity_on_hand
 from tpcds_30_c.inventory
 where inv_item_sk = tpcds_05.inventory.inv_item_sk);

use tpcds;
SET scalar_subquery_error_on_multiple_rows=false;
update inventory
 set inv_quantity_on_hand =
 (select inv_quantity_on_hand
 from tpcds_c.inventory
 where inv_item_sk = tpcds.inventory.inv_item_sk);

