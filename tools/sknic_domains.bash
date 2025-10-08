#!/bin/bash

# Check if a domain was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain="$1"
file="domains.txt"

# Download the latest domain list
wget --quiet https://www.sk-nic.sk/subory/domains.txt -O "$file"

# Extract the owner of the given domain
owner=$(grep -E "^${domain};" "$file" | cut -f 3 -d ';')

# Check if owner was found
if [ -z "$owner" ]; then
    echo "Owner not found for domain: $domain"
    rm "$file"
    exit 1
fi

# Find and print all domains with the same owner
grep ";${owner}" "$file"

# Clean up
rm "$file"
