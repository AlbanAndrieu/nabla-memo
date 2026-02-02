#!/bin/bash
set -xv
telnet 172.17.0.93 24800
nc -vz 172.17.0.93 24800
netstat -anp|  grep -E "(Active|State|barrier|24800)"
./run-gnome.sh
ll /home/albanandrieu/.local/share/barrier/SSL/Barrier.pem
cd /home/albanandrieu/.local/share/barrier/SSL/
openssl req -new -x509 -sha256 -days 999 -nodes -out Barrier.pem -keyout Barrier.pem
./run-gnome.sh
exit 0
