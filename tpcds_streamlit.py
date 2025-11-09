# tpcds_streamlit.py
import streamlit as st
import duckdb
import pandas as pd
import plotly.express as px

# Connect to MotherDuck
conn = duckdb.connect("md:tpcds")

# Streamlit UI
st.title("TPC-DS on MotherDuck")

# User input query
query = st.text_area("Enter your SQL query using PRAGMA TPCDS():", "PRAGMA TPCDS(scale=1);")

if st.button("Run Query"):
    try:
        # Execute query
        df = conn.execute(query).fetchdf()

        # Display DataFrame
        st.write("Query Results:", df)

        # Plot data if numeric columns exist
        numeric_columns = df.select_dtypes(include=["number"]).columns
        if len(numeric_columns) > 0:
            st.write("Plotting Data:")
            fig = px.line(df, x=df.columns[0], y=numeric_columns)
            st.plotly_chart(fig)
    except Exception as e:
        st.error(f"Error executing query: {e}")
