#!/bin/bash
set -xv

# boot
# admin/pfsense

# https://192.168.1.1/

# DHCP
# LAN change 192.168.1.1 to 172.17.0.1
#
# new UI is on https://82.66.4.247/

# Enable OPT https://82.66.4.247/interfaces.php?if=opt1 10.20.0.24

# CHANGE DHCP range from 172.17.0.10 to 100
# to be able to hard code MAC address such as freenas 172.17.0.24

# Router
# http://192.168.1.100/start.htm
# http://10.20.0.101/
# http://172.17.0.100/start.htm
# Then turn router netgear at 10.0.01 to 172.17.0.1
# Then turn router netgear to AP mode and put it on LAN

# See https://www.contradodigital.com/2021/02/19/how-to-host-a-single-website-behind-a-pfsense-firewall/

# See https://82.66.4.247:10443/system_advanced_firewall.php

# NAT Reflection mode for port forwards
# Enable NAT Reflection for 1:1 NAT
# Enable automatic outbound NAT for Reflection

# https://www.reddit.com/r/pfBlockerNG/comments/t1awl6/updated_patch_for_pfsense_2621x_ip_logging_issues/
# curl -o /usr/local/pkg/pfblockerng/pfblockerng.inc "https://gist.githubusercontent.com/BBcan177/7cb8635199446866d511b97166d65296/raw/"
curl -o /usr/local/pkg/pfblockerng/pfblockerng.inc "https://gist.githubusercontent.com/BBcan177/7cb8635199446866d511b97166d65296/raw/"

# restart pfb_filter https://82.66.4.247:10443/status_services.php#
ssh admin@home.albandrieu.com -p 9922
cd /var/log/pfblockerng/

Goto pfSense GUI > Diagnostics > Command Prompt > Execute PHP Command > then copy paste this code below

require_once('/usr/local/pkg/pfblockerng/pfblockerng.inc');

print_r(pfb_filterrules());

Post the output pls.

If you run this command from the shell, do you get any errors?

/usr/local/etc/rc.d/pfb_filter.sh restart

# upgrade all
# pkg upgrade -fy

# https://www.privacyaffairs.com/ip-filtering-pfsense/

ls -lah /usr/local/share/GeoIP/
ls -lah /usr/local/share/ntopng/httpdocs/geoip
# geoipupdate
wget https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country-CSV&license_key=3NpPMaK16z7NCD2H&suffix=zip

# Use DNS resolver https://home.albandrieu.com:10443/services_unbound.php on OPT
# Use SSL/TLS for outgoing DNS Queries to Forwarding Servers
# with dns watch no log entry DNS resolver1.dns.watch at https://home.albandrieu.com:10443/system.php
# And disable Allow DNS server list to be overridden by DHCP/PPP on WAN or remote OpenVPN server

# pfBlocker https://www.privacyaffairs.com/ip-filtering-pfsense/
# pfBlocker https://openschoolsolutions.org/pfsense-web-filter-with-pfblockerng/

# Configurer un cluster de 2 pfSense redondants (failover) : https://www.provya.net/?d=2016/10/02/07/48/16-

# https://docs.netgate.com/pfsense/en/latest/recipes/openvpn-nat-subnets-conflict.html
# LAN 172.17.0.0
# OPT 10.20.0.0

# https://github.com/authelia/authelia/issues/2696
# Required headers
http-request set-header X-Real-IP %[src]
http-request set-header X-Forwarded-Method %[var(req.method)]
http-request set-header X-Forwarded-Proto %[var(req.scheme)]
http-request set-header X-Forwarded-Host %[req.hdr(Host)]
http-request set-header X-Forwarded-Uri %[path]%[var(req.questionmark)]%[query]

# DNS over TLS https://www.provya.net/?d=2018/04/08/15/18/43-pfsense-implementer-dns-sur-tls-chiffrement-des-requetes-dns
# https://docs.netgate.com/pfsense/en/latest/recipes/dns-over-tls.html

# DNSSEC Cloudflare

# Open VPN https://www.provya.net/index.php?d=2016/04/18/11/00/31-pfsense-securisez-lacces-distant-de-vos-collaborateurs-nomades-avec-openvpn
# Creation d un CA albandrieu et certificate serveur cert-serveur-albandrieu et client cert-client-albandrieu

# PfSense upgrade 2.5 to 2.7.0
pkg-static info -x pfSense-upgrade

# Add pfsense to zabbix
# https://www.ceos3c.com/pfsense/monitor-pfsense-2-4-zabbix/?expand_article=1
# https://www.ceos3c.com/pfsense/monitor-pfsense-2-4-zabbix/?expand_article=1

# Template :
# FreeBSD by Zabbix agent
# PFSense by SNMP

# https://docs.netgate.com/reference/create-flash-media.html
# Etcher
wget https://github.com/balena-io/etcher/releases/download/v1.19.3/balena-etcher_1.19.3_amd64.deb
sudo apt install ~/Downloads/balena-etcher_******_amd64.deb

ssh admin@grapfsense01
pfctl -t sshguard -T show
pfctl -t sshguard -T delete <IP_to_unlock>
# pfctl -t sshguard -T flush
# iptables -L -n -v sshguard
# pfctl -vvss | grep -A 4 :22
# unban gra1subrouter1 IP
pfctl -t sshguard -T delete 10.10.0.7

echo "" > /var/log/haproxy.log
echo "" > /var/log/filter.log

# For ansible-cmdb
sudo apt install sshpass

# pkg install sshpass
Installed packages to be UPGRADED:
	pkg: 1.20.8_2 -> 1.20.9_1 [pfSense]

freebsd-version
# 14.0-CURRENT

# pfsense upgrade 23.09.1 24.03 fail

pkg upgrade
# pkg: Cannot delete vital package: php82!
# pkg: If you are sure you want to remove php82,
# pkg: unset the 'vital' flag with: pkg set -v 0 php82
php --version
# PHP 8.2.11 (cli) (built: Nov 29 2023 07:14:30) (NTS)

pkg upgrade

freebsd-version
# 15.0-CURRENT
php --version
# PHP 8.3.1 (cli) (built: Apr 23 2024 15:21:23) (NTS)

# Add sFlow / jFlow IPFIX
# https://www.netgate.com/blog/packet-flow-data
# See https://docs.netgate.com/pfsense/en/latest/recipes/netflow-with-softflowd.html
softflowd

# Add it to Cloudflare
# https://developers.cloudflare.com/magic-network-monitoring/routers/netflow-ipfix-config/
LAN and WAN
Host : 162.159.65.1
Port : 2055
Sample: 5
# In cloudflare
# https://dash.cloudflare.com/bdfe00eeee5845782ab91adfbff71ee1/network-monitoring/onboarding

./run-pfsense-syslog.sh

# DNS
# System -> General Setup https://home.albandrieu.com:10443/system.php
# Cloudflare family https://one.one.one.one/family/?ref=techblog.nexxwave.eu
# 1.1.1.2
# 1.0.0.2
# Malware and Adult Content Blocking Together
# 1.1.1.3
# 1.0.0.3

# Quad
# 9.9.9.9
# 149.112.112.112

# Cloudflare DNS
# https://medium.com/@joshiarpit2/a-homelab-enthusiasts-guide-setting-up-ddns-on-pfsense-using-cloudflare-c1f2e2522cac

ping ddns.albandrieu.com

# https://linuxblog.io/pfsense-setup-post-install/
# System → Advanced → Miscellaneous set Cryptographic Hardware
# Advanced → Miscellaneous -> Use RAM Disks on the System -> 128

# https://docs.netgate.com/pfsense/en/latest/packages/traffic-totals.html
# vnstatd is Status->Traffic
# Remove package pfSense-pkg-Status_Traffic_Totals

# https://www.ntop.org/guides/ntopng/third_party_integrations/pfsense.html
# https://packages.ntop.org/FreeBSD/
pkg add https://packages.ntop.org/FreeBSD/FreeBSD:15:aarch64/latest/ntop-1.0.pkg
pkg install nprobe

pkg add https://packages.ntop.org/FreeBSD/FreeBSD:15:aarch64/latest/ntop-1.0.pkg

# Issue after haproxy upgrade
# ld-elf.so.1: Shared object "libmd.so.7" not found, required by "pkg"
pkg-static upgrade -f pfSense-repoc

pkg-static upgrade

# https://medium.com/cloud-security/aws-credentials-and-roles-for-the-pfsense-vpn-wizard-0d4e7f816dd4
# https://medium.com/cloud-security/configuring-the-vpc-and-vpc-flow-logs-for-an-aws-site-to-site-pfsense-vpn-9bcf56a1e5e6
# AmazonEC2FullAccess
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"sts:AssumeRole"
			],
			"Resource": "arn:aws:iam::783876277037:role/aandrieu"
		},
		{
			"Sid": "VisualEditor1",
			"Effect": "Allow",
			"Action": [
				"ec2:DescribeRegions"
			],
			"Resource": "*"
		}
	]
}

exit 0
