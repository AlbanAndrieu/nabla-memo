#!/bin/bash
set -xv

# Trace

@usr.id:a.andrieu@nabla.com

env:uat service:front @span.kind:server @http.url_details.path:"/en/api/search"
@http.request.headers.jm-keycustomer-ip:true
@RequestHeaders.jm-keycustomer-ip:true

@SecurityAction:(block OR managedChallenge OR jsChallenge) @RequestHeaders.jm-keycustomer-ip:true

env:uat
# NOK @http.client_ip:80.15.4.233
# NOK@http.client_ip:82.66.4.247
@network.client.ip:82.66.4.247
@network.client.geoip.ipAddress:80.15.4.233

env:uat @http.url:"https://uat.albandrieu.com/en/alban"
@http.client_ip:80.15.4.233 env:uat @http.url:"https://uat.albandrieu.com/en/alban"

# @ClientIP:82.66.4.247 @network.client.geoip.ipAddress:176.190.211.55

service:sample @http.url_details.path:"/en/p/alban"

# https://jusconnect.com/en/p/alban
# http://grafana.service.gra.prod.consul/explore?schemaVersion=1&panes=%7B%22xh8%22:%7B%22datasource%22:%22loki-nomad%22,%22queries%22:%5B%7B%22refId%22:%22A%22,%22expr%22:%22%7Bnomad_job%3D%5C%22traefik%5C%22%7D%20%7C%3D%20%60%60%20%7C%20json%20%7C%20message_ServiceName%20%3D%20%60front@consulcatalog%60%20%7C%20message_request_Jm_Keycustomer_Ip%20%21%3D%20%60toto%60%20%7C%20message_referer_url_path%20%3D%20%60%2Fen%2Fp%2Femmanuel-kaufman%60%22,%22queryType%22:%22range%22,%22datasource%22:%7B%22type%22:%22loki%22,%22uid%22:%22loki-nomad%22%7D,%22editorMode%22:%22builder%22%7D%5D,%22range%22:%7B%22from%22:%22now-15m%22,%22to%22:%22now%22%7D%7D%7D&orgId=1

env:prod service:sample @http.url_details.path:"/api/user/me"

exit 0
