# tpcds_walk_inventoy.py
# Let's try using limit and offset to walk the 
# inventory table
import duckdb
import time
import datetime
import sys

offset = 0  # how many rows to skip
limit  = 100 # how many rows to fetch
inv_cnt= 0  # count the nunber of rows read so far

db_name = 'md:tpcds'
con     = duckdb.connect(db_name)
cur     = con.cursor()
print(f"Starting {sys.argv[0]} with {db_name} \
    at {datetime.datetime.now()}")

beg = time.time()
try:
    while 1:
        rows = cur.execute(f"select inv_item_sk \
            from inventory order by inv_item_sk \
            limit {limit} offset {offset}").fetchall()
        if len(rows) > 0:
            for row in rows:
                inv_cnt = inv_cnt + row[0]
                if inv_cnt%5000 == 0:
                    print("inv_cnt is", \
                        inv_cnt, datetime.datetime.now())
        else:
            break
        offset = offset + limit
 
except KeyboardInterrupt as e:
    print("keyboard interrupt")
    con.commit
    con.close
end = time.time()

