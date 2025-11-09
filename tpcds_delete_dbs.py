# tpcds_delete_dbs.py
# delete lots of databases

import duckdb
from datetime import datetime
import time
# tpcds02 is the master to be copied

con = duckdb.connect('md:')

beg = time.time()
for i in range (1,100):
    db_name ="tpcds_000"+str(i)
    rows = con.execute(f"drop database {db_name}");
end = time.time()

print(f"Deleting these DBs took {end-beg} seconds")

    