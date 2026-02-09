#!/bin/bash
#set -xv

# https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/use-cases/ssh/ssh-infrastructure-access/
ssh-log-cli generate-key-pair -o sshkey

ll sshkey*

sudo geany /etc/ssh/ca.pub

sudo geany /etc/ssh/sshd_config
# PubkeyAuthentication yes
# TrustedUserCAKeys /etc/ssh/ca.pub
sudo chmod 600 /etc/ssh/ca.pub

Add CIDR :
# 172.17.0.57

# https://developers.cloudflare.com/cloudflare-one/team-and-resources/devices/warp/troubleshooting/troubleshooting-guide/

# Install cert by hand https://developers.cloudflare.com/cloudflare-one/team-and-resources/devices/user-side-certificates/manual-deployment/#add-the-certificate-to-operating-systems

# Create warp tunnel named : nabla-warp

sudo systemctl uninstall warp-svc

# https://albandrieu.cloudflareaccess.com/

warp-cli connector new ${CLOUDFLARE_WARP_TOKEN}
warp-cli connect

exit 0
