#!/bin/bash
pkg install lynis
pkg install openvas
echo "http://127.17.0.55:9392/login"
pkg install crowdsec crowdsec-blocklist-mirror crowdsec-firewall-bouncer
crowdsec enabled in /etc/rc.conf
service crowdsec start
crowdsec_firewall enabled in /etc/rc.conf
service crowdsec_firewall start
pkg install certmgr
pkg install py311-certbot py-certbot-dns-cloudflare py-certbot-dns-ovh py311-certbot-dns-route53 py311-certbot-dns-google
pkg install vaultwarden
pkg install suricata
pkg install lynis security/py-fail2ban security/wazuh-agent certmgr
exit 0
