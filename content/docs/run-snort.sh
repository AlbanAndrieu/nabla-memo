#!/bin/bash
set -xv

# NOK service snort onestart
cd /var/log

# https://iritt.medium.com/setting-up-snort-for-network-monitoring-on-pfsence-for-your-cybersecurity-lab-f724e48d6221

Snort Status: Enable or disable Snort for this interface.

# On WAN

Block Offenders

Send Alerts to System Log

Stream Inserts
Checksum Check Disable

# snort no preprocessors configured for policy 0

cd /usr/local/etc/snort/
nano snort.conf
# ipvar HOME_NET 192.168.19.17/24
ipvar HOME_NET 172.17.0.1/24
ipvar HOME_NET 82.66.4.247

cd rules
nano local.rules
alert icmp any any -> any any (msg:"ICMP detected from WAN"; sid:1000001;)

/usr/local/bin/snort -l /usr/local/etc/snort/logs/ -c /usr/local/etc/snort/rules/local.rules -A console -T
/usr/local/bin/snort

mkdir -p /var/log/snort
chmod -R 755 /var/log/snort

snort -i mvneta0 -c /usr/local/etc/snort/rules/local.rules -A console -l /var/log/snort

snort -i mvneta0 -v -c /usr/local/etc/snort/snort.conf -A console -l /var/log/snort
# ERROR: /usr/local/etc/snort/./rules/app-detect.rules(0) Unable to open rules file /usr/local/etc/snort/./rules/app-detect.rules
# https://forum.netgate.com/topic/56150/snort-unable-to-open-rules-file/6

# https://snort.org/
wget https://snort.org/downloads/community/community-rules.tar.gz
wget https://www.snort.org/downloads/registered/snortrules-snapshot-29200.tar.gz

snort_app-detect.rules

exit 0
