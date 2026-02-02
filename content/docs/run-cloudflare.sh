#!/bin/bash
set -xv
brew tap cloudflare/cloudflare
go install github.com/cloudflare/cf-terraforming/cmd/cf-terraforming@latest
cf-terraforming generate --email $CLOUDFLARE_EMAIL --token $CLOUDFLARE_API_TOKEN --zone a537b40cf663eb850fae4ebddcc30941 --resource-type cloudflare_record > importing-example.tf
./run-cloudflare-warp.sh
dig https://albandrieu.com/en +trace @1.1.1.1
curl -sI https://albandrieu.com/nabla/index|  grep "cf-cache-status"
cf-cache-status: DYNAMIC
curl -sI 'https://cdn.albandrieu.com/_fs/img/favicon.ico'
cf-cache-status: HIT
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
  --header "X-Auth-Email: $CLOUDFLARE_EMAIL" \
  --header "X-Auth-Key: $CLOUDFLARE_API_KEY" \
  --header 'Content-Type: application/json'
curl --request PATCH \
  --url https://api.cloudflare.com/client/v4/zones/e0ec42a7379d9e4b9a916eae221e55d0/settings/ipv6 \
  --header "X-Auth-Email$CLOUDFLARE_EMAIL" \
  --header "X-Auth-Key: $CLOUDFLARE_API_KEY" \
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
}' < ZONE_ID > /settings/ipv6
terraform state list
exit 0
