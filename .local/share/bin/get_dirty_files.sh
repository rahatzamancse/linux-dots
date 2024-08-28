#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <git_directory> <new_directory>"
  exit 1
fi

# Define the git directory and the new directory
git_directory="$1"
new_directory="$2"

# Change to the git directory
cd "$git_directory" || { echo "Git directory not found"; exit 1; }

# Create the new directory if it doesn't exist
mkdir -p "$new_directory"

# Get the list of dirty files and copy them
git status --porcelain | while read -r line; do
  # Extract the file path from the status line
  file="${line:3}"

  # Check if it's a new file
  if [[ $line == "?? "* ]]; then
    # It's a new file, copy it
    cp --parents "$file" "$new_directory"
  else
    # It's a modified file, copy it
    cp --parents "$file" "$new_directory"
  fi
done

