#!/bin/bash
set -xv

# See https://blog.searce.com/haproxy-prometheus-grafana-integration-ba965eb96dfe

sudo apt-get install haproxy -y

sudo systemctl restart haproxy
sudo systemctl disable --now haproxy

# See https://github.com/prometheus/haproxy_exporter

# See https://www.lisenet.com/2021/monitor-haproxy-with-grafana-and-prometheus-haproxy_exporter/
sudo groupadd prometheus
sudo useradd --system -s /sbin/nologin -g prometheus prometheus

wget -q https://github.com/prometheus/haproxy_exporter/releases/download/v0.13.0/haproxy_exporter-0.13.0.linux-amd64.tar.gz
sudo tar --strip-components=1 -xf haproxy_exporter-0.13.0.linux-amd64.tar.gz -C /usr/local/bin/
sudo chown -R root: /usr/local/bin/

sudo geany /etc/systemd/system/haproxy_exporter.service
#192.168.3.140
sudo chown -R root: /etc/systemd/system/haproxy_exporter.service
sudo chmod 0644 /etc/systemd/system/haproxy_exporter.service

sudo systemctl daemon-reload
sudo systemctl enable --now haproxy_exporter

# https://github.com/prometheus/haproxy_exporter
# http://192.168.3.140/
docker run -p 9101:9101 quay.io/prometheus/haproxy-exporter:latest --haproxy.scrape-uri="http://admin:haproxy@192.168.3.140:9000?stats;csv"

# https://docs.elastic.co/en/integrations/haproxy

# haproxy stats : http://localhost:9000/stats
# haproxy_exporter : http://0.0.0.0:9101/metrics

# http://admin:haproxy@test-haproxy.service.gra.uat.consul:9001/uat?stats;csv
http://admin:XXX@grapfsense01.int.nabla.com:2201/haproxy/stats
curl -X GET http://${HAPROXY_STATS_LOGIN}172.17.0.1:2201/haproxy/stats;csv

#NOK : 10.20.0.254
#OK : http://admin:XXX@10.30.10.254:2201/haproxy/stats?stats;csv

echo "show acl #13" | socat unix-connect:/tmp/haproxy.socket stdio

# on pfsense
# https://grapfsense01.int.nabla.com:10443/haproxy/haproxy_listeners_edit.php?id=Web_HTTPS
Advanced certificate specific ssl options
alpn h2,http/1.1

# if too many redirect on main, fix could be certificates
# 503 Service Unavailable

Haproxy conf

Web_HTTPS
* nabla-index if(albandrieu_com)
* prod_back (default)
* prod_front if(bababou)

Certificate : wildcard.albandrieu.com
      Add ACL for certificate Subject Alternative Names.

Additional certificates : "albandrieu.com (CA: Acmecert: O=Let's Encrypt, CN=R10, C=US) [Server cert]"

Haproxy settings
DNS servers : adguardhome 172.17.0.33 53

exit 0
