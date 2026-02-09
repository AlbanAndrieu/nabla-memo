#!/bin/bash
set -xv

# Configuration Management Database (CMDB)

sudo pip install --upgrade ansible-cmdb

# See https://www.servicenow.fr/
#srvcnow

sudo dmidecode -t 1 | cat
dmidecode -s bios-vendor

# See https://en.wikipedia.org/wiki/IBM_BigFix
# https://www.hcltechsw.com/bigfix

mkdir target reports
ansible -i envs/uat/inventory.ini -m setup --tree target/ all
ansible-cmdb -d -i envs/uat/inventory.ini target/ >reports/overview.html
python -m http.server

exit 0
