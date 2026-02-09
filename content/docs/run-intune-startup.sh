#!/bin/bash

# Path to the application's .desktop file
APPLICATION_PATH="/usr/share/applications/intune-portal.desktop"

# Autostart directory for the current user
AUTOSTART_DIR="$HOME/.config/autostart"

# Check if the Autostart directory exists, if not, create it
if [ ! -d "$AUTOSTART_DIR" ]; then
  mkdir -p "$AUTOSTART_DIR"
fi

# Create a symbolic link of the .desktop file in the Autostart directory
ln -s "$APPLICATION_PATH" "$AUTOSTART_DIR/intune-portal.desktop" 2>/dev/null

# Check if the symbolic link was created successfully
if [ $? -eq 0 ]; then
  echo "Intune-Portal has been added to startup applications."
  exit 0 # Exit with code 0 (success)
else
  echo "Failed to add Intune-Portal to startup applications. The link might already exist or there was an error creating it."
  exit 1 # Exit with code 1 (failure)
fi
