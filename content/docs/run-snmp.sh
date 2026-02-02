#!/bin/bash
set -xv
sudo apt-get install snmp snmpd
sudo systemctl start snmpd
snmpwalk -v 1 -c public 172.17.0.1
snmpwalk -v 2c -c public 172.17.0.1 1.3.6.1.2.1.2.2.1.10
snmpget -v 2c -c public 172.17.0.1 1.3.6.1.2.1.2.2.1.10.1
snmpwalk -v 1 -c public 172.17.0.12 .1.3.6.1.4.1.33355
snmptable -v 2c -c public localhost 1.3.6.1.2.1.6.13
snmptable -v 2c -c public 172.17.0.1 1.3.6.1.2.1.6.13
snmpget -v 1 -c public 10.0.1.1 1.3.6.1.2.1.1.0
snmpget -v 1 -c public 10.21.0.4 1.3.6.1.2.1.1.0
snmpget -v 1 -c public 10.21.0.254 1.3.6.1.2.1.1.0
snmpget -v 1 -c public 10.30.10.254 SNMPv2-MIB::sysName.0
snmpwalk -v2c -c public 10.30.10.254 1.3.6.1.2.1.1.1.0
exit 0
