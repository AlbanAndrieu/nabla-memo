#!/bin/bash
set -xv

# https://docs.crowdsec.net/docs/getting_started/install_crowdsec/
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
sudo apt install crowdsec

# microk8s disable prometheus traefik
sudo /usr/share/crowdsec/wizard.sh -c

# ll /etc/crowdsec/config.yaml
# sudo chown -R albanandrieu:albanandrieu /var/log/crowdsec.log
# sudo chown -R albanandrieu:albanandrieu /etc/crowdsec/
# sudo chown -R albanandrieu:albanandrieu /var/lib/crowdsec/data/crowdsec.db
# sudo chown albanandrieu:albanandrieu /etc/crowdsec/config.yaml
# ll /etc/crowdsec/local_api_credentials.yaml

ll /lib/crowdsec/data

sudo systemctl reload crowdsec
sudo systemctl enable --now crowdsec
sudo service crowdsec restart

sudo ss -nltp | grep crowdsec

cscli version
sudo cscli machines list
sudo cscli machines delete albandrieu-latitude
cscli machines add albandrieu -a
# sudo cscli machines add albandrieu-Latitude-5420 -a
cscli machines add nomad01-dev -a --force

# sudo cscli collections install crowdsecurity/whitelist-good-actors
# https://docs.crowdsec.net/u/user_guides/hub_mgmt
sudo cscli collections list
sudo cscli parsers list
sudo cscli scenarios list
sudo cscli scenarios inspect crowdsecurity/ssh-bf

sudo cscli metrics

# sudo apt install crowdsec-firewall-bouncer-iptables
sudo apt install crowdsec-firewall-bouncer
# sudo apt install crowdsec-firewall-bouncer-nftables
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
# - "192.168.0.0/16"
- "10.30.0.115/24"
- "10.10.0.126/24"
- "10.20.0.19/24"

# Out-of-the-box, CrowdSec includes a whitelists.yaml file that includes your standard local IP ranges.
#
# 192.168.0.0/16
# 172.16.0.0/12
# 10.0.0.0/8
# 127.0.0.1
# ::1

sudo iptables -A INPUT -p tcp -s 10.20.0.0/24 --dport 8080 -j ACCEPT

# restart and check
sudo lsof -ni:8080 -sTCP:ESTABLISHED

cscli simulation enable crowdsecurity/ssh-bf
cscli simulation status
sudo cscli decisions list
# https://github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin/blob/main/examples/trusted-ips/README.md
# Add your IP to the ban list
cscli decisions add --ip 82.66.4.247 -d 10m
# You should get a 403 on https://fastapi-sample.service.gra.dev.consul/

# https://www.linuxjournal.com/content/how-set-crowdsec-multi-server-installation
sudo geany /etc/crowdsec/config.yaml /etc/crowdsec/local_api_credentials.yaml
# url: http://crowdsec.service.gra.dev.consul

# ExecStart=/usr/bin/crowdsec -c /etc/crowdsec/config.yaml -no-api

sudo cscli machines add -a
#  Machine '7c344e4dbe9d45b4a5c8efcc0e6a912feiPkinFAk8dTAO83'
# sudo cscli machines validate 9f3602d1c9244f02b0d6fd2e92933e75zLVg8zSRkyANxHbC
# sudo cscli lapi register -u http://crowdsec.service.gra.dev.consul --machine gra1crowdsec1
sudo cscli lapi register -u http://10.10.0.126:8080 --machine nomad-dev
cscli machines validate 7c344e4dbe9d45b4a5c8efcc0e6a912fTgtsvU8OlLJAjbjB

# cscli lapi register -u http://192.168.3.189:8080 --machine albandrieu
# NOK cscli lapi register -u http://crowdsec.service.gra.dev.consul --machine albandrieu
# docker exec -it crowdsec_lapi_container_name cscli machines add agent_user_name --password agent_password
# cscli machines delete server-2-name

sudo systemctl reload crowdsec
sudo systemctl restart crowdsec
journalctl -xeu crowdsec.service

# https://medium.com/@VSpec/suricata-and-crowdsec-setup-cef476204e78
cscli collections install crowdsecurity/suricata
cscli parsers install crowdsecurity/suricata-logs
cscli scenarios install crowdsecurity/suricata-alerts

cscli parsers delete crowdsecurity/whitelists

cscli parsers install inherent-io/keycloak-logs
cscli scenarios install inherent-io/keycloak-bf

# TODO
cscli parsers install crowdsecurity/pgsql-logs
cscli parsers install timokoessler/gitlab-logs
cscli parsers install LePresidente/grafana-logs
cscli scenarios install LePresidente/grafana-bf
cscli parsers install crowdsecurity/haproxy-logs

cscli parsers install crowdsecurity/traefik-logs
cscli collections install crowdsecurity/traefik
cscli collections install crowdsecurity/base-http-scenarios

# See https://zaferbalkan.com/crowdsec-wazuh-integration/?utm_campaign=Product%20Monthly%20Digest&utm_medium=email&_hsenc=p2ANqtz-88__7EYbOOIaTWXo9DSvCtN36JSk5qrVmCl905t_83niV7ahP7Kho7GHn-iy60vl_CQalKGf9Iu0Vrm25APpJsnGF1yw&_hsmi=358786275&utm_content=358786275&utm_source=hs_email
cscli parsers install crowdsecurity/apache2-logs
cscli collections install crowdsecurity/modsecurity

systemctl reload crowdsec

cscli explain --log '{"ClientAddr":"172.31.0.1:41076","ClientHost":"172.31.0.1","ClientPort":"41076","ClientUsername":"alex","DownstreamContentSize":3124,"DownstreamStatus":200,"Duration":559593,"OriginContentSize":3124,"OriginDuration":424108,"OriginStatus":200,"Overhead":135485,"RequestAddr":"traefik-dashboard.alexstepanov.work","RequestContentSize":0,"RequestCount":451,"RequestHost":"traefik-dashboard.alexstepanov.work","RequestMethod":"GET","RequestPath":"/dashboard/","RequestPort":"-","RequestProtocol":"HTTP/1.1","RequestScheme":"https","RetryAttempts":0,"RouterName":"api@docker","StartLocal":"2022-09-30T21:53:55.835455253+03:00","StartUTC":"2022-09-30T18:53:55.835455253Z","TLSCipher":"TLS_CHACHA20_POLY1305_SHA256","TLSVersion":"1.3","entryPointName":"https","level":"info","msg":"","time":"2022-09-30T21:53:55+03:00"}' --type traefik -v

# On Nomad
sh
/usr/local/bin/crowdsec
/usr/local/bin/cscli

# Grafana Dashboards
# NOK 19010
# NOK 19O11
# 19012
# 19013

# cscli bouncers add crowdsecBouncer
# get the api key
cscli bouncers add traefik-bouncer-nomad
# XXX
sudo cscli bouncers list
# cscli hub list
sudo cscli hub update
sudo cscli hub upgrade

# https://www.scaleway.com/en/docs/tutorials/protect-server-using-crowdsec/
sudo cscli dashboard setup -l 0.0.0.0
# http://10.10.0.126:3000/
# https://gra1crowdsec1:3000/
# crowdsec@crowdsec.net

./run-suricata.sh

sudo apt install x11-xserver-utils x11-apps
xhost +
xlogo

# https://docs.crowdsec.net/u/bouncers/cloudflare/
sudo apt install crowdsec-cloudflare-bouncer
systemctl start crowdsec-cloudflare-bouncer
systemctl status crowdsec-cloudflare-bouncer
sudo geany /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
sudo geany /etc/crowdsec/bouncers/crowdsec-cloudflare-bouncer.yaml
ls -lrta /var/lib/crowdsec/crowdsec-cloudflare-bouncer/cache/cloudflare-cache.json

sudo service crowdsec-cloudflare-bouncer restart

sudo apt install crowdsec-blocklist-mirror

# LAPI https://www.crowdsec.net/blog/introduction-to-the-local-api

exit 0
