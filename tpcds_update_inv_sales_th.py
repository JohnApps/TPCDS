# tpcds_update_inv_sales_th.py
import threading
import duckdb
import time
import random
import sys
import psutil
import datetime
import gc
gc.disable()

def query_from_thread(con,num_loops,num_queries):
    global max_updates
    for idx in range(num_loops):
        cur = con.cursor()
        item_sk = random.randint(1,10000)

        # Execute the update query
        stmt = f"update inventory \
        set inv_quantity_on_hand  = inv_quantity_on_hand - ss_quantity \
        from store_sales \
        where inv_item_sk = ss_item_sk \
        and ss_item_sk = {item_sk}"
        cur.begin()
        rows = cur.execute(stmt).fetchall()
        row = rows[0]
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
num_threads = 4     # how many threads to start
num_loops   = 100     # number loops the thread must run
num_queries = 99    # number of queries should they be needed
threads     = []

print(f"Update STORE_SALES with \
{duckdb.__version__} \
and {sys.argv[0]} and {db_name} and \
and number threads {num_threads} with {num_loops} loops")

gc.disable()
#setup_duck.setup_duck('W')
# Connect to your DuckDB database
con = duckdb.connect(db_name)
con.execute("SET scalar_subquery_error_on_multiple_rows=false")
con.execute("pragma enable_optimizer")
con.execute("load icu")
con.execute("set TimeZone='Europe/Berlin'")
startCPU   = time.process_time_ns()
start_time = time.time()
nets = psutil.net_io_counters()
packets_start_send = nets[2]
packets_start_recv = nets[3]
   
for i in range(num_threads):
#    local_con = duckdb.connect(f"{db_name}?conn={i}")
    local_con = duckdb.connect(f"{db_name}")
    con = local_con.cursor()
    thread = threading.Thread(target=query_from_thread,
        args=(con,num_loops,num_queries))
    threads.append(thread)
for thread in threads:
    thread.start()
for thread in threads:
    thread.join()

endCPU   = time.process_time_ns()
end_time = time.time()
nets = psutil.net_io_counters()
packets_end_send = nets[2]
packets_end_recv = nets[3]
packets_total_send = packets_end_send - packets_start_send
packets_total_recv = packets_end_recv - packets_start_recv
packets_total = packets_total_send + packets_total_recv
print (f"Number updated {max_updates} \
rows per loop {max_updates/num_loops}")
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

print(f"Packets sent {packets_total_send} \
received {packets_total_recv} Total packets {packets_total}")
packs = f"{packets_total_send} {packets_total_recv} {packets_total}"
print(f"CPU time: {(endCPU - startCPU) / 1000000000:.2f}")
print(f"{sys.argv[0]} time: {end_time - start_time:.2f} seconds")
print(f"{end_time - start_time:.2f}  {(endCPU - startCPU) / 1000000000:.2f}  {packs}  {max_updates}")