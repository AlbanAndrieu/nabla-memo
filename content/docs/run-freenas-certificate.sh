#!/bin/bash
set -xv
./run-gcloud.sh
curl https://get.acme.sh|  sh -s email=alban.andrieu@albandrieu.com
git clone https://github.com/danb35/deploy-freenas
cp /root/deploy-freenas/deploy_config.example /root/deploy-freenas/deploy_config
nano /root/deploy-freenas/deploy_config
api_key = 2-XXX
source .bashrc
https://console.developers.google.com/billing/enable?project=1054538550931
ID:nabla-01
Billing account ID : 01D07B-C445ED-86517B
/root/.acme.sh/acme.sh --issue --dns dns_gcloud -d albandrieu.com -d '*.albandrieu.com' --reloadcmd "/root/deploy-freenas/deploy_freenas.py"
/root/.acme.sh/acme.sh --nginx --issue --dns dns_gcloud -d albandrieu.com -d '*.albandrieu.com' --reloadcmd "/root/deploy-freenas/deploy_freenas.py" --dnssleep 30
/root/.acme.sh/acme.sh --apache --issue --dns dns_gcloud -d albandrieu.com -d '*.albandrieu.com' --reloadcmd "/root/deploy-freenas/deploy_freenas.py" -w /usr/local/www/apache24/data
ls -lrta /usr/local/etc/nginx
ls -lrta /usr/local/www
echo "_acme-challenge.albandrieu.com"
csh acme.sh.csh
exit 0
