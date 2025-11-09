import streamlit as st
import duckdb

# Connect to the DuckDB database
conn = duckdb.connect("md:tpcds") 

# Get a list of available tables
tables = conn.execute("SHOW TABLES").fetchdf()

# Create a dropdown menu to select the table
selected_table = st.selectbox("Select Table", tables)

# Fetch data from the selected table
query = f"SELECT * FROM {selected_table}"
data = conn.execute(query).fetchdf()

# Display the data using Streamlit
st.title(f"Data from {selected_table}")
st.dataframe(data)

# Close the database connection
conn.close()