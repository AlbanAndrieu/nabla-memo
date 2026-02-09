#!/bin/bash
set -xv

./run-gcloud.sh

#See https://jorgedelacruz.uk/2019/08/20/freenas-how-to-deploy-a-lets-encrypt-ssl-certificate-in-freenas-11-x-and-https-configuration/

#curl https://get.acme.sh | sh
curl https://get.acme.sh | sh -s email=alban.andrieu@albandrieu.com

git clone https://github.com/danb35/deploy-freenas
cp /root/deploy-freenas/deploy_config.example /root/deploy-freenas/deploy_config
#in jail
#cp /deploy-freenas/deploy_config.example /deploy-freenas/deploy_config
nano /root/deploy-freenas/deploy_config
#nano /deploy-freenas/deploy_config
api_key = XXX

source .bashrc
# https://github.com/acmesh-official/acme.sh/wiki/dnsapi#49-use-google-cloud-dns-api-to-automatically-issue-cert

https://console.developers.google.com/billing/enable?project=1054538550931
ID:nabla-01
Billing account ID : 01D07B-C445ED-86517B

/root/.acme.sh/acme.sh --issue --dns dns_gcloud -d albandrieu.com -d '*.albandrieu.com' --reloadcmd "/root/deploy-freenas/deploy_freenas.py"
# Go to https://console.developers.google.com/project/1054538550931/settings
/root/.acme.sh/acme.sh --nginx --issue --dns dns_gcloud -d albandrieu.com -d '*.albandrieu.com' --reloadcmd "/root/deploy-freenas/deploy_freenas.py" --dnssleep 30
/root/.acme.sh/acme.sh --apache --issue --dns dns_gcloud -d albandrieu.com -d '*.albandrieu.com' --reloadcmd "/root/deploy-freenas/deploy_freenas.py" -w /usr/local/www/apache24/data
#-w /var/www/html
ls -lrta /usr/local/etc/nginx
ls -lrta /usr/local/www
#ls -lrta /wrkdirs/usr/ports/www/nginx/work

echo "_acme-challenge.albandrieu.com"

csh acme.sh.csh

exit 0
