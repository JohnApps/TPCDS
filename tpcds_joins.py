from sqlalchemy import create_engine, MetaData, Table
from sqlalchemy.orm import sessionmaker
from sqlalchemy.sql import select
import duckdb

# Create a connection to the TPC-DS database
engine = create_engine('duckdb:///md:tpcds')
metadata = MetaData()
Session = sessionmaker(bind=engine)
session = Session()

# Define the tables
inventory = Table('inventory', metadata, autoload_with=engine)
customer = Table('customer', metadata, autoload_with=engine)
warehouse = Table('warehouse', metadata, autoload_with=engine)

# Print table schemas
print("## Inventory Table Schema")
for column in inventory.columns:
    print(f"{column.name}: {column.type}")

print("\n## Customer Table Schema")
for column in customer.columns:
    print(f"{column.name}: {column.type}")

print("\n## Warehouse Table Schema")
for column in warehouse.columns:
    print(f"{column.name}: {column.type}")

# Print relationships
print("\n## Relationships")
print("inventory.inv_warehouse_sk -> warehouse.w_warehouse_sk")
print("inventory.inv_item_sk -> item.i_item_sk (not shown in this example)")

# Sample data from each table
print("\n## Sample Data")
for table in [inventory, customer, warehouse]:
    print(f"\n{table.name.capitalize()} (first 5 rows):")
    result = session.execute(select(table).limit(5))
    for row in result:
        print(row)

session.close()