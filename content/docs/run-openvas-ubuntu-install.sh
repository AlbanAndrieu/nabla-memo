#!/bin/bash
set -xv
sudo apt remove postgresql-15* postgresql-17*
sudo add-apt-repository ppa:mrazavi/gvm
sudo apt install gvm
grep 'gvm' /var/lib/dpkg/statoverride
cat /var/log/gvm/gvmd.log
gvm-setup
systemctl status ospd-openvas
systemctl status gvmd
sudo systemctl status gsad
tail -f /var/log/notus-scanner/
sudo nano /etc/default/gsad
GSAD_ADDRESS=0.0.0.0
sudo gvmd --version
sudo apt install texlive-latex-extra --no-install-recommends
sudo apt install texlive-fonts-recommended --no-install-recommends
sudo apt install libopenvas9-dev
sudo apt-get install gcc pkg-config libssh-gcrypt-dev libgnutls28-dev \
  libglib2.0-dev libjson-glib-dev libpcap-dev libgpgme-dev bison libksba-dev \
  libsnmp-dev libgcrypt20-dev redis-server libbsd-dev libcurl4-gnutls-dev
ldd /usr/sbin/openvas
sudo find / -name libopenvas_nasl.so
ln -s /usr/lib64/libopenvas_nasl.so.21 /lib/x86_64-linux-gnu/
ln -s /usr/lib64/libopenvas_misc.so.21 /lib/x86_64-linux-gnu/
openvas -s
openvas -u
sudo visudo
ubuntu ALL = NOPASSWD: /usr/sbin/openvas
psql --version
gvm-setup
sudo apt install gcc g++ make bison flex libksba-dev curl redis libpcap-dev cmake git pkg-config libglib2.0-dev libgpgme-dev nmap libgnutls28-dev uuid-dev libssh-gcrypt-dev libldap2-dev gnutls-bin libmicrohttpd-dev libhiredis-dev zlib1g-dev libxml2-dev libnet-dev libradcli-dev clang-format libldap2-dev doxygen gcc-mingw-w64 xml-twig-tools libical-dev perl-base heimdal-dev libpopt-dev libunistring-dev graphviz libsnmp-dev python3-setuptools python3-paramiko python3-lxml python3-defusedxml python3-dev gettext python3-polib xmltoman python3-pip texlive-fonts-recommended texlive-latex-extra xsltproc rsync libpaho-mqtt-dev libbsd-dev libjson-glib-dev python3-packaging python3-wrapt python3-cffi python3-psutil python3-redis python3-gnupg python3-paho-mqtt mosquitto libgcrypt20-dev redis-server libcurl4-gnutls-dev --no-install-recommends
sudo useradd -r -d /opt/gvm -c "GVM User" -s /bin/bash gvm
sudo mkdir /opt/gvm&&  sudo chown gvm: /opt/gvm
echo "gvm ALL = NOPASSWD: $(which make) install, $(which python3)"|  sudo tee /etc/sudoers.d/gvm
visudo -c -f /etc/sudoers.d/gvm
ls -lrta /etc/redis/redis-openvas.conf
sudo usermod -aG redis gvm
sudo systemctl restart redis-server
echo "db_address = /run/redis-openvas/redis-server.sock"|  sudo tee /etc/openvas/openvas.conf
echo "mqtt_server_uri = localhost:1883
table_driven_lsc = yes"|  sudo tee -a /etc/openvas/openvas.conf
sudo systemctl enable --now mosquitto
sudo -Hiu gvm greenbone-nvt-sync
sudo -Hiu gvm sudo openvas --update-vt-info
sudo greenbone-nvt-sync
sudo -u gvm -g gvm greenbone-feed-sync-legacy --type CERT
sudo -u gvm -g gvm greenbone-feed-sync-legacy --type SCAP
sudo -u gvm -g gvm greenbone-feed-sync-legacy --type GVMD_DATA
sudo greenbone-scapdata-sync-legacy
sudo greenbone-scapdata-sync
sudo greenbone-certdata-sync
gvm-check-setup
sudo tee /etc/systemd/system/ospd-openvas.service << 'EOL'
[Unit]
Description=OSPd Wrapper for the OpenVAS Scanner (ospd-openvas)
After=network.target networking.service redis-server@openvas.service mosquitto.service
[Service]
Type=exec
User=gvm
Group=gvm
ExecStart=/usr/bin/ospd-openvas --foreground --unix-socket /run/ospd/ospd-openvas.sock --pid-file /run/ospd/ospd-openvas.pid --log-file /var/log/gvm/ospd-openvas.log
Restart=always
[Install]
WantedBy=multi-user.target
EOL
sudo systemctl daemon-reload
sudo systemctl enable --now ospd-openvas
sudo geany /etc/systemd/system/ospd-openvas.service
sudo -Hiu gvm gvm-manage-certs -a
sudo -Hiu gvm gvmd --create-user admin
export $(sudo cat /etc/default/gvmd-pg)
sudo -E -u gvm -g gvm gvmd [more arguments...]
journalctl -xeu gvmd.service
sudo service gsad restart
sudo service gvmd restart
sudo service ospd-openvas restart
export $(sudo cat /etc/default/gvmd-pg)
sudo -E -u gvm -g gvm gvmd --user=admin --new-password=admin
sudo -E -u gvm -g gvm gvmd --user=jusmundi --new-password=$OV_PASSWORD
sudo redis-cli -s /var/run/redis/redis.sock FLUSHALL
sudo tail -f /var/log/gvm/gvmd.log
sudo tail -f /var/log/gvm/openvas.log
ll /var/lib/gvm/scap-data/official-cpe-dictionary_v2.2.xml
gvm-manage-certs -a
ls /var/lib/gvm/private/CA/serverkey.pem
sudo chown -R gvm:gvm /var/lib/gvm/
sudo chown -R gvm:gvm /var/lib/notus/
sudo chown -R gvm:gvm /var/lib/openvas/
sudo chown -R gvm:gvm /var/log/gvm
sudo chown -R gvm:gvm /etc/openvas
sudo usermod -aG gvm root
sudo mkdir /run/ospd/
sudo chown -R gvm:gvm /run/ospd/
sudo mkdir /run/gsad
sudo chown -R gvm:gvm /run/gsad/
sudo mkdir /run/gvmd
sudo chown -R gvm:gvm /run/gvmd/
sudo -Hiu gvm /usr/bin/ospd-openvas --foreground --unix-socket /run/ospd/ospd-openvas.sock --pid-file /run/ospd/ospd-openvas.pid --log-file /var/log/gvm/ospd-openvas.log
sudo -Hiu gvm /usr/sbin/gsad --foreground --listen 127.0.0.1 --port 9392
sudo -Hiu gvm /usr/sbin/gvmd --osp-vt-update=/run/ospd/ospd.sock --listen-group=gvm
ps aux|  grep -E "ospd-openvas|gsad|gvmd"|  grep -v grep
exit 0
