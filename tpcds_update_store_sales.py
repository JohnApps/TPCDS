# tpcds_update_store_sales.py

import duckdb
import threading
import random
import string
import time
import psutil
import sys
import gc
import setup_duck
import datetime
gc.disable()

db_name = 'md:tpcds'
if len(sys.argv) < 2:
    db_name = db_name
else:
    db_name = sys.argv[1]
max_updates = 0
loop_count = 10
local_con = duckdb.connect(f"{db_name}")
row = local_con.execute('pragma md_version').fetchone()
md_version = row[0]

print(f"Update STORE_SALES with \
{duckdb.__version__} {md_version} \
and {sys.argv[0]} and {db_name} and {loop_count} loops")
local_con.close()

gc.disable()
#setup_duck.setup_duck('W')
# Connect to your DuckDB database
con = duckdb.connect(db_name)
con.execute("SET scalar_subquery_error_on_multiple_rows=false")
con.execute("pragma enable_optimizer")
con.execute("load icu")
con.execute("set TimeZone='Europe/Berlin'")

#item_sk     = 'select count(*) rec from inventory'
#item_sk_max = duckdb.execute(item_sk).fetchall()

startCPU   = time.process_time_ns()
start_time = time.time()
nets = psutil.net_io_counters()
packets_start_send = nets[2]
packets_start_recv = nets[3]
# update inventory from store_sales
row = con.execute("select max(ss_item_sk) from store_sales").fetchone()
txn_lock = 0
idx = 0 
while idx < loop_count:
    item_sk = row[0]
    # Execute the update query
    stmt = f"update inventory \
    set inv_quantity_on_hand  = inv_quantity_on_hand - ss_quantity \
    from store_sales \
    where inv_item_sk = ss_item_sk \
    and ss_item_sk = {item_sk}"
    try:
        con.begin()
        rows = con.execute(stmt).fetchall()
        row = rows[0]
        max_updates = max_updates + row[0]
        # Commit the changes
        #print("Commiting...")
        con.commit()
        idx = idx + 1
    except duckdb.TransactionException as e:
        con.rollback()
        txn_lock = txn_lock+1
        idx = idx + 1
#        print ('duckdb.TransactionException', e)
        continue

print (f"Number updated {row[0]} rows per loop {row[0]/loop_count}")

endCPU   = time.process_time_ns()
end_time = time.time()
nets = psutil.net_io_counters()
packets_end_send = nets[2]
packets_end_recv = nets[3]
packets_total_send = packets_end_send - packets_start_send
packets_total_recv = packets_end_recv - packets_start_recv
packets_total = packets_total_send + packets_total_recv
#
# update the version number
#
verr = duckdb.connect("md:tpcds")
verr.begin()
rows = verr.execute("select max(verno)+1 from ver").fetchall()
for row in rows:
  verno = row[0]
  if verno == None:
      verno = 1
vertime = datetime.datetime.now()
stmt = f"insert into ver(verno,vertime,pgm) \
    values({verno}, '{vertime}','{sys.argv[0]}')"
verr.execute(stmt)
verr.commit()
verr.close()

# Close the connection
con.close()

print(f"Number of txn locks {txn_lock}")
print(f"Packets sent {packets_total_send} received {packets_total_recv} Total packets {packets_total}")
packs = f"{packets_total_send} {packets_total_recv} {packets_total}"
print(f"CPU time: {(endCPU - startCPU) / 1000000000:.2f}")
print(f"{sys.argv[0]} time: {end_time - start_time:.2f} seconds")
print(f"{end_time - start_time:.2f} {(endCPU - startCPU) / 1000000000:.2f} {packs} {db_name} {datetime.date.today()} {md_version} {max_updates} {loop_count}")
