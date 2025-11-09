# tpcds_alch_chunk_read.py

from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker

# Configure the database connection
DATABASE_URI = "duckdb:///md:tpcds"
engine = create_engine(DATABASE_URI)
Session = sessionmaker(bind=engine)

# Pagination function
def paginate_inventory(page_number, page_size=100):
    """
    Fetches a chunk of rows from the inventory table.
    :param page_number: The page number to fetch (1-indexed).
    :param page_size: Number of rows per page.
    :return: List of rows for the current page.
    """
    offset = (page_number - 1) * page_size
    query = f"""
        SELECT * FROM inventory
        ORDER BY inv_date_sk, inv_item_sk
        LIMIT {page_size} OFFSET {offset}
    """
    print(f"{offset}, {page_size}")
    with engine.connect() as conn:
        result = conn.execute(text(query))
        return [dict(row) for row in result]

# Example usage
if __name__ == "__main__":
    session = Session()
    
    # Fetch the first three pages as an example
    for page in range(1, 4):
        print(f"Page {page}:")
        rows = paginate_inventory(page)
        for row in rows:
            print(row)
