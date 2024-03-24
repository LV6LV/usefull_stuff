#!/bin/bash

# Replace <site> with the actual URL you're querying
response=$(curl <site>)

# Extract the Access Key using grep and cut
# This command looks for the line containing "Access Key:", then cuts the string to extract the key
AWS_ACCESS_KEY_ID=$(echo "$response" | grep 'Access Key:' | cut -d '>' -f3 | cut -d '<' -f1)

# Extract the Secret Key using grep and cut
# Similar to the Access Key, but searches for "Secret Key:" instead
AWS_SECRET_ACCESS_KEY=$(echo "$response" | grep 'Secret Key:' | cut -d '>' -f3 | cut -d '<' -f1)

echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
