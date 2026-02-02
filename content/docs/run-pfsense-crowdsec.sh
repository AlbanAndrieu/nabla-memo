ssh admin@home.albandrieu.com -p 9922
echo "23.09.1-RELEASE"
pkg remove pfSense-pkg-crowdsec crowdsec crowdsec-firewall-bouncer
setenv IGNORE_OSVERSION yes
cd /root/temp
mv freebsd-15-aarch64.tar freebsd-15-aarch64.tar-OLD
tar -xvf freebsd-15-aarch64.tar
fetch https://raw.githubusercontent.com/crowdsecurity/pfSense-pkg-crowdsec/refs/heads/main/install-crowdsec.sh
pkg add -f abseil-20240722.0.pkg
pkg add -f re2-20240702.pkg
pkg add -f crowdsec-1.7.4.pkg
pkg add -f crowdsec-firewall-bouncer-0.0.33.pkg
pkg add -f pfSense-pkg-crowdsec-0.1.6.pkg
ls -lrta /usr/local/etc/crowdsec
cd /root/temp
pkg add -f https://pkg.freebsd.org/FreeBSD:14:aarch64/latest/All/crowdsec-blocklist-mirror-0.0.2_10.pkg
cat /usr/local/etc/crowdsec/bouncers/crowdsec-blocklist-mirror.yaml
sysrc crowdsec_mirror_enable="YES"
cat /etc/rc.conf
service crowdsec_mirror start
cscli config show -oraw
service pf enable
service crowdsec_firewall enable
ifconfig
block drop in quick from 172.17.0.1 to any
block drop in quick from 10.20.0.1 to any
block drop in quick from 82.66.4.247 to any
block drop in quick from 172.17.0.12 to any
block drop in quick from 172.17.0.57 to any
pfctl -f /etc/pf.conf
service pf check
service pf status
pfctl -sr
service crowdsec.sh restart
ls -lrta /var/log/crowdsec/crowdsec.log
tail -f /var/log/crowdsec/crowdsec.log
service crowdsec_firewall.sh restart
ls -lrta /var/log/crowdsec/crowdsec-firewall-bouncer.log
pfctl -T show -t crowdsec_blacklist
pfctl -T show -t crowdsec6_blacklists
sudo cscli hub update
sudo cscli hub upgrade
cscli decisions list -a
ll /usr/local/bin/cscli: Exec format error. Binary file not executable.
cscli parsers install crowdsecurity/whitelists
cscli decisions list -a
crowdsec-cli machines list
export CROWDSEC_LOCAL_API_URL_NABLA="http://172.17.0.1:8089"
sudo cscli lapi register -u http://172.17.0.1:8089 --machine albandrieu
sudo systemctl reload crowdsec
crowdsec-cli machines list
cscli machines validate albandrieu
cscli console enroll -e context $ENROLLMENT_KEY
ll /usr/local/etc/crowdsec-firewall-bouncer/crowdsec-firewall-bouncer.yaml.sample
crowdsec-cli scenarios install crowdsecurity/ssh-bf
crowdsec-cli parsers install crowdsecurity/sshd-logs
crowdsec-cli parsers install crowdsecurity/syslog-logs
crowdsec-cli collections install crowdsecurity/sshd
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
nmap -sV 82.66.4.247
nc -zv 172.17.0.1 8088
sudo cscli console enable console_management
sudo cscli lapi register -u http://172.17.0.1:8089 --machine albandrieu
cscli machines validate albandrieu
sudo cscli decisions list
sudo cscli decisions add -t ban -d 2m -i 172.17.0.57
tail -f /var/log/crowdsec/crowdsec_api.log
tail -f /var/log/crowdsec/crowdsec-firewall-bouncer.log
tail -f /var/log/crowdsec/crowdse.log
cscli machines list
rm /usr/local/etc/crowdsec/local_api_credentials.yaml
umask 077
cscli machines add --auto
cscli alerts list
nano /etc/crowdsec/config.yaml
listen_uri: 172.17.0.1:8089
listen_addr: 172.17.0.1
sudo nano /usr/lib/systemd/system/crowdsec.service
sudo cscli machines add pfsense --auto -f -
sudo cscli bouncers add pfsense-firewall
sudo systemctl daemon-reload
sudo service crowdsec restart
sudo journalctl -xeu crowdsec.service
sudo cscli metrics show decisions
cscli bouncers add albandrieu
sudo apt install crowdsec-firewall-bouncer
sudo nano /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
sudo geany /etc/crowdsec/bouncers/crowdsec-cloudflare-bouncer.yaml
api_url: http://172.17.0.1:8089/
api_key: XXX
sudo service crowdsec-firewall-bouncer restart
exit 0
