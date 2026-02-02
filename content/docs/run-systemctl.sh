#!/bin/bash
set -xv
sudo systemctl disable apport-autoreport.service
sudo -i geany /etc/default/apport
sudo apt purge apport
systemctl list-unit-files
ls -lrta /etc/systemd/system/
nano /lib/systemd/system/docker.service
systemctl cat docker.service
systemctl list-units --type service
systemctl list-units --failed
sudo systemctl status snap.bluez.bluez.service
systemctl --no-pager status
sudo systemctl daemon-reload
sudo systemd-analyze time
sudo systemd-analyze plot > /home/albandrieu/Downloads/file.svg
sudo systemd-analyze blame
sudo apt-get install systemd-boothart
ll /lib/systemd/systemd-bootchart
cp /run/log/bootchart-20210526-1003.svg ~/Downloads/
sudo journalctl -r -p err --since="today"
systemctl --user list-unit-files
systemctl --user list-jobs
exit 0
