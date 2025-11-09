# TPC-DS Benchmark for DuckDB
# This is the Moonshot KIMI version
This package contains an enhanced TPC-DS benchmark suite for DuckDB with query timeout support.

## Quick Start

1. Install dependencies: `pip install -r requirements.txt`
2. Configure: Edit `config.ini` or use command-line arguments
3. Prepare data: Ensure `tpcds_local.db` exists with TPC-DS schema
4. Place queries: Put q01.sql..q99.sql in the `tpcds_queries/` directory
5. Run: `python cop_tpcds_enhanced.py`

## Configuration

Edit `config.ini` or use CLI args:
- `--db-path`: Path to DuckDB database
- `--queries-dir`: Directory containing SQL files
- `--query-range`: Range to execute (e.g., "1-50" or "1,5,10-20")
- `--sample-interval`: Resource monitoring frequency
- `--query-timeout`: Per-query timeout in seconds (0 to disable)
- `--warmup`: Enable warm-up runs
- `--no-warmup`: Disable warm-up runs
- `--export-plans`: Export query execution plans (default: enabled)
- `--no-export-plans`: Disable query plan export
- `--package`: Create download package after run

## Output

Results are saved to `tpcds_results/`:
- `tpcds_query_summary_with_metrics.csv`: Full performance metrics
- `tpcds_table_row_counts.csv`: Table statistics
- `tpcds_benchmark_summary.csv`: Statistical summary
- `query_plans/`: Execution plans (if enabled)
- `*.png`: Performance visualizations
- `benchmark_package.zip`: Self-contained download package (if --package used)

## Timeout Mechanism

Since DuckDB doesn't natively support statement timeouts, this benchmark uses Python's threading to interrupt queries that exceed the time limit. Set `--query-timeout 0` to disable.

## API Compatibility

This script uses `fetch_df_chunk()` which requires DuckDB >= 0.7.0. For older versions, it will fall back to `fetchdf()`.
# TPC-DS Benchmark for DuckDB

This package contains an enhanced TPC-DS benchmark suite for DuckDB.

## Quick Start

1. Install dependencies: `pip install -r requirements.txt`
2. Configure: Edit `config.ini` or use command-line arguments
3. Prepare data: Ensure `tpcds_local.db` exists with TPC-DS schema
4. Place queries: Put q01.sql..q99.sql in the `tpcds_queries/` directory
5. Run: `python cop_tpcds_enhanced.py`

## Configuration

Edit `config.ini` or use CLI args:
- `--db-path`: Path to DuckDB database
- `--queries-dir`: Directory containing SQL files
- `--query-range`: Range to execute (e.g., "1-50" or "1,5,10-20")
- `--sample-interval`: Resource monitoring frequency
- `--query-timeout`: Per-query timeout in seconds
- `--warmup`: Enable/disable warm-up runs
- `--export-plans`: Export query execution plans

## Output

Results are saved to `tpcds_results/`:
- `tpcds_query_summary_with_metrics.csv`: Full performance metrics
- `tpcds_table_row_counts.csv`: Table statistics
- `tpcds_benchmark_summary.csv`: Statistical summary
- `query_plans/`: Execution plans (if enabled)
- `*.png`: Performance visualizations
- `benchmark_package.zip`: Self-contained download package
