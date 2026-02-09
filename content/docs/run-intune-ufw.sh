#!/bin/bash

# Enable UFW
ufw enable

# Check if UFW was enabled successfully
if ufw status | grep -qw "active"; then
  echo "UFW is now active."
  exit 0 # Exit code 0 for success
else
  echo "Failed to activate UFW."
  exit 1 # Exit code 1 for general errors
fi

sudo ufw allow 24800
# sudo ufw allow 22
