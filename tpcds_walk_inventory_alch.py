# tpcds_walk_inventory_alch.py
import os
import time
from sqlalchemy import create_engine, text
from sqlalchemy.orm import Session
from typing import Generator, Dict, Any, Union

def read_inventory_in_batches(connection_string: str, batch_size: int = 100) -> Generator[Union[Dict[str, Any], Dict[str, Union[int, float]]], None, None]:
    """
    Read inventory table from TPC-DS database in MotherDuck in batches.
    Args:
        connection_string (str): MotherDuck connection string
        batch_size (int): Number of rows to fetch per batch
    Yields:
        Batches of inventory rows or final statistics
    """
    start_time = time.time()
    total_rows = 0
    # Create SQLAlchemy engine
    engine = create_engine(connection_string)
    # Create a session
    with Session(engine) as session:
        # Query to count total rows in inventory table
        total_count = session.execute(text("SELECT COUNT(*) as count FROM inventory")).scalar()
        # Query to select from inventory table
        query = text("SELECT * FROM inventory")
        # Use yield_per for memory-efficient batch processing
        result = session.execute(query).yield_per(batch_size)
        for row in result:
           # print (row[0])
            total_rows += 1
           # yield dict(row)
           # yield result
    
    # Yield final statistics
    end_time = time.time()
    yield {
        'total_rows': total_rows, 
        'total_time': end_time - start_time,
        'total_count': total_count
    }

def main():
    # Retrieve MotherDuck connection string from environment variable
#    connection_string = os.getenv('MOTHERDUCK_CONNECTION_STRING')
    connection_string = "duckdb:///md:tpcds"
    
    if not connection_string:
        raise ValueError("MotherDuck connection string not found in environment variables")
    
    # Iterate through batches of inventory data
    batches_processed = 0
    for result in read_inventory_in_batches(connection_string):
        # Check if this is the final iteration with total stats
        if 'total_rows' in result:
            print(f"\nTotal Expected Rows: {result['total_count']}")
            print(f"Total Processed Rows: {result['total_rows']}")
            print(f"Total Processing Time: {result['total_time']:.2f} seconds")
            break
        
        batches_processed += 1
        print(f"Batch {batches_processed}:")
        print(result)
        
        # Optional: Limit to first few batches for demonstration
        if batches_processed >= 3:
            break

if __name__ == "__main__":
    main()