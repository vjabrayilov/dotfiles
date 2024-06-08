#!/bin/bash

# Check if environment variables are set
if [[ -z "$GITHUB_EMAIL" || -z "$GITHUB_TOKEN" ]]; then
    echo "GITHUB_EMAIL and GITHUB_TOKEN environment variables must be set."
    exit 1
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if ssh-keygen is installed
if ! command_exists ssh-keygen; then
    echo "ssh-keygen not found. Please install it first."
    exit 1
fi

# Generate SSH key
ssh-keygen -t rsa -b 4096 -C "$GITHUB_EMAIL" -f ~/.ssh/id_rsa -N ""

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add the SSH key to the ssh-agent
ssh-add ~/.ssh/id_rsa

# Copy the SSH key to a variable
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)

# Debugging information
echo "GITHUB_EMAIL: $GITHUB_EMAIL"
echo "SSH_KEY: $SSH_KEY"
echo "GITHUB_TOKEN: $GITHUB_TOKEN"

# Add SSH key to GitHub using API
response=$(curl -s -o response.txt -w "%{http_code}" -u "$GITHUB_EMAIL:$GITHUB_TOKEN" \
    -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/user/keys \
    -d "{\"title\":\"My Computer SSH Key\",\"key\":\"$SSH_KEY\"}")

# Output response for debugging
cat response.txt

if [ "$response" -eq 201 ]; then
    echo "SSH key added to your GitHub account successfully."
else
    echo "Failed to add SSH key to your GitHub account. HTTP response code: $response"
fi

