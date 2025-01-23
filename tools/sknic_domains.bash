#!/bin/bash

# Define the input files
file1="scope.txt"  # File containing lines to search for
file2="domains.txt"  # File in which to search for matches

wget --quiet https://www.sk-nic.sk/subory/domains.txt

# Loop through each line in file1
while IFS= read -r pattern; do
    # Use grep to find matches in file2
    owner=`grep -E "^${pattern};" "$file2" | cut -f 3 -d ';'`
    grep ";${owner}" "$file2"
done < "$file1"

rm domains.txt
