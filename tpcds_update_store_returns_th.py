# tpcds_update_store_returns_th.py

import duckdb
import psutil
import sys
import gc
import time
import random
import setup_duck
import threading

def updates_from_thread(con,num_loops,num_queries):
    cur = con.cursor()
    for idx in range(loop_count):
        item_sk = random.randint(20000,21000)
        cur.begin()
        stmt = f"update inventory set \
           inv_quantity_on_hand = sr_return_quantity + inv_quantity_on_hand \
           from store_returns \
           where inventory.inv_item_sk = sr_item_sk \
           and sr_item_sk = {item_sk}"
        rows = cur.execute(stmt).fetchall()
        for row in rows:
            max_updates = max_updates + row[0]
        # Commit the changes
        #print("Commiting...")
        cur.commit()

db_name = 'md:tpcds'
if len(sys.argv) < 2:
    db_name = db_name
else:
    db_name = sys.argv[1]

max_updates = 0
loop_count = 100

print(f"Starting update INVENTORY with \
{duckdb.__version__} and {sys.argv[0]} and {db_name} and {loop_count} loops")

gc.disable()
setup_duck.setup_duck('W')
# Connect to your DuckDB database
con = duckdb.connect(db_name)
con.execute("SET scalar_subquery_error_on_multiple_rows=false")
con.execute("pragma enable_optimizer")
con.execute("load ICU")
con.execute("set TimeZone='Europe/Berlin'")
    
startCPU   = time.process_time_ns()
start_time = time.time()
nets = psutil.net_io_counters()
packets_start_send = nets[2]
packets_start_recv = nets[3]

# Execute the update query
con.begin()
con.execute("insert into ver(verno) select max(verno) +1 from ver;")
con.commit()

con.close()

endCPU   = time.process_time_ns()
end_time = time.time()
nets = psutil.net_io_counters()
packets_end_send = nets[2]
packets_end_recv = nets[3]
packets_total_send = packets_end_send - packets_start_send
packets_total_recv = packets_end_recv - packets_start_recv
packets_total = packets_total_send + packets_total_recv


print(f"Rows updated {max_updates} is {max_updates/loop_count} per loop")
print(f"Packets sent {packets_total_send} \
received {packets_total_recv} Total packets {packets_total}")

print(f"CPU time: {(endCPU - startCPU) / 1000000000:.2f}")
print(f"{sys.argv[0]} time: {end_time - start_time:.2f} seconds")
packs = f"{packets_total_send} {packets_total_recv} {packets_total}"
print(f"{end_time - start_time:.2f}  {(endCPU - startCPU) / 1000000000:.2f}  {packs}  {max_updates}")