# while_update_tpcds_share.py
import duckdb
import time
import sys

loops   = 10000
loopcnt = 0
db_name = 'md:tpcds'
if len(sys.argv) < 2:
    db_name = 'md:tpcds'
else:
    db_name = sys.argv[2]
    
print(f"Starting {sys.argv[0]} with {duckdb.__version__}")

con = duckdb.connect(db_name)
cur = con.cursor()
start = time.time()
for loopcnt in range(loops):
    res = cur.execute("update share tpcds")
    time.sleep(10)
    
end = time.time()
tot = end = start
print(f"Total running time: {tot}")
