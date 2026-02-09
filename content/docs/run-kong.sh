#!/bin/bash
set -xv

# sudo systemctl status kong
sudo journalctl -n 50 -fu kong.service

# See http://kong-admin.service.gra.dev.consul/services
# Prometheus http://kong-admin.service.gra.dev.consul/metrics
# License http://kong-admin.service.gra.dev.consul/licenses
# http://api-gtw-http.service.gra.dev.consul/jusmundi

# See https://selvicekun.medium.com/using-kong-api-gateway-with-konga-and-grafana-monitoring-on-production-7d993d69765f

# http://konga.service.gra.dev.consul/
# http://pgadmin.service.gra.dev.consul/browser/

# Service is http://rest-api-tenants.service.gra.dev.consul/api/v1/tenants

curl -i rest-api-tenants.service.gra.${NOMAD_VAR_env}.consul/api/v1/tenants

# SERVICE CREATE
POST kong-admin.service.gra.${NOMAD_VAR_env}.consul/services/api-v1-tenants/routes/

#Body:
{
  "name": "api-v1-tenants",
  "url": "http://rest-api-tenants.service.gra.${NOMAD_VAR_env}.consul/api/v1/tenants"
}

# ROUTE
POST kong-admin.service.gra.${NOMAD_VAR_env}.consul/services/api-v1-tenants/routes/
{
  "hosts": ["rest-api-tenants.service.gra.${NOMAD_VAR_env}.consul"],
  "paths": ["/api/v1/tenants"]
}

#curl -i -X GET \
#--url http://kong-http.service.gra.${NOMAD_VAR_env}.consul/ \
#--header 'Host: example.com'

# In postman
# kong-http.service.gra.${NOMAD_VAR_env}.consul/api/v1/tenants
# In browser
# https://kong-http.service.gra.${NOMAD_VAR_env}.consul/api/v1/tenants

curl -i -X GET \
  --url https://kong-http.service.gra.${NOMAD_VAR_env}.consul/jusmundi

curl -i -X POST \
  --url http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/services/ \
  --data 'name=example-service' \
  --data 'url=http://mockbin.org'

curl -i -X POST --url http://localhost:8001/services/ \
  --data 'name=example-service' --data 'url=http://mockbin.org'

curl -i -X POST \
  --url http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/services/example-service/routes \
  --data 'hosts[]=example.com'

curl -i -X GET \
  --url http://kong-http.service.gra.${NOMAD_VAR_env}.consul/ \
  --header 'Host: example.com'

curl -i -X GET --url http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/api/v1/tenants --header 'Host: example.com'
#curl -i -X GET --url http://kong-http.service.gra.${NOMAD_VAR_env}.consul/users/4  --header 'Host: example.com'
# --header 'Host: backend-api.com'

curl -i -X GET --url http://kong-http.service.gra.${NOMAD_VAR_env}.consul/api/v1/tenants \
  --header 'Host: api.ct.id'

http://kong-http.service.gra.${NOMAD_VAR_env}.consul/jusmundi/

curl -H 'Content-Type: application/json' https://jsonplaceholder.typicode.com/users
curl -X POST \
  -H "Content-Type: application/json" \
  https://jsonplaceholder.typicode.com/users
curl -X GET \
  -H "Content-Type: application/json" \
  https://jsonplaceholder.typicode.com/users

curl -i http://kong-http.service.gra.${NOMAD_VAR_env}.consul:8000/fake-api/users
# curl -i -k http://kong-http.dev.int.albandrieu.com:8000/fake-api/users
# https_redirect_status_code: 426 # return {"message":"Please use HTTPS protocol"}
curl -i -k -X GET -H 'X-Forwarded-Proto: https' https://kong-https.service.gra.dev.consul:8443/fake-api/users
curl -k -i -sv -H 'X-Forwarded-Proto: https' https://kong-https.service.gra.${NOMAD_VAR_env}.consul/fake-api/users

curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"name":"JohnDoe","username":"jdoe"}' \
  http://kong-http.service.gra.${NOMAD_VAR_env}.consul/fake-api/users

# reader api key : XXX

curl -i -H "apikey:XXX" http://kong-http.service.gra.${NOMAD_VAR_env}.consul/fake-api/users

curl -X POST \
  -H "Content-Type: application/json" \
  -H "apikey: XXX" \
  -d '{"name":"JohnDoe","username":"jdoe"}' \
  http://kong-http.service.gra.${NOMAD_VAR_env}.consul/fake-api/users

# manager api key : XXX

curl -X POST \
  -H "Content-Type: application/json" \
  -H "apikey: XXX" \
  -d '{"name":"JohnDoe","username":"jdoe"}' \
  http://kong-http.service.gra.${NOMAD_VAR_env}.consul/fake-api/users

# GET http://search-engine-api.service.gra.${NOMAD_VAR_env}.consul/api/doc
# GET http://kong-http.service.gra.${NOMAD_VAR_env}.consul/search/api/doc/

# GET http://test-demo-webapp-bteam.service.gra.${NOMAD_VAR_env}.consul/
# GET http://kong-http.service.gra.${NOMAD_VAR_env}.consul/alban/

# test kong/konga
#
# 1 KONG standalone - http://10.30.0.20:9000/
# 2 KONG via traefik - http://kong-http.service.gra.${NOMAD_VAR_env}.consul/fake-api/users
# 3 INGRESS - http://test-demo-webapp-ateam.service.gra.${NOMAD_VAR_env}.consul/
# 4 EGRESS - http://test-demo-webapp-ateam.ateam.int.albandrieu.com

http://test-demo-webapp-bteam.service.gra.dev.consul/test
http://test-demo-webapp-bteam.service.gra.bteam.consul/test
http://test-demo-webapp-bteam.bteam.service.gra.dev.consul/test
http://test-demo-webapp-ateam.ateam.service.gra.dev.consul/test

ping test-demo-webapp-bteam.bteam.int.albandrieu.com

dig @10.30.0.152 -p 8600 test-demo-webapp-bteam.service.gra.dev.consul

dig @gradns01.int.albandrieu.com test-demo-webapp-ateam.ateam.int.albandrieu.com

# HOST win again PATH
http://test.ateam.int.albandrieu.com/fake-api/users

http://test.staging.int.albandrieu.com

# https://github.com/Kong/deck
curl -sL https://github.com/kong/deck/releases/download/v1.19.1/deck_1.19.1_linux_amd64.tar.gz -o deck.tar.gz
tar -xf deck.tar.gz -C /tmp
sudo cp /tmp/deck /usr/local/bin/

# deck ping --kong-addr http://kong-admin.service.gra.dev.consul:8001/ --tls-skip-verify
deck ping --kong-addr http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/ --tls-skip-verify
deck dump --kong-addr http://kong-admin.service.gra.${NOMAD_VAR_env}.consul --tls-skip-verify --select-tag search-engine-api
deck diff --kong-addr http://kong-admin.service.gra.${NOMAD_VAR_env}.consul --select-tag search-engine-api
deck validate --kong-addr http://kong-admin.service.gra.${NOMAD_VAR_env}.consul --state kong.yaml --select-tag search-engine-api

deck diff --kong-addr http://kong-admin.service.gra.${NOMAD_VAR_env}.consul --select-tag test-haproxy-demo

deck sync --kong-addr http://kong-admin.service.gra.${NOMAD_VAR_env}.consul --state kong.yaml

# podman run kong/deck --kong-addr http://kong-admin.service.gra.uat.consul ping

http http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/ | jq ".version"
http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/metrics

http test.${NOMAD_VAR_env}.int.albandrieu.com/fake-api/users

http DELETE http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/plugins/prometheus

curl -X POST http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/plugins/ \
  --data "name=syslog"
curl -X POST http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/plugins/ \
  --data "name=prometheus"

# https://docs.konghq.com/hub/kong-inc/opentelemetry/
#curl -X POST http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/plugins/ \
#  --data "name=opentelemetry"  \
#    --data "config.endpoint=http://jaeger-collector-http.service.gra.${NOMAD_VAR_env}.consul:14268/api/traces"

curl -X POST http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/plugins/ \
  --data "name=opentelemetry" \
  --data "config.endpoint=http://otel-collector.service.gra.${NOMAD_VAR_env}.consul:4318/v1/traces"
#     --data "config.resource_attributes.service.name=kong-${NOMAD_VAR_env}"

# OK : zipkin
curl -X POST http://localhost:8001/plugins/ \
  --data "name=zipkin" \
  --data "config.http_endpoint=http://otel-collector.service.gra.${NOMAD_VAR_env}.consul:9411/api/v2/spans" \
  --data "config.sample_ratio=0.99" \
  --data "config.include_credential=true"

# create consumer
curl -d "username=jmcustomer&custom_id=1000" http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/consumers/
curl -d "username=aandrieu&custom_id=1001" http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/consumers/

# Create Plugins Key Authentication on Routes with Consumers
# curl -X POST http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/routes/test-haproxy-webapp-ateam/plugins \
curl -X POST http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/routes/keycloak-health/plugins \
  --data "name=key-auth" \
  --data "config.key_names=apikey"

# HOW TO CHECK APIKEY and CONSUMERID
curl -X POST http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/consumers/jmcustomer/key-auth
# HOW TO HIT APIs WITH API KEY
#curl http://kong-http.service.gra.${NOMAD_VAR_env}.consul/routes?apikey=xxxSAMPLEAPIKEYxxxx

curl http://keycloak.staging.int.albandrieu.com:8000/health?apikey=XXX

# NATIVE
curl http://alert-api.dev.int.albandrieu.com/alerts/notifications/count
# HTTPS
# OK
curl -k -i https://kong-https.service.gra.${NOMAD_VAR_env}.consul:443/alert-api/alerts/notifications/count
# NOK curl -i -v -k https://alert-api.dev.int.albandrieu.com:8443/alerts/notifications/count
# HTTP
curl -k -i http://kong-http.service.gra.${NOMAD_VAR_env}.consul:8000/alert-api/alerts/notifications/count

# Using kong http
curl -i -k http://kong-https.service.gra.${NOMAD_VAR_env}.consul:8000/fake-api/users
# Using kong https
curl -i -k https://kong-https.service.gra.${NOMAD_VAR_env}.consul:8443/fake-api/users

# SNI
# curl -X POST http://127.0.0.1:8001/certificates -H 'Content-Type: multipart/form-data' -F cert=@./kong.pem -F key=@./kong.key -F snis[]=example.com
# curl -X POST http://kong-admin.service.gra.${NOMAD_VAR_env}.consul/ -H 'Content-Type: multipart/form-data' -F cert=@./kong.pem -F key=@./kong.key -F snis[]=example.com

# Get configuration
curl -i -v -k http://kong-admin.service.gra.dev.consul/

exit 0
