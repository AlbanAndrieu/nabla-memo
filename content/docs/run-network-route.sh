#!/bin/bash
#set -xve

# https://www.provya.net/?d=2020/01/28/09/33/40-pfsense-comprendre-et-analyser-ses-regles-de-routage

netstat -rWn

sudo apt install traceroute

traceroute graansible01
traceroute to graansible01 (10.30.10.85), 30 hops max, 60 byte packets
# 1  172.69.187.45 (172.69.187.45)  9.557 ms  9.634 ms  9.615 ms
# From office via tailscale
traceroute graansible01
#traceroute to graansible01 (10.30.10.85), 30 hops max, 60 byte packets
# 1  gra1subrouter1.subrouter.jusmundi.com (100.64.0.7)  52.909 ms  55.351 ms  55.373 ms
# 2  mgmtgra1dnova (10.11.0.254)  55.378 ms  55.378 ms  55.380 ms

# 91.206.229.137 RIPE Database
# 94.131.9.178   RIPE Database
# 82.66.4.247 albandrieu.com free

exit
