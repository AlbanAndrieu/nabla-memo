#!/bin/bash
set -xv
ssh -X home.albandrieu.com
ssh -X 10.20.0.101
ssh -X 192.168.1.1
pkg upgrade
rm -Rf /var/cache/pkg/*
rm *.core
rm /var/db/pfblockerng/ut1.tar.gz*
rm /var/db/pfblockerng/top-1m.csv
rm /var/db/pfblockerng/top-1m.csv.zip.raw
rm /var/db/crowdsec/data/crowdsec.db*
rm /var/db/crowdsec/data/GeoLite2-*.mmdb
echo "" > /var/log/haproxy.log
df -h .
pkg install nano
./run-snort.sh
exit 0
