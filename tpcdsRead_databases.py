# tpcds_read_dbs.py

import duckdb
import time
from datetime import datetime

print(f"Here we go at {datetime.today()}")
con = duckdb.connect('md:')
beg = time.time()
for i in range(1,10):
    db_name ="tpcds_000"+str(i)
    rows = con.execute(f"select c_customer_sk \
                      from {db_name}.customer limit 1").fetchall()
    for row in rows:
        customer_sk = row[0]
        rows = con.execute \
        (f"select inv_item_sk from customer,store_sales,inventory \
        where ss_customer_sk = c_customer_sk and ss_item_sk = inv_item_sk \
            and c_customer_sk = {customer_sk} limit 1;").fetchall()
        for row in rows:
            print(f"Item is {row[0]}")
end = time.time()
print(" ")
print (f"select on customer key in {end-beg:.2f} seconds")
    