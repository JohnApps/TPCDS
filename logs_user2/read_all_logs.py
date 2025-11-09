import os
import glob

def get_last_line(filepath):
    """Reads and returns the last line of a file. Returns None if the file is empty or doesn't exist."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:  # Handle various encodings
            try:
                # Efficiently get the last line without reading the whole file into memory
                for last_line in f:
                    pass  # This loop just iterates to the last line
                return last_line.strip() if last_line else None # Remove potential trailing newline
            except UnicodeDecodeError:
                print(f"Warning: UnicodeDecodeError encountered in {filepath}. Trying latin-1 encoding.")
                with open(filepath, 'r', encoding='latin-1') as f:
                    for last_line in f:
                        pass
                    return last_line.strip() if last_line else None
    except FileNotFoundError:
        print(f"Error: File not found: {filepath}")
        return None
    except Exception as e: # Catching potential other exceptions
        print(f"An error occurred while reading {filepath}: {e}")
        return None

def get_last_lines_from_logs(directory):
    """Gets the last lines from all *.log files in a directory."""
    log_files = glob.glob(os.path.join(directory, "*.log"))
    results = {}

    if not log_files:
        print(f"No .log files found in directory: {directory}")
        return {}

    for log_file in log_files:
        last_line = get_last_line(log_file)
        results[log_file] = last_line

    return results

if __name__ == "__main__":
    directory = "."  # Current directory. Change as needed.
    last_lines = get_last_lines_from_logs(directory)

    for filepath, last_line in last_lines.items():
        if last_line is not None:
            print(f"{filepath} {last_line}")
        else:
            print(f"Could not read last line from {filepath}")