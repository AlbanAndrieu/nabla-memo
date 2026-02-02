#!/bin/bash
set -xv
sudo pip install --upgrade ansible-cmdb
sudo dmidecode -t 1|  cat
dmidecode -s bios-vendor
mkdir target reports
ansible -i envs/uat/inventory.ini -m setup --tree target/ all
ansible-cmdb -d -i envs/uat/inventory.ini target/ > reports/overview.html
python -m http.server
exit 0
