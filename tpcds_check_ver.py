# while_sharever_check.py
#
import duckdb
from datetime import datetime
import time
import uuid
import psutil
import tracemalloc
import sys

# Function to subtract two timestamps
def subtract_timestamps(timestamp1, timestamp2):
    # Convert string timestamps to datetime objects
    dt1 = datetime.strptime(timestamp1, "%H:%M:%S")
    dt2 = datetime.strptime(timestamp2, "%H:%M:%S")
    # Calculate the difference
    time_difference = dt1 - dt2
    
    return time_difference

# disk I/O counters [0] and [1] for reads and writes
bdread  = 0
bdwrite = 0
edread  = 0
edwrite = 0
# network I/O counters [0] and [1] for sent and received
bnread  = 0
bnwrite = 0
enread  = 0
enwrite = 0
# memory counters
#https://www.geeksforgeeks.org/monitoring-memory-usage-of-a-running-python-program/
# tracemalloc.start()
# allocmem = tracemalloc.get_traced_memory()
# tracemalloc.stop()
curmem = 0  # [0] memory currently allocated
totmem = 0  # [1] total memory used

verno   = 0
loopcnt = 10000000
loops   = 0
FMT = '%H:%M:%S.%f'
md_token = "xxxxxxxxxxxxxxxxx"
db_name = 'md:verdb'
if len(sys.argv) < 2:
    verr = duckdb.connect(db_name)
else:
    verr = duckdb.connect(sys.argv[1])
verr.execute("load ICU")
verr.execute("set TimeZone='Europe/Berlin'")

con = duckdb.connect("md:tpcds")    

con.execute("load ICU")
con.execute("set TimeZone='Europe/Berlin'")
rows = con.execute \
  ("select max(verno)from ver").fetchall()
for row in rows:
    verno = row[0] 
vernew  = 0
print (f"tpcds VERNO {verno}\n")

while loops < loopcnt:
    beg = datetime.today()
    rows = con.execute \
        (f"select max(verno) from ver ").fetchall()
    for row in rows:
        vernew  = row[0] 
    rows = verr.execute("select max(verno) from ver").fetchall()
    for row in rows:
        verold = row[0]
    if verold < vernew:
        rows = con.execute \
            (f"select vertime,pgm from tpcds.ver \
               where verno = {vernew}").fetchall()
        for row in rows:
            vertime = row[0]
            verpgm  = row[1]
        print(f"Verno has changed from {verno} to {vernew}")
        print(f"Changed by program {verpgm}")
        print(f"Received update at {datetime.now().strftime('%H:%M:%S')} sent at {vertime}\n")
        print(f"{datetime.now().strftime('%H:%M:%S')} {vertime.strftime('%H:%M:%S')}")
        verno = vernew
        now = datetime.now()
        difference = subtract_timestamps( \
            datetime.now().strftime('%H:%M:%S'),
                vertime.strftime('%H:%M:%S'))   
        vertod = datetime.now().strftime('%H:%M:%S')
        print(f"Time difference: {difference}")
        print(f"Total seconds: {difference.total_seconds()}")
        diff = difference.total_seconds()
        if diff < 36000:
            stmt = f"insert into ver(verno,tod,diff,vertime,pgm) \
            values({verno}, '{vertod}',{diff}, \
            '{vertime}','{sys.argv[0]}')" 
            ins = verr.execute(stmt)
    loops = loops + 1
    
end = datetime.now()
tot = end - beg    
print (f"Thats total time after ", tot)
