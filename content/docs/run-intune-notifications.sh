#!/bin/bash

# Check if GNOME is running
if [ "$(echo $XDG_CURRENT_DESKTOP)" = "GNOME" ]; then
  # Disable notifications on the lock screen
  gsettings set org.gnome.desktop.notifications show-in-lock-screen false

  # Check if the setting was applied successfully
  if [ "$(gsettings get org.gnome.desktop.notifications show-in-lock-screen)" = "false" ]; then
    echo "Lock screen notifications disabled successfully."
    exit 0 # Success
  else
    echo "Failed to disable lock screen notifications."
    exit 1 # Failure
  fi
else
  echo "GNOME is not the current desktop environment. No changes made."
  exit 2 # GNOME not running
fi
