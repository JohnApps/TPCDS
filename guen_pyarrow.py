# guen_pyarrow.py
import duckdb
import pyarrow as pa
import pyarrow.compute as pc
import sys
import time
import psutil
import threading
import random

# Create initial table
data = {
    'id'        : pa.array([1]),
    'decimalnr' : pa.array([1])
    'date'      : pa.array(['2024-01-01'])
    'time'      : pa.array(['00:00:00'])
    'comment'   : pa.array(['comment'])
}
my_arrow = pa.Table.from_pydict(data)

def get_letter(n):
    return chr(ord('A') + n % 26)

# Update values and grow table in a loop
for id in range(10_000):
    id += 1 # start with 1
    new_row = pa.Table.from_pydict({
        'id'        : [id],
        'decimalnr' : [9],  # New rows start with value 0
        'date'      : [datetime.now()],
        'time'      : [datetime.now()],
        'comment'   : ['this is a comment']
        
    })
    my_arrow = pa.concat_tables([my_arrow, new_row])

#con = duckdb.connect("pyarrow.db")
con = duckdb.connect("md:pyarrow")

# create the table "my_table" from the DataFrame "my_arrow"
duckdb.sql("CREATE TABLE if not exists my_table AS SELECT * FROM my_arrow")

# insert into the table "my_table" from the DataFrame "my_arrow"
res = con.execute("INSERT INTO my_table SELECT * FROM my_arrow")

rows = con.execute("select count(*) recs from my_table")
row = rows.fetchall()
print(row[0])
print(duckdb.sql("FROM my_table"))