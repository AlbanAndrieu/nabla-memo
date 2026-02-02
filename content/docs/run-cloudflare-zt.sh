#!/bin/bash
ssh-log-cli generate-key-pair -o sshkey
ll sshkey*
sudo geany /etc/ssh/ca.pub
sudo geany /etc/ssh/sshd_config
sudo chmod 600 /etc/ssh/ca.pub
Add CIDR :
sudo systemctl uninstall warp-svc
warp-cli connector new $CLOUDFLARE_WARP_TOKEN
warp-cli connect
exit 0
