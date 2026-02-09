#!/bin/bash
set -xv

sudo snap install google-cloud-sdk --classic
gcloud init
gcloud auth login

gcloud config set project ${GCLOUD_PROJECT_ID}
gcloud version

# Install AI platform components
gcloud components install alpha beta

# Enable AI services
gcloud services enable aiplatform.googleapis.com

#less /home/albandrieu/.boto
gcloud auth list

gcloud services enable \
    --project ${GCLOUD_PROJECT_ID} \
    "places.googleapis.com"

gcloud services api-keys list

echo "127.0.0.1:18789"

pkg install python socat
#pkg install py38-pip py38-requests
# NOK pip install pysqlite3
pkg install py38-sqlite3

pkg install py38-certbot py38-certbot-apache

# See https://www.cyberciti.biz/faq/howto-deploying-freebsd11-unix-on-google-cloud/
type -a python
/usr/local/bin/python --version

# See https://cloud.google.com/sdk/docs/downloads-versioned-archives

# wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-379.0.0-linux-x86_64.tar.gz
# tar zxvf google-cloud-sdk-379.0.0-linux-x86_64.tar.gz

./google-cloud-sdk/install.sh

/root/google-cloud-sdk/bin/gcloud init
/root/google-cloud-sdk/bin/gcloud auth list

gcloud components update

# See https://cloud.google.com/sdk/auth_success

# ADD https://cloud.google.com/dns/zones
# https://console.cloud.google.com/net-services/dns/zones/nabla?project=nabla-01&folder&organizationId=1069974290280&dnsResourceRecordSetssize=50

gcloud dns managed-zones create nabla-01 \
  --description=nabla \
  --dns-name=albandrieu.com \
  --labels=project=nabla \
  --visibility=public

/root/google-cloud-sdk/bin/gcloud dns managed-zones list

# See https://console.cloud.google.com/net-services/dns/zones?project=nabla-01

# https://console.cloud.google.com/net-services/dns/zones/nabla-01/details?project=nabla-01

#gcloud compute instances list

#alban.andrieu@nabla.mobi

export CLOUDSDK_ACTIVE_CONFIG_NAME=default # see the note above
cd .acme.sh/
#acme.sh --issue --dns dns_gcloud -d albandrieu.com -d nabla.albandrieu.com -d '*.albandrieu.com'
#acme.sh --issue --dns dns_gcloud -d nabla.albandrieu.com -d '*.albandrieu.com' --dnssleep 30 --force --standalone --fullchain-file /root/.acme.sh/nabla.albandrieu.com/fullchain.cer
./acme.sh --issue --dns dns_gcloud -d nabla.albandrieu.com --dnssleep 30 --force --standalone --fullchain-file /root/.acme.sh/nabla.albandrieu.com/fullchain.cer
.acme.sh/acme.sh --issue --dns dns_gcloud -d nabla.albandrieu.com --dnssleep 30 --force --apache -w /usr/local/www/apache24/data/

echo "" >/home/.acme/XXX
echo "" >/home/.acme/XXX

acme.sh --install-cert --dns dns_gcloud -d nabla.albandrieu.com -d '*.albandrieu.com' --reloadcmd "/root/deploy-freenas/deploy_freenas.py"

exit 0
