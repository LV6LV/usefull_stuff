#!/bin/bash

# Send the command to the server and save the response
response=$(curl "<site>")

# Parse AWS Access Key ID
# The grep searches for 'Access Key', then awk prints everything after "Access Key: "
AWS_ACCESS_KEY_ID=$(echo "$response" | grep 'Access Key:' | awk -F'Access Key: ' '{print $2}' | cut -d '<' -f 1)

# Parse AWS Secret Access Key
# Similar to the Access Key, but searching for 'Secret Key' and extracting the part after it
AWS_SECRET_ACCESS_KEY=$(echo "$response" | grep 'Secret Key:' | awk -F'Secret Key: ' '{print $2}' | cut -d '<' -f 1)

echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
