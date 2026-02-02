#!/bin/bash
set -xv
wget https://github.com/rfxn/linux-malware-detect/archive/refs/tags/1.6.6.1.tar.gz
tar xvf linux-malware-detect-1.6.6.1.tar.gz
sudo ./install.sh
sudo maldet -a /
sudo apt install inotify-tools
sudo maldet --monitor /tmp
sudo maldet -l
sudo crontab -e
0 0 * * * /usr/local/sbin/maldet -a /|  ansi2html -l > /var/www/nabla/public/reports/maldet-report.html
./run-clamav.sh
systemctl disable maldet.service
exit 0
