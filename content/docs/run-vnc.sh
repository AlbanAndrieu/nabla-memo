#!/bin/bash
set -xv
sudo apt-get install vino
cd /home/albandri/.vnc
DISPLAY=:0 /usr/lib/vino/vino-server
sudo apt install xtightvncviewer
xtightvncviewer -viewonly -quality 5 -compresslevel 9 11.22.33.44:0
grep -i got .xsession-errors
exit 0
