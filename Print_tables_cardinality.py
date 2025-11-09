# Print_tables_cardinality.py
import duckdb
import sys

db_name = "md:tpcds"

if len(sys.argv) < 2:
# Connect to the MotherDuck TPCDS database
    db_name = "md:tpcds"
else:
    db_name = sys.argv[1]

conn = duckdb.connect(db_name)

# Get a list of all tables in the database
table_names = conn.execute("SHOW TABLES").fetchall()

# Iterate over each table and count the rows
print(f"Table_name,        row_count")
for table_name in table_names:
    table_name = table_name[0]  # Extract the table name from the tuple
    row_count = conn.execute(f"SELECT COUNT(*) FROM {table_name}").fetchone()[0]
    print(f"{table_name:22} , {row_count}")