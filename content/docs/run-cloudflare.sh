#!/bin/bash
set -xv

#See https://one.dash.cloudflare.com/

#DNS OVer TLS : sfydiavc8e.cloudflare-gateway.com
#DNS Over HTTPS https://sfydiavc8e.cloudflare-gateway.com/dns-query
#IPV6 2a06:98c1:54::3:c4a2

#For ROUTER

#172.64.36.1
#172.64.36.2
#2a06:98c1:54::3:c4a2

# https://domains.google.com/registrar/albandrieu.com/dns
# Replace
# ns-cloud-c1.googledomains.com
# ns-cloud-c2.googledomains.com
# BY
# poppy.ns.cloudflare.com
# vasilii.ns.cloudflare.com

# TXT
# _dmarc
# "v=DMARC1; p=none; rua=mailto:d1eb7466ed5d418284de1f2d014f10fc@dmarc-reports.cloudflare.net,mailto:alban.andrieu@gmail.com,mailto:alban.andrieu@albandrieu.com,mailto:alban.andrieu@free.fr"

# SSL switch to Full (strict)

# https://developers.cloudflare.com/terraform/advanced-topics/import-cloudflare-resources/
brew tap cloudflare/cloudflare
# brew install cloudflare/cloudflare/cf-terraforming
go install github.com/cloudflare/cf-terraforming/cmd/cf-terraforming@latest

cf-terraforming generate --email $CLOUDFLARE_EMAIL --token $CLOUDFLARE_API_TOKEN --zone a537b40cf663eb850fae4ebddcc30941 --resource-type cloudflare_record >importing-example.tf

# Install warp

./run-cloudflare-warp.sh

# Firewall > Aliases > URLs with https://www.cloudflare.com/ips-v4

# Need strict SSL to avoid 522
# https://forum.netgate.com/topic/163686/haproxy-and-cloudflare-dns-522-error/2

dig https://albandrieu.com/en +trace @1.1.1.1

curl -sI https://albandrieu.com/nabla/index | grep "cf-cache-status"
cf-cache-status: DYNAMIC
# See perf https://uptime.betterstack.com/team/55907/monitors/1967823
curl -sI 'https://cdn.albandrieu.com/_fs/img/favicon.ico'
cf-cache-status: HIT

# jm-client-ip
# CF-Connecting-IP
grep -i 'CF-Connecting-IP' *

Cdn-Loop: cloudflare\r\n
Cf-Connecting-Ip: 2a01:cb14:beb:d400:fac7:245c:e5b0:aa0f\r\n
Cf-Ipcountry: FR\r\n
Cf-Pseudo-Ipv4: 248.11.182.85\r\n
Cf-Ray: 88a56bde5fe070f1-MRS\r\n
Cf-Connecting-Ip: 80.15.4.233

curl -fsSL https://albandrieu.com

curl --request GET \
  --url https://api.cloudflare.com/client/v4/zones/e0ec42a7379d9e4b9a916eae221e55d0/settings/ipv6 \
  --header "X-Auth-Email: ${CLOUDFLARE_EMAIL}" \
  --header "X-Auth-Key: ${CLOUDFLARE_API_KEY}" \
  --header 'Content-Type: application/json'

curl --request PATCH \
  --url https://api.cloudflare.com/client/v4/zones/e0ec42a7379d9e4b9a916eae221e55d0/settings/ipv6 \
  --header "X-Auth-Email${CLOUDFLARE_EMAIL}" \
  --header "X-Auth-Key: ${CLOUDFLARE_API_KEY}" \
  --header 'Content-Type: application/json' \
  --data '{
  "value": "off"
}'

curl --request PATCH \
  --url https://api.cloudflare.com/client/v4/zones/ \
  --header 'Authorization: Bearer <TOKEN>' \
  --header 'Content-Type: application/json' \
  --data '{
  "value": "off"
}' <ZONE_ID >/settings/ipv6

# https://developers.cloudflare.com/network/ipv6-compatibility/

# https://help.intruder.io/en/articles/4255978-how-do-i-add-intruder-s-ips-to-my-allowlist-in-cloudflare

# https://icy-morning-a257.nabla-bdf.workers.dev

terraform state list

# https://medium.com/@datajournal/cloudflare-js-challenge-how-to-solve-83c2f02b92e1

# Test Security API
# https://httpbin.api.vefnetworks.com/
# https://juice.api.vefnetworks.com/petstore#/
# turnstile https://api.vefnetworks.com/login

# cloudflared is free
# published application routes for localhosts

exit 0
