import duckdb

# Connect to local DuckDB database
local_conn = duckdb.connect('tpcds.db')

# Connect to MotherDuck
md_conn = duckdb.connect('md:')

# Ensure the MotherDuck connection uses the correct database
md_conn.execute("USE tpcds")

def two_phase_commit():
    try:
        # Phase 1: Prepare
        md_conn.execute("BEGIN TRANSACTION")
        
        # Get data from local inventory table
        local_data = local_conn.execute("SELECT * FROM inventory").fetchall()
        print("number rows, ",len(local_data)")
        # Prepare the update statement
        update_stmt = """
        UPDATE inventory 
        SET inv_quantity_on_hand = ?, 
            inv_date_sk = ?
        WHERE inv_item_sk = ? AND inv_warehouse_sk = ?
        """
        
        # Execute updates
        for row in local_data:
            md_conn.execute(update_stmt, [row[2], row[3], row[0], row[1]])
        
        # Phase 2: Commit
        md_conn.execute("COMMIT")
        print("Update successful")
    
    except Exception as e:
        # If any error occurs, rollback the transaction
        md_conn.execute("ROLLBACK")
        print(f"Error occurred, transaction rolled back: {str(e)}")

# Execute the two-phase commit
two_phase_commit()

# Close connections
local_conn.close()
md_conn.close()