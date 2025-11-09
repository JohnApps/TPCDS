from flask import Flask, render_template, request
import duckdb

app = Flask(__name__)

# Connect to the DuckDB database
conn = duckdb.connect('ver.db', read_only=True)

@app.route('/H:\\duckdb\\tpcds\\index.html')
def index():
    # Execute a sample query (replace with your desired query)
    query = "SELECT * FROM ver order by verno desc LIMIT 10" 
    df = conn.execute(query).fetchdf() 
    return render_template('index.html', data=df.to_html(index=False)) 

if __name__ == '__main__':
    app.run(debug=True)