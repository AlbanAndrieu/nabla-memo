#!/bin/bash
if [ "$(echo $XDG_CURRENT_DESKTOP)" = "GNOME" ];then
  gsettings set org.gnome.desktop.notifications show-in-lock-screen false
  if [ "$(gsettings get org.gnome.desktop.notifications show-in-lock-screen)" = "false" ];then
    echo "Lock screen notifications disabled successfully."
    exit 0
else
    echo "Failed to disable lock screen notifications."
    exit 1
fi
else
  echo "GNOME is not the current desktop environment. No changes made."
  exit 2
fi
