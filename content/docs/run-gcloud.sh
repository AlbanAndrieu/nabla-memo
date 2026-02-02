#!/bin/bash
set -xv
sudo snap install google-cloud-sdk --classic
gcloud init
gcloud auth list
pkg install python socat
pkg install py38-sqlite3
pkg install py38-certbot py38-certbot-apache
type -a python
/usr/local/bin/python --version
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-379.0.0-linux-x86_64.tar.gz
tar zxvf google-cloud-sdk-379.0.0-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
/root/google-cloud-sdk/bin/gcloud init
/root/google-cloud-sdk/bin/gcloud auth list
gcloud components update
gcloud dns managed-zones create nabla-01 \
  --description=nabla \
  --dns-name=albandrieu.com \
  --labels=project=nabla \
  --visibility=public
/root/google-cloud-sdk/bin/gcloud dns managed-zones list
export CLOUDSDK_ACTIVE_CONFIG_NAME=default
cd .acme.sh/
./acme.sh --issue --dns dns_gcloud -d nabla.albandrieu.com --dnssleep 30 --force --standalone --fullchain-file /root/.acme.sh/nabla.albandrieu.com/fullchain.cer
.acme.sh/acme.sh --issue --dns dns_gcloud -d nabla.albandrieu.com --dnssleep 30 --force --apache -w /usr/local/www/apache24/data/
echo "" > /home/.acme/NWwUBjkZQ8I53ytRufr_MkNaLr0RrnqoZjiRdKglCYQ
echo "" > /home/.acme/f5QYsbQmJcoL2FeKqwbLEdOpgOX8MZHtmooxDw2x7mc
acme.sh --install-cert --dns dns_gcloud -d nabla.albandrieu.com -d '*.albandrieu.com' --reloadcmd "/root/deploy-freenas/deploy_freenas.py"
exit 0
