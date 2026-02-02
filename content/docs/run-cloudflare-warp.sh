#!/bin/bash
set -xv
./run-cloudflare-cloudflared.sh
sudo apt purge cloudflare-warp cloudflared
curl https://pkg.cloudflareclient.com/pubkey.gpg|  sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main"|  sudo tee /etc/apt/sources.list.d/cloudflare-client.list
sudo apt-get update&&  sudo apt-get install cloudflare-warp
sudo service warp-svc stop
warp-cli registration delete
warp-cli registration new
warp-cli connect
warp-cli disconnect
sudo warp-cli registration delete
warp-cli registration initialize-token-callback
warp-cli target list
sudo systemctl restart warp-svc.service
/bin/warp-taskbar
sudo geany /var/lib/cloudflare-warp/mdm.xml
auto_connect - > 0
cd /usr/local/share/ca-certificates
sudo mv managed-warp.pem managed-warp.crt
sudo cp ~/Downloads/Cloudflare_CA.pem /usr/share/ca-certificates/Cloudflare_CA.crt
sudo update-ca-certificates
pip install certifi
python -m certifi
wget https://developers.cloudflare.com/cloudflare-one/static/Cloudflare_CA.pem
echo|  cat - Cloudflare_CA.pem >> $(python -m certifi)
export CERT_PATH=$(python -m certifi)
export SSL_CERT_FILE=$CERT_PATH
export REQUESTS_CA_BUNDLE=$CERT_PATH
warp-diag
echo "https://jusmundi-zt.cloudflareaccess.com/warp"
echo "https://albandrieu.cloudflareaccess.com/warp"
warp-cli settings|  grep protocol
warp-cli status
[paramiko_connection]
record_host_keys=False
[ssh_connection]
ssh_args = -o LogLevel=QUIET -o ControlMaster=auto -o ControlPersist=2m -o UserKnownHostsFile=/dev/null
ansible -i envs/dev/inventory.ini all -m ping --limit gra1nomadworkerdev5
code tunnel service install
code tunnel service log
cloudflared tunnel diag
log show --predicate 'process == "CloudflareWARP"' --info --last 1h
log stream --predicate 'process == "CloudflareWARP"' --info
exit 0
