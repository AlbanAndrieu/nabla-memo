#!/bin/bash
APPLICATION_PATH="/usr/share/applications/intune-portal.desktop"
AUTOSTART_DIR="$HOME/.config/autostart"
if [ ! -d "$AUTOSTART_DIR" ];then
  mkdir -p "$AUTOSTART_DIR"
fi
ln -s "$APPLICATION_PATH" "$AUTOSTART_DIR/intune-portal.desktop" 2> /dev/null
if [ $? -eq 0 ];then
  echo "Intune-Portal has been added to startup applications."
  exit 0
else
  echo "Failed to add Intune-Portal to startup applications. The link might already exist or there was an error creating it."
  exit 1
fi
