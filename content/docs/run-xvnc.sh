#!/bin/bash
set -xv
./run-xvbf.sh
sudo apt install x11vnc
x11vnc -storepasswd
ll /home/ubuntu/.vnc/passwd
loginctl
sudo nano /etc/systemd/system/x11vnc.service
sudo systemctl daemon-reload
sudo systemctl enable x11vnc.service
sudo systemctl start x11vnc.service
sudo systemctl status x11vnc.service
exit 0
