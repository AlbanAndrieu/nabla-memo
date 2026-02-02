#!/bin/bash
ufw enable
if ufw status|  grep -qw "active";then
  echo "UFW is now active."
  exit 0
else
  echo "Failed to activate UFW."
  exit 1
fi
sudo ufw allow 24800
