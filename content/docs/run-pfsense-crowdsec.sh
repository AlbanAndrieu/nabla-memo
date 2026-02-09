# https://www.it-connect.fr/tuto-installation-crowdsec-pare-feu-pfsense/

ssh admin@home.albandrieu.com -p 9922

echo "23.09.1-RELEASE"
# Upgrade https://www.netgate.com/blog/netgate-releases-pfsense-plus-software-version-24.03

# https://shop.netgate.com/products/netgate-installer
# Netgate AArch64 (ARM64) appliances (Netgate 1100 and 2100)

# https://docs.crowdsec.net/docs/next/getting_started/install_crowdsec_pfsense/
pkg remove pfSense-pkg-crowdsec crowdsec crowdsec-firewall-bouncer

# FreeBSD 14.0-CURRENT
# freebsd-15-aarch64.tar

setenv IGNORE_OSVERSION yes

cd /root/temp
# https://github.com/crowdsecurity/pfSense-pkg-crowdsec/releases/
# curl -sL https://github.com/crowdsecurity/pfSense-pkg-crowdsec/releases/download/v0.1.3-1.6.2/freebsd-15-aarch64.tar -o freebsd-15-aarch64.tar
mv freebsd-15-aarch64.tar freebsd-15-aarch64.tar-OLD
# curl -sL https://github.com/crowdsecurity/pfSense-pkg-crowdsec/releases/download/v0.1.4-1.6.3_2/freebsd-15-aarch64.tar -o freebsd-15-aarch64.tar
# NOK curl -sL https://github.com/crowdsecurity/pfSense-pkg-crowdsec/releases/download/v0.1.5-1.6.8/freebsd-15-aarch64.tar -o freebsd-15-aarch64.tar
# NOK curl -sL https://github.com/crowdsecurity/pfSense-pkg-crowdsec/releases/download/v0.1.5-1.6.9-32/freebsd-15-aarch64.tar -o freebsd-15-aarch64.tar
tar -xvf freebsd-15-aarch64.tar

fetch https://raw.githubusercontent.com/crowdsecurity/pfSense-pkg-crowdsec/refs/heads/main/install-crowdsec.sh
# sh install-crowdsec.sh --release v0.1.6-1.7.4-33

pkg add -f abseil-20240722.0.pkg
# pkg add -f abseil-20250127.0.pkg
pkg add -f re2-20240702.pkg
# pkg add -f re2-20240702_1.pkg
pkg add -f crowdsec-1.7.4.pkg
# pkg add -f crowdsec-1.6.8.pkg
pkg add -f crowdsec-firewall-bouncer-0.0.33.pkg
# Updating crowdsec hub data
# updated /var/db/crowdsec/data/GeoLite2-City.mmdb
# updated /var/db/crowdsec/data/GeoLite2-ASN.mmdb
# updated crowdsecurity/geoip-enrich
# updated crowdsecurity/freebsd
# updated crowdsecurity/suricata
pkg add -f pfSense-pkg-crowdsec-0.1.6.pkg

# wrong arch
# pkg add -f https://github.com/crowdsecurity/pfSense-pkg-crowdsec/releases/download/v0.1.3/abseil-20230125.3.pkg
# pkg add -f https://github.com/crowdsecurity/pfSense-pkg-crowdsec/releases/download/v0.1.3-1.6.1_1/re2-20240401.pkg
# pkg add -f https://github.com/crowdsecurity/pfSense-pkg-crowdsec/releases/download/v0.1.3-1.6.2/crowdsec-1.6.2.pkg
# pkg add -f https://github.com/crowdsecurity/pfSense-pkg-crowdsec/releases/download/v0.1.3/crowdsec-firewall-bouncer-0.0.28_3.pkg
#pkg add -f https://github.com/crowdsecurity/pfSense-pkg-crowdsec/releases/download/v0.1.3-1.6.2/pfSense-pkg-crowdsec-0.1.3.pkg
ls -lrta /usr/local/etc/crowdsec

cd /root/temp
# curl -sL https://github.com/crowdsecurity/cs-blocklist-mirror/releases/download/v0.0.4-rc1/crowdsec-blocklist-mirror-freebsd-arm64 -o crowdsec-blocklist-mirror-freebsd-arm64
# curl -sL https://github.com/crowdsecurity/cs-blocklist-mirror/releases/download/v0.0.4-rc1/crowdsec-blocklist-mirror-freebsd-armv7 -o crowdsec-blocklist-mirror-freebsd-armv7
# curl -sL https://github.com/crowdsecurity/cs-blocklist-mirror/releases/download/v0.0.4-rc1/crowdsec-blocklist-mirror-linux-armv7.tgz -o crowdsec-blocklist-mirror-linux-armv7.tgz
# tar -xvf crowdsec-blocklist-mirror-linux-armv7.tgz
# curl -sL https://github.com/crowdsecurity/cs-blocklist-mirror/releases/download/v0.0.4-rc1/crowdsec-blocklist-mirror-linux-armv6.tgz -o crowdsec-blocklist-mirror-linux-armv6.tgz
# tar -xvf crowdsec-blocklist-mirror-linux-armv6.tgz
# cd crowdsec-blocklist-mirror-v0.0.4-rc1/

# https://pkgs.org/search/?q=crowdsec-blocklist-mirror
# pkg add -f https://pkg.freebsd.org/FreeBSD:14:amd64/latest/All/crowdsec-blocklist-mirror-0.0.2_9.pkg
pkg add -f https://pkg.freebsd.org/FreeBSD:14:aarch64/latest/All/crowdsec-blocklist-mirror-0.0.2_10.pkg

# pkg remove crowdsec-blocklist-mirror
cat /usr/local/etc/crowdsec/bouncers/crowdsec-blocklist-mirror.yaml
# 'http://127.0.0.1:41412/security/blocklist', check the configuration file to

sysrc crowdsec_mirror_enable="YES"
cat /etc/rc.conf

service crowdsec_mirror start

# https://nope.breizhland.eu/crowdsec_installation_pfsense/

# pkg install security/crowdsec-blocklist-mirror
cscli config show -oraw

service pf enable
# service pf start
service crowdsec_firewall enable

ifconfig
# Add the following in /etc/pf.conf to create the firewall tables and rules:
#
# ----------
# table <crowdsec-blacklists> persist
# table 172.17.0.1 persist
# table 10.20.0.1 persist
# table 82.66.4.247 persist
# table 172.17.0.12 persist
# table 172.17.0.57 persist
# table <crowdsec6-blacklists> persist
# block drop in quick from <crowdsec-blacklists> to any
block drop in quick from 172.17.0.1 to any
block drop in quick from 10.20.0.1 to any
block drop in quick from 82.66.4.247 to any
block drop in quick from 172.17.0.12 to any
block drop in quick from 172.17.0.57 to any
# block drop in quick from <crowdsec6-blacklists> to any
# ----------
#

# To apply the file:
# https://docs.crowdsec.net/blog/crowdsec_firewall_freebsd/

pfctl -f /etc/pf.conf
service pf check
service pf status

# On vérifie ensuite la configuration avec les commandes suivantes
pfctl -sr

# Then activate the bouncer via sysrc and run it:
#
# ----------
# # sysrc crowdsec_firewall_enable="YES"
# crowdsec_firewall_enable: NO -> YES
# # service crowdsec_firewall start

# service crowdsec start
#  Cannot 'start' crowdsec. Set crowdsec_enable to YES in /etc/rc.conf or use 'onestart' instead of 'start'.
# sysrc crowdsec_enable="YES"
service crowdsec.sh restart
ls -lrta /var/log/crowdsec/crowdsec.log
tail -f /var/log/crowdsec/crowdsec.log
# Issue : Error machine login for pfsense : ent: machine not found
# https://github.com/crowdsecurity/pfSense-pkg-crowdsec/issues/81
service crowdsec_firewall.sh restart
ls -lrta /var/log/crowdsec/crowdsec-firewall-bouncer.log

# IPV4
pfctl -T show -t crowdsec_blacklist
# (IPv6)
pfctl -T show -t crowdsec6_blacklists

sudo cscli hub update
sudo cscli hub upgrade

cscli decisions list -a
ll /usr/local/bin/cscli: Exec format error. Binary file not executable.
cscli parsers install crowdsecurity/whitelists

cscli decisions list -a

crowdsec-cli machines list
# Go to https://home.albandrieu.com:10443/pkg_edit.php?xml=crowdsec.xml&id=0
# Change LAPI host 172.17.0.1 on pfsense crowdsec config
export CROWDSEC_LOCAL_API_URL_NABLA="http://172.17.0.1:8089"
sudo cscli lapi register -u http://172.17.0.1:8089 --machine albandrieu
sudo systemctl reload crowdsec

crowdsec-cli machines list
cscli machines validate albandrieu

# https://docs.crowdsec.net/u/getting_started/post_installation/console
cscli console enroll -e context $ENROLLMENT_KEY

ll /usr/local/etc/crowdsec-firewall-bouncer/crowdsec-firewall-bouncer.yaml.sample

# https://docs.crowdsec.net/blog/crowdsec_firewall_freebsd/
crowdsec-cli scenarios install crowdsecurity/ssh-bf
crowdsec-cli parsers install crowdsecurity/sshd-logs
crowdsec-cli parsers install crowdsecurity/syslog-logs
crowdsec-cli collections install crowdsecurity/sshd

# Subscribe to : https://app.crowdsec.net/blocklists/65a567bdec04bcd4f51670bd
# https://docs.crowdsec.net/u/getting_started/post_installation/console_blocklists

# Free Proxies list
# Firehol greensnow.co list
# OTX Web Scanners List

# metrics port 6060
cscli metrics show decisions
cscli metrics show acquisition

cscli collections install crowdsecurity/pfsense
cd /usr/local/etc/crowdsec/acquis.d/
grep poll_without_inotify *
service crowdsec reload
cscli collections install crowdsecurity/pfsense-gui
cscli parsers install crowdsecurity/pfsense-gui-logs

cscli collections install crowdsecurity/suricata

cscli console status

cd /usr/local/etc/crowdsec
cscli alerts list

# Test scan
nmap -sV 82.66.4.247

# Check logs at :
# https://82.66.4.247:10443/status_logs_packages.php?pkg=crowdsec
# https://172.17.0.1:10443/crowdsec/metrics.php#tab-metrics-lapi
# https://82.66.4.247:10443/crowdsec/status.php#tab-status-machines
# https://82.66.4.247:10443/pkg_edit.php?xml=crowdsec.xml

# https://www.reddit.com/r/CrowdSec/comments/1fcco51/crowdsec_lapi_unable_to_connect/
nc -zv 172.17.0.1 8088
# change port to 8089

sudo cscli console enable console_management
# On pfsense
sudo cscli lapi register -u http://172.17.0.1:8089 --machine albandrieu
cscli machines validate albandrieu
# on aandrieu
# NOK sudo cscli decisions list -a
sudo cscli decisions list

# Delete block list TOR https://app.crowdsec.net/blocklists/65a56c070469607d9badb811
# sudo cscli decisions delete --scenario tor-exit-nodes
sudo cscli decisions add -t ban -d 2m -i 172.17.0.57

tail -f /var/log/crowdsec/crowdsec_api.log
tail -f /var/log/crowdsec/crowdsec-firewall-bouncer.log

tail -f /var/log/crowdsec/crowdse.log
# Issue : unable to start crowdsec routines: authenticate watcher (pfsense): API error: ent: machine not found
# See fix : https://forum.opnsense.org/index.php?topic=33516.0
cscli machines list
rm /usr/local/etc/crowdsec/local_api_credentials.yaml
umask 077
cscli machines add --auto

# Machine '7edd988416984e00ab111c6599acbbcakATvVvm13aIdpy9B' successfully added to the local API.
# API credentials written to '/usr/local/etc/crowdsec/local_api_credentials.yaml'.

cscli alerts list
# I can see myself ban

nano /etc/crowdsec/config.yaml
listen_uri: 172.17.0.1:8089
# an in prom
listen_addr: 172.17.0.1

# See http://172.17.0.1:6060/metrics

sudo nano /usr/lib/systemd/system/crowdsec.service
# add -no-api

sudo cscli machines add pfsense --auto -f -
sudo cscli bouncers add pfsense-firewall

sudo systemctl daemon-reload
sudo service crowdsec restart
sudo journalctl -xeu crowdsec.service

sudo cscli metrics show decisions

# in pfsense
cscli bouncers add albandrieu

sudo apt install crowdsec-firewall-bouncer
sudo nano /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
sudo geany /etc/crowdsec/bouncers/crowdsec-cloudflare-bouncer.yaml
api_url: http://172.17.0.1:8089/
api_key: XXX

sudo service crowdsec-firewall-bouncer restart

exit 0
