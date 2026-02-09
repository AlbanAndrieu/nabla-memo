#!/bin/bash
set -xv

# old versions
# sudo add-apt-repository ppa:mrazavi/openvas
# sudo nano /etc/apt/sources.list.d/mrazavi-ubuntu-openvas-jammy.list
# deb https://ppa.launchpadcontent.net/mrazavi/openvas/ubuntu/ devel main

# https://launchpad.net/~mrazavi/+archive/ubuntu/gvm

# Then use the following commands to install GVM:

sudo apt remove postgresql-15* postgresql-17*

sudo add-apt-repository ppa:mrazavi/gvm
sudo apt install gvm
# going with
# openvas-scanner ospd-openvas postgresql-16-pg-gvm python3-gvm

grep 'gvm' /var/lib/dpkg/statoverride

# sudo apt install --reinstall openvas-scanner openvas gvmd gsad ospd-openvas

cat /var/log/gvm/gvmd.log
# failed: FATAL:  role "_gvm" does not exist
# setup database
gvm-setup

# You can check the status of greenbone daemons with systemctl:

systemctl status ospd-openvas # scanner
systemctl status gvmd         # manager
sudo systemctl status gsad    # web ui
# systemctl start notus-scanner
tail -f /var/log/notus-scanner/

sudo nano /etc/default/gsad
GSAD_ADDRESS=0.0.0.0

# sudo apt install openvas-scanner

sudo gvmd --version
# Greenbone Vulnerability Manager 22.4.2

# To enable pdf reports:
sudo apt install texlive-latex-extra --no-install-recommends
sudo apt install texlive-fonts-recommended --no-install-recommends

# To install openvas-nasl utility:
sudo apt install libopenvas9-dev

# from source https://github.com/greenbone/openvas-scanner/blob/main/INSTALL.md
sudo apt-get install gcc pkg-config libssh-gcrypt-dev libgnutls28-dev \
  libglib2.0-dev libjson-glib-dev libpcap-dev libgpgme-dev bison libksba-dev \
  libsnmp-dev libgcrypt20-dev redis-server libbsd-dev libcurl4-gnutls-dev

# openvas: error while loading shared libraries: libopenvas_nasl.so.21
# Fix by : https://askubuntu.com/questions/1409379/openvas-scanner-is-not-found-error-for-gvm-check-setup-how-to-solve-it

ldd /usr/sbin/openvas
sudo find / -name libopenvas_nasl.so
ln -s /usr/lib64/libopenvas_nasl.so.21 /lib/x86_64-linux-gnu/
ln -s /usr/lib64/libopenvas_misc.so.21 /lib/x86_64-linux-gnu/

openvas -s

openvas -u

sudo visudo
# <user> ALL = NOPASSWD: <install prefix>/sbin/openvas
ubuntu ALL = NOPASSWD: /usr/sbin/openvas

# Openvas 10, now called  Greenbone Vulnerability Management (GVM-10) has released. Find out more at: https://launchpad.net/~mrazavi/+archive/ubuntu/gvm

psql --version
# init postgres database
# as root
gvm-setup

# https://idroot.us/install-gvm-vulnerability-scanner-ubuntu-24-04/
sudo apt install gcc g++ make bison flex libksba-dev curl redis libpcap-dev cmake git pkg-config libglib2.0-dev libgpgme-dev nmap libgnutls28-dev uuid-dev libssh-gcrypt-dev libldap2-dev gnutls-bin libmicrohttpd-dev libhiredis-dev zlib1g-dev libxml2-dev libnet-dev libradcli-dev clang-format libldap2-dev doxygen gcc-mingw-w64 xml-twig-tools libical-dev perl-base heimdal-dev libpopt-dev libunistring-dev graphviz libsnmp-dev python3-setuptools python3-paramiko python3-lxml python3-defusedxml python3-dev gettext python3-polib xmltoman python3-pip texlive-fonts-recommended texlive-latex-extra xsltproc rsync libpaho-mqtt-dev libbsd-dev libjson-glib-dev python3-packaging python3-wrapt python3-cffi python3-psutil python3-redis python3-gnupg python3-paho-mqtt mosquitto libgcrypt20-dev redis-server libcurl4-gnutls-dev --no-install-recommends

sudo useradd -r -d /opt/gvm -c "GVM User" -s /bin/bash gvm
# sudo useradd -r -M -U -G sudo -s /usr/sbin/nologin gvm
sudo mkdir /opt/gvm && sudo chown gvm: /opt/gvm
echo "gvm ALL = NOPASSWD: $(which make) install, $(which python3)" | sudo tee /etc/sudoers.d/gvm
visudo -c -f /etc/sudoers.d/gvm

ls -lrta /etc/redis/redis-openvas.conf
sudo usermod -aG redis gvm
sudo systemctl restart redis-server

# Issue gsad main start_http_daemon redirect failed
# echo "db_address = /run/redis-openvas/redis.sock" | sudo tee /etc/openvas/openvas.conf
echo "db_address = /run/redis-openvas/redis-server.sock" | sudo tee /etc/openvas/openvas.conf

echo "mqtt_server_uri = localhost:1883
table_driven_lsc = yes" | sudo tee -a /etc/openvas/openvas.conf

sudo systemctl enable --now mosquitto

sudo -Hiu gvm greenbone-nvt-sync
sudo -Hiu gvm sudo openvas --update-vt-info

# PostgreSQL application password for gvmd-pg
sudo greenbone-nvt-sync
sudo -u gvm -g gvm greenbone-feed-sync-legacy --type CERT
sudo -u gvm -g gvm greenbone-feed-sync-legacy --type SCAP
sudo -u gvm -g gvm greenbone-feed-sync-legacy --type GVMD_DATA

sudo greenbone-scapdata-sync-legacy
# greenbone-scapdata-sync --refresh
# greenbone-scapdata-sync --refresh-private
sudo greenbone-scapdata-sync
sudo greenbone-certdata-sync

# Check everything is not missing
gvm-check-setup

sudo tee /etc/systemd/system/ospd-openvas.service <<'EOL'
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
# gvmd --user=admin --new-password=$OV_PASSWORD

journalctl -xeu gvmd.service

sudo service gsad restart
sudo service gvmd restart
sudo service ospd-openvas restart

export $(sudo cat /etc/default/gvmd-pg)
sudo -E -u gvm -g gvm gvmd --user=admin --new-password=admin
sudo -E -u gvm -g gvm gvmd --user=jusmundi --new-password=${OV_PASSWORD}
# gvmd --create-user=jusmundi --password=admin

sudo redis-cli -s /var/run/redis/redis.sock FLUSHALL

# openvas scap database is required
# See https://forum.greenbone.net/t/no-scap-database-found-please-help-me/15527/23
sudo tail -f /var/log/gvm/gvmd.log
sudo tail -f /var/log/gvm/openvas.log

ll /var/lib/gvm/scap-data/official-cpe-dictionary_v2.2.xml

# Failed to open file “/var/lib/gvm/private/CA/serverkey.pem”: No such file or directory
# Issue https://github.com/greenbone/gsa/issues/2455
gvm-manage-certs -a
ls /var/lib/gvm/private/CA/serverkey.pem
# sudo chown -R _gvm:_gvm CA/
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
# OSPD[1174780] 2025-06-23 18:47:16,032: ERROR: (ospd_openvas.db) Redis Error: Not possible to connect to the kb.
sudo -Hiu gvm /usr/sbin/gsad --foreground --listen 127.0.0.1 --port 9392
sudo -Hiu gvm /usr/sbin/gvmd --osp-vt-update=/run/ospd/ospd.sock --listen-group=gvm
#  gvmd: password policy missing: /etc/gvm/pwpolicy.conf
# https://raw.githubusercontent.com/greenbone/gvmd/refs/heads/main/src/pwpolicy.conf

# check status
ps aux | grep -E "ospd-openvas|gsad|gvmd" | grep -v grep

# https://127.0.0.1:9392/login

exit 0
