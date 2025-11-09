# tpcds_create_dbs.py
# create lots of databases

import duckdb
from datetime import datetime
import time

# tpcds01 is the master to be copied
tpcds_01 = 'md:tpcds01'
con = duckdb.connect('md:')

beg = time.time()
for i in range (1,10):
    db_name ="tpcds_000"+str(i)
    rows = con.execute(f"create database {db_name}");
    ress = con.execute(f"copy from database tpcds_c to {db_name}")
end = time.time()
print(f"This all took {end-beg} seconds to create the DBs")

