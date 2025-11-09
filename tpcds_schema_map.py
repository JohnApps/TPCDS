import networkx as nx
import matplotlib.pyplot as plt

# Define TPC-DS tables and their relationships
tables = [
    "store_sales", "store_returns", "catalog_sales", "catalog_returns", 
    "web_sales", "web_returns", "inventory",
    "store", "call_center", "catalog_page", "web_site", "web_page",
    "warehouse", "customer", "customer_address", "customer_demographics",
    "date_dim", "household_demographics", "item", "income_band", 
    "promotion", "reason", "ship_mode", "time_dim"
]

relationships = [
    ("store_sales", "store"),
    ("store_sales", "customer"),
    ("store_sales", "date_dim"),
    ("store_sales", "item"),
    ("store_returns", "store"),
    ("store_returns", "customer"),
    ("store_returns", "date_dim"),
    ("store_returns", "item"),
    ("catalog_sales", "call_center"),
    ("catalog_sales", "customer"),
    ("catalog_sales", "date_dim"),
    ("catalog_sales", "item"),
    ("catalog_returns", "call_center"),
    ("catalog_returns", "customer"),
    ("catalog_returns", "date_dim"),
    ("catalog_returns", "item"),
    ("web_sales", "web_site"),
    ("web_sales", "customer"),
    ("web_sales", "date_dim"),
    ("web_sales", "item"),
    ("web_returns", "web_site"),
    ("web_returns", "customer"),
    ("web_returns", "date_dim"),
    ("web_returns", "item"),
    ("inventory", "warehouse"),
    ("inventory", "date_dim"),
    ("inventory", "item"),
    ("customer", "customer_address"),
    ("customer", "customer_demographics"),
    ("customer", "household_demographics"),
    ("customer", "income_band"),
]

# Create a graph
G = nx.Graph()

# Add nodes (tables)
for table in tables:
    G.add_node(table)

# Add edges (relationships)
G.add_edges_from(relationships)

# Set up the plot
plt.figure(figsize=(20, 20))
pos = nx.spring_layout(G, k=0.5, iterations=50)

# Draw the graph
nx.draw(G, pos, with_labels=True, node_color='lightblue', 
        node_size=3000, font_size=8, font_weight='bold')

# Add edge labels
edge_labels = {(u, v): '' for (u, v) in G.edges()}
nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels)

# Show the plot
plt.title("TPC-DS Schema Diagram", fontsize=20)
plt.axis('off')
plt.tight_layout()
plt.show()