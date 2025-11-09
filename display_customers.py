import duckdb

def display_customers():
    # Connect to the TPC-DS database
    conn = duckdb.connect('md:tpcds')
    
    # Query the customer table
    result = conn.execute("SELECT * FROM customer LIMIT 10")
    
    # Fetch and display the results
    rows = result.fetchall()
    for row in rows:
        print(row)
    
    # Close the connection
    conn.close()

if __name__ == "__main__":
    display_customers()
