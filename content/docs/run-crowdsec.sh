#!/bin/bash
set -xv
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh|  sudo bash
sudo apt install crowdsec
sudo /usr/share/crowdsec/wizard.sh -c
ll /lib/crowdsec/data
sudo systemctl reload crowdsec
sudo systemctl enable --now crowdsec
sudo service crowdsec restart
sudo ss -nltp|  grep crowdsec
cscli version
sudo cscli machines list
sudo cscli machines delete albandrieu-latitude
cscli machines add albandrieu -a
cscli machines add nomad01-dev -a --force
sudo cscli collections list
sudo cscli parsers list
sudo cscli scenarios list
sudo cscli scenarios inspect crowdsecurity/ssh-bf
sudo cscli metrics
sudo apt install crowdsec-firewall-bouncer
sudo apt install crowdsec-blocklist-mirror
sudo cscli console enroll clrrrchg80000ju08zzssggo0
sudo cscli console enable context
sudo cscli console status
sudo cscli alerts inspect 7
echo "https://app.crowdsec.net/security-engines"
sudo cscli alerts list
sudo nano /etc/crowdsec/parsers/s02-enrich/mywhitelists.yaml
name: crowdsecurity/whitelists
description: "Whitelist events from my ip addresses"
whitelist:
reason: "my ip addresses / ranges"
ip:
- "192.168.3.189"
- "145.239.211.190"
- "82.66.4.247"
cidr:
- "172.17.0.57/24"
- "10.30.0.115/24"
- "10.10.0.126/24"
- "10.20.0.19/24"
sudo iptables -A INPUT -p tcp -s 10.20.0.0/24 --dport 8080 -j ACCEPT
sudo lsof -ni:8080 -sTCP:ESTABLISHED
cscli simulation enable crowdsecurity/ssh-bf
cscli simulation status
sudo cscli decisions list
cscli decisions add --ip 82.66.4.247 -d 10m
sudo geany /etc/crowdsec/config.yaml /etc/crowdsec/local_api_credentials.yaml
sudo cscli machines add -a
sudo cscli lapi register -u http://10.10.0.126:8080 --machine nomad-dev
cscli machines validate 7c344e4dbe9d45b4a5c8efcc0e6a912fTgtsvU8OlLJAjbjB
sudo systemctl reload crowdsec
sudo systemctl restart crowdsec
journalctl -xeu crowdsec.service
cscli collections install crowdsecurity/suricata
cscli parsers install crowdsecurity/suricata-logs
cscli scenarios install crowdsecurity/suricata-alerts
cscli parsers delete crowdsecurity/whitelists
cscli parsers install inherent-io/keycloak-logs
cscli scenarios install inherent-io/keycloak-bf
cscli parsers install crowdsecurity/pgsql-logs
cscli parsers install timokoessler/gitlab-logs
cscli parsers install LePresidente/grafana-logs
cscli scenarios install LePresidente/grafana-bf
cscli parsers install crowdsecurity/haproxy-logs
cscli parsers install crowdsecurity/traefik-logs
cscli collections install crowdsecurity/traefik
cscli collections install crowdsecurity/base-http-scenarios
cscli parsers install crowdsecurity/apache2-logs
cscli collections install crowdsecurity/modsecurity
systemctl reload crowdsec
cscli explain --log '{"ClientAddr":"172.31.0.1:41076","ClientHost":"172.31.0.1","ClientPort":"41076","ClientUsername":"alex","DownstreamContentSize":3124,"DownstreamStatus":200,"Duration":559593,"OriginContentSize":3124,"OriginDuration":424108,"OriginStatus":200,"Overhead":135485,"RequestAddr":"traefik-dashboard.alexstepanov.work","RequestContentSize":0,"RequestCount":451,"RequestHost":"traefik-dashboard.alexstepanov.work","RequestMethod":"GET","RequestPath":"/dashboard/","RequestPort":"-","RequestProtocol":"HTTP/1.1","RequestScheme":"https","RetryAttempts":0,"RouterName":"api@docker","StartLocal":"2022-09-30T21:53:55.835455253+03:00","StartUTC":"2022-09-30T18:53:55.835455253Z","TLSCipher":"TLS_CHACHA20_POLY1305_SHA256","TLSVersion":"1.3","entryPointName":"https","level":"info","msg":"","time":"2022-09-30T21:53:55+03:00"}' --type traefik -v
sh
/usr/local/bin/crowdsec
/usr/local/bin/cscli
cscli bouncers add traefik-bouncer-nomad
sudo cscli bouncers list
sudo cscli hub update
sudo cscli hub upgrade
sudo cscli dashboard setup -l 0.0.0.0
./run-suricata.sh
sudo apt install x11-xserver-utils x11-apps
xhost +
xlogo
sudo apt install crowdsec-cloudflare-bouncer
systemctl start crowdsec-cloudflare-bouncer
systemctl status crowdsec-cloudflare-bouncer
sudo geany /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
sudo geany /etc/crowdsec/bouncers/crowdsec-cloudflare-bouncer.yaml
ls -lrta /var/lib/crowdsec/crowdsec-cloudflare-bouncer/cache/cloudflare-cache.json
sudo service crowdsec-cloudflare-bouncer restart
sudo apt install crowdsec-blocklist-mirror
exit 0
