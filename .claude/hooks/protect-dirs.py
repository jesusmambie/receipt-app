#! /usr/bin/env python3
import json, sys, os

data = json.load(sys.stdin)
tool = data.get("tool_name", "")
input_data = data.get("tool_input", {})

# Define directories or path fragments to protect
PROTECTED_PATHS = ["/prod/", "/deployment/"]

def is_in_protected_path(path):
    """Check if the given path is inside any protected directory."""
    # Normalize path for safety
    abs_path = os.path.abspath(path)
    for protected in PROTECTED_PATHS:
        if protected in abs_path:
            return True
    return False

# Decide based on tool type
if tool in ("Write", "Edit", "MultiEdit"):
    file_path = input_data.get("file_path", "") or ""
    if file_path and is_in_protected_path(file_path):
        sys.stderr.write(f"Error: Modifying files in protected path '{file_path}' is not allowed.\n")
        sys.exit(2)  # block the file write/edit

elif tool == "Bash":
    command = input_data.get("command", "") or ""
    # If the command string tries to operate in protected paths, block it
    for protected in PROTECTED_PATHS:
        if protected in command:
            sys.stderr.write("Error: Command involves a protected directory. Operation not allowed.\n")
            sys.exit(2)

# If none of the conditions matched, allow the operation
sys.exit(0)
