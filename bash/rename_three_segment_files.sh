#!/bin/bash
# Description: Recursively renames files in the given folder that follow the pattern
#              stringA.stringB.stringC, renaming them to stringA.stringC.
#              Each string (A, B, C) must be non-empty and contain no dots.

# Check that exactly one argument (the folder path) is provided.
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/folder"
    exit 1
fi

folder="$1"

# Verify that the provided argument is a directory.
if [ ! -d "$folder" ]; then
    echo "Error: '$folder' is not a valid directory."
    exit 1
fi

# Recursively find all files in the given folder.
find "$folder" -type f | while read -r file; do
    filename=$(basename "$file")
    dir=$(dirname "$file")

    # Use regex to match the filename pattern:
    # ^([^\.]+)\.([^\.]+)\.([^\.]+)$
    # where each capture group represents a non-empty string without a dot.
    if [[ "$filename" =~ ^([^\.]+)\.([^\.]+)\.([^\.]+)$ ]]; then
        newname="${BASH_REMATCH[1]}.${BASH_REMATCH[3]}"

        # Only rename if the new name is different
        if [ "$filename" != "$newname" ]; then
            mv "$file" "$dir/$newname"
            echo "Renamed: '$file' -> '$dir/$newname'"
        fi
    fi
done
