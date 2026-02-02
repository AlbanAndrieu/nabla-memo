#!/bin/bash
set -xv

# https://github.com/cloudflare/cloudflared/releases
# sudo dpkg -i ~/Downloads/cloudflared-linux-amd64.deb
curl --location --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && sudo dpkg -i cloudflared.deb

sudo apt-get install --only-upgrade cloudflared

# https://dash.cloudflare.com/argotunnel?aud=&callback=https%3A%2F%2Flogin.cloudflareaccess.org%2FMVFAGbovXAhL9ru3OicSg6yhvhBbN9em1oxhkGLfQH8%3D
cloudflared tunnel login
cloudflared tunnel create nabla-albandrieu
# Tunnel credentials written to /home/albandrieu/.cloudflared/ab5097ef-dc8c-4409-9055-99eb22aa2fbe.json. cloudflared chose this file based on where your origin certificate was found. Keep this file secret. To revoke these credentials, delete the tunnel.
cloudflared tunnel list

geany $HOME/.cloudflared/config.yml

cloudflared tunnel route ip add <IP/CIDR> <UUID or NAME>
cloudflared tunnel route ip add 172.17.0.57/32 ab5097ef-dc8c-4409-9055-99eb22aa2fbe
cloudflared tunnel route dns <UUID or NAME> <hostname>

cloudflared tunnel route ip show

sudo geany /root/.cloudflared/config.yml
# same as  $HOME/.cloudflared/config.yml

cloudflared service install
systemctl start cloudflared
systemctl status cloudflared

sudo systemctl restart cloudflared.service

cloudflared tunnel info  ab5097ef-dc8c-4409-9055-99eb22aa2fbe

exit 0
