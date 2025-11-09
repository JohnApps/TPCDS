# tpcds_connect_dbs.py
# connect to lots of databases

import duckdb
from datetime import datetime
import time

# tpcds01 is the master to be copied
tpcds_01 = 'md:tpcds01'
con = duckdb.connect('md:')

beg = time.time()
for i in range(1,10):
    db_name ="tpcds_000"+str(i)
    con_name= "con_000"+str(i)
    con_name = duckdb.connect(f"md:{db_name}?con={i},blabla")
    cur_name = con_name.cursor()
for idx in range(1,100):
	for i in range (1,10):
		rows = cur_name.execute(f"select * from customer limit 1").fetchall()
#		for row in rows:
#			print(f"c_customer_sk is {row[0]}")

end = time.time()
print(f"\nThis all took {end-beg:.2f} seconds to connect and read the  DBs")

