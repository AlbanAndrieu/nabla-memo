#!/bin/bash
set -xv

./run-cloudflare-cloudflared.sh

# https://app.warp.dev/get_warp?linux=true&auto_download=false
# sudo apt install ./warp-terminal_0.2024.02.20.08.01.stable.01_amd64.deb

# warp install
# https://pkg.cloudflareclient.com/

sudo apt purge cloudflare-warp cloudflared

curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
sudo apt-get update && sudo apt-get install cloudflare-warp

sudo service warp-svc stop

warp-cli registration delete
# jusmundi-zt
# warp-cli teams-enroll albandrieu.cloudflareaccess.com
# warp-cli teams-enroll jusmundi.cloudflareaccess.com

warp-cli registration new
warp-cli connect
warp-cli disconnect

sudo warp-cli registration delete
warp-cli registration initialize-token-callback

warp-cli target list

########

sudo systemctl restart warp-svc.service

/bin/warp-taskbar

sudo geany /var/lib/cloudflare-warp/mdm.xml
auto_connect - >0

# jusmundi-zt

# https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/user-side-certificates/install-cloudflare-cert/
# https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/user-side-certificates/install-cert-with-warp/#linux
cd /usr/local/share/ca-certificates
sudo mv managed-warp.pem managed-warp.crt
# https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/user-side-certificates/install-cloudflare-cert/#debian-based-distributions
# Go to https://developers.cloudflare.com/cloudflare-one/static/Cloudflare_CA.pem
sudo cp ~/Downloads/Cloudflare_CA.pem /usr/share/ca-certificates/Cloudflare_CA.crt

sudo update-ca-certificates

pip install certifi
python -m certifi
wget https://developers.cloudflare.com/cloudflare-one/static/Cloudflare_CA.pem
echo | cat - Cloudflare_CA.pem >>$(python -m certifi)
export CERT_PATH=$(python -m certifi)
export SSL_CERT_FILE=${CERT_PATH}
export REQUESTS_CA_BUNDLE=${CERT_PATH}

# https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/user-side-certificates/install-cloudflare-cert/#chrome

# debug
warp-diag

echo "https://jusmundi-zt.cloudflareaccess.com/warp"
echo "https://albandrieu.cloudflareaccess.com/warp"

warp-cli settings | grep protocol
warp-cli status

# in ansible.cfg
[paramiko_connection]
record_host_keys=False

[ssh_connection]
ssh_args = -o LogLevel=QUIET -o ControlMaster=auto -o ControlPersist=2m -o UserKnownHostsFile=/dev/null
# scp_if_ssh = True

ansible -i envs/dev/inventory.ini all -m ping --limit gra1nomadworkerdev5

# install tunnel on visualstudio
code tunnel service install
code tunnel service log

cloudflared tunnel diag

# For last hour
log show --predicate 'process == "CloudflareWARP"' --info --last 1h
# Live
log stream --predicate 'process == "CloudflareWARP"' --info

exit 0
