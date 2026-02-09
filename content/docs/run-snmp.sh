#!/bin/bash
set -xv

# https://techbits.fr/snmp-optimisez-la-supervision-de-votre-parc-reseau/

sudo apt-get install snmp snmpd

sudo systemctl start snmpd

# https://blog.cedrictemple.net/239-faire-des-requetes-snmp-en-ligne-de-commande-sous-linux/
snmpwalk -v 1 -c public 172.17.0.1

snmpwalk -v 2c -c public 172.17.0.1 1.3.6.1.2.1.2.2.1.10
snmpget -v 2c -c public 172.17.0.1 1.3.6.1.2.1.2.2.1.10.1

# router
snmpwalk -v 1 -c public 172.17.0.12 .1.3.6.1.4.1.33355

snmptable -v 2c -c public localhost 1.3.6.1.2.1.6.13
snmptable -v 2c -c public 172.17.0.1 1.3.6.1.2.1.6.13

snmpget -v 1 -c public 10.0.1.1 1.3.6.1.2.1.1.0
# snmpget -v 1 -c public 10.20.0.183 1.3.6.1.2.1.1.0
snmpget -v 1 -c public 10.21.0.4 1.3.6.1.2.1.1.0
snmpget -v 1 -c public 10.21.0.254 1.3.6.1.2.1.1.0
# pfsense
snmpget -v 1 -c public 10.30.10.254 SNMPv2-MIB::sysName.0

# https://www.dnsstuff.com/fr/outils-surveillance-snmp

# https://community.spiceworks.com/t/network-monitor-end-of-life-connectivity-dashboard-suggested-replacement/970797
# https://www.observium.org/

# https://www.logicmonitor.com/support/monitoring/networking-firewalls/pfsense-firewalls

# https://www.willyhu.tw/posts/snmp-exporter-for-pfsense/
# 10.30.10.254 in this case is our pfSense host.
snmpwalk -v2c -c public 10.30.10.254 1.3.6.1.2.1.1.1.0
# It should return like: iso.3.6.1.2.1.1.1.0 = STRING: "pfSense grapfsense01.int.jusmundi.com 2.5.2-RELEASE FreeBSD 12.2-STABLE amd64"

# https://www.willyhu.tw/posts/snmp-exporter-for-pfsense/
# NOK sudo snap install prometheus-snmp-exporter
# Use instead run-snmp-exporter-install.sh

exit 0
