import DuckDB

con1 = duckdb.connect('md:')
con2 = duckdb.connect('md:')
con3 = duckdb.connect('md:')
con4 = duckdb.connect('md:')

rows1 = con1.execute('select * from duckdb_settings()')
rows2 = con2.execute('select * from duckdb_settings()')
rows3 = con3.execute('select * from duckdb_settings()')
rows4 = con4.execute('select * from duckdb_settings()')
