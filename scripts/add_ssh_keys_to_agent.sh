#!/bin/bash

# Define the SSH keys directory
KEYS_DIR="$HOME/.ssh"

# Check if the SSH keys directory exists
if [ ! -d "$KEYS_DIR" ]; then
  echo "Error: directory $KEYS_DIR does not exist."
  exit 1
fi

# Start ssh-agent if it is not already running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  echo "Starting ssh-agent..."
  eval "$(ssh-agent -s)"
fi

# Add only valid private keys from the ~/.ssh directory to ssh-agent
for key in "$KEYS_DIR"/*; do
  # Check if the file is a private SSH key (not a .pub file and starts with correct key header)
  if [[ -f "$key" && "$key" != *.pub ]]; then
    # Check for valid private key format by looking for specific key headers
    if grep -qE "^-----BEGIN (RSA|DSA|EC|OPENSSH) PRIVATE KEY-----" "$key"; then
      echo "Adding key $key to ssh-agent..."
      ssh-add "$key"
    else
      echo "Skipping $key - not a valid SSH private key."
    fi
  fi
done

echo "All valid private keys from $KEYS_DIR have been added to ssh-agent."
