# tpcds_read_th.py
#
# For more info see: 
# https://duckdb.org/docs/extensions/tpcds.html
# TPC-DS has been generaed with SF 30
#
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
import textwrap

# This function runs a query from a thread using the connection pool.
def query_from_thread(con,num_loops,num_queries):
# Create queries - there are 99 queries in all
    queries = [f"PRAGMA tpcds({n+1});" for n in range(num_queries)]
    cur = con.cursor()
#    cur.execute("set threads=4")
#    cur.execute("set worker_threads=4")
    cur.execute('set global max_temp_directory_size = "512GB"')
    cur.execute('set global max_memory="512GB"')
    cur.execute('set global memory_limit="512GB"')
    cur.execute("pragma enable_optimizer")
    setup_duck.setup_duck('R')
    times = []  # collect the times for each query here
#    cur.begin()
    try:
        for query in queries:
            start_time = time.time()
            for index in range(num_loops):
                randy = random.randint(1, 13)   # averae of 7 run per query
                #time.sleep(randy)
                cur.begin()
                res = cur.execute(query)
                rows = res.fetchone()
                cur.rollback()
            end_time = time.time()
            tot_time = end_time - start_time
            times.append(tot_time)
#    cur.rollback()
    except "Invalid|You've encountered an internal MotherDuck error" as e:
        print(e)
        pass
    except:    
        print("Unexpected error:", sys.exc_info()[0])
        raise
    ind = 0
    #for x in times:
     #   ind = ind + 1
      #  print(f"Query {ind} times {x:.2f}")
    #print(f"Total time all queries {tot_time}")
#
# Beginning of main program
#
# disable the garbage collection to make it more consistent
gc.disable()

db_name = 'md:tpcds'
if len(sys.argv) < 2:
    db_name = db_name
else:
    db_name = sys.argv[1]
    
setup_duck.setup_duck('R')
#
# ------------- set up the parameters for the run here --------
#
num_threads = 1 #These determine how many threads
num_loops   = 1 # and how often the thread should execute
num_queries = 99  # How many of the 99 queries should execute
threads = []

print(f"Starting {sys.argv[0]}, DB {db_name} \n")
try:
    local_con = duckdb.connect(f"{db_name}")
except duckdb.duckdb.InvalidInputException as e:
    print ("------- Error occurred on connect-----\n", e)
except duckdb.duckdb.Error as e1:
    print("Error connecting", e)

local_con = duckdb.connect(f"{db_name}")
row = local_con.execute('pragma md_version').fetchone()
md_version = row[0]
print(f"DuckDB {duckdb.__version__}, {md_version} threads {num_threads}")

print(f"loops {num_loops}, num queries {num_queries} Total queries {num_queries * num_threads * num_loops}")

for i in range(num_threads):
#    local_con = duckdb.connect(f"{db_name}?conn={i}")
#    local_con = duckdb.connect(f"{db_name}")
    try:
        con = local_con.cursor()
    except duckdb.duckdb.InvalidInputException as e:
        print ("error occurred on connect", e)
    except duckdb.duckdb.Error as e1:
        print("Error connecting", e)
    except:    
        print("Unexpected error:", sys.exc_info()[0])
        raise
    thread = threading.Thread(target=query_from_thread,
        args=(con,num_loops,num_queries))
    threads.append(thread)
for thread in threads:
    thread.start()

startCPU   = time.process_time_ns()
start_time = time.time()
nets = psutil.net_io_counters()
packets_start_send = nets[2]
packets_start_recv = nets[3]

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

rows = con.execute("select count(*) from inventory").fetchone()
print (f"Count of INVENTORY {rows[0]}")

print(f"Packets sent {packets_total_send} \
received {packets_total_recv} Total packets {packets_total}")
packs = f"{packets_total_send} {packets_total_recv} {packets_total}"
print(f"CPU time: {(endCPU - startCPU) / 1000000000:.2f}")
print(f"{sys.argv[0]} time: {end_time - start_time:.2f} seconds")
print(f"{end_time - start_time:.2f} {(endCPU - startCPU) / 1000000000:.2f} {packs} {db_name} {datetime.date.today()} {md_version} ")
#print(f"{end_time - start_time:.2f} {(endCPU - startCPU) / 1000000000:.2f} {packs} {db_name} {datetime.date.today()} {duckdb.__version__}")
