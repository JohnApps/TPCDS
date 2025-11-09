# tpcds_walk_inventory.py
import duckdb
import os
import time

def read_inventory_in_batches(conn, batch_size=100):
    """
    Read inventory table from TPC-DS database in batches of 100 rows.
    Args:
        conn (duckdb.DuckDBPyConnection): Active database connection
        batch_size (int): Number of rows to fetch per batch
    Yields:
        tuple: (batch of rows, time taken to fetch batch)
    """
    offset = 0
    while True:
        start_time = time.time()
        query = f"""
        SELECT * FROM inventory 
        LIMIT {batch_size} 
        OFFSET {offset}
        """
        batch = conn.execute(query).fetchall()
        if not batch:
            break
        end_time = time.time()
        time_taken = end_time - start_time
        yield batch, time_taken
        offset += batch_size

def main():
    # Configure MotherDuck connection
#    motherduck_token = os.getenv('MOTHERDUCK_TOKEN')
    conn_str = 'md:'
    
    total_batches = 0
    total_time = 0
    
    try:
        # Establish connection
        conn = duckdb.connect(conn_str)
        # Set database context to TPC-DS
        conn.execute("USE tpcds")
        # Process batches
        for batch_number, (batch, batch_time) in enumerate(read_inventory_in_batches(conn), 1):
#            print(f"Batch {batch_number}:")
            # Uncomment the following if you want to print rows
            # for row in batch:
            #     print(row)
#            if (batch_number % 1000) == 0:
#                print(f"Time taken to read batch: {batch_time:.4f} seconds")
#                print("-" * 50, batch_number)
            total_batches += 1
            total_time += batch_time
    
    except Exception as e:
        print(f"Error: {e}")
    
    finally:
        if 'conn' in locals():
            conn.close()
        
        # Print summary statistics
        if total_batches > 0:
            print(f"\nSummary:")
            print(f"Total batches processed: {total_batches}")
            print(f"Total time: {total_time:.4f} seconds")
            print(f"Average time per batch: {total_time/total_batches:.4f} seconds")

if __name__ == "__main__":
    main()