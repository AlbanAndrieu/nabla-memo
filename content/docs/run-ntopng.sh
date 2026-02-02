#!/bin/bash
set -xv
ip r
sudo ethtool -k eno1
sudo ethtool -k eno1|  grep large-receive-offload
sudo apt-get install bridge-utils software-properties-common wget
ll /etc/network/interfaces
add-apt-repository universe
wget https://packages.ntop.org/apt-stable/24.04/all/apt-ntop-stable.deb
sudo apt install ./apt-ntop-stable.deb
curl -s https://packages.ntop.org/apt/24.04/all/apt.ntop.org.gpg.key|  sudo apt-key add -
sudo add-apt-repository "deb https://packages.ntop.org/apt/24.04/all/ focal main"
sudo apt-get clean all
sudo apt-get update
sudo apt install ntopng n2disk cento
sudo vi /etc/ntopng/ntopng.conf
./run-redis.sh
sudo apt-get install redis
sudo systemctl start redis-server.service
systemctl restart ntopng
systemctl enable ntopng
echo "http://localhost:3000/"
ll /var/lib/ntopng
cd /var/lib
ln -s /data/ntopng ntopng
pf_ringcfg --list-interfaces
apt install geoipupdate
geoipupdate
cd /etc
curl -I -L -u 778535:$MAXMIND_GEOIP_LicenseKey   'https://download.maxmind.com/geoip/databases/GeoIP2-City-CSV/download?suffix=zip'
curl -O -J -L -u 778535:$MAXMIND_GEOIP_LicenseKey   'https://download.maxmind.com/geoip/databases/GeoIP2-City-CSV/download?suffix=zip'
JM Network jusmundi.com 145.239.211.190
JM Office IP 80.15.4.233
Scaleway 88.125.135.116
nmap -p 1-65535 -T4 -A -v 192.168.3.0-255
141.95.161.76 OVH SAS
213.32.72.0 OVH SAS
213.32.5.228 OVH SAS
ip190.ip-145-239-211.eu 145.239.211.190 OVH failover
34.149.22.116 is registry.gitlab.com
104.18.19.193 Cloudflare
167.82.48.223 Fastly
91.189.91.82 ubuntu mirror
169.254.169.254 is https://tonylixu.medium.com/linux-networking-what-is-ip-address-169-254-169-254-f9e23b7332fe
ip route show|  grep 169.254.169.254
curl "http://metadata.google.internal/computeMetadata/v1/instance/?" -H "Metadata-Flavor: Google"
curl http://169.254.169.254/latest/meta-data/
curl http://169.254.169.254/openstack/latest/meta_data.json
104.30.163.27 104.30.176.222 Cloudflare Warp
pkg install ntopng
sudo journalctl -xeu ntopng.service
exit 0
