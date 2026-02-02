#!/bin/bash
set -xv
sudo journalctl -n 50 -fu kong.service
curl -i rest-api-tenants.service.gra.$NOMAD_VAR_env.consul/api/v1/tenants
POST kong-admin.service.gra.$NOMAD_VAR_env.consul/services/api-v1-tenants/routes/
{
  "name": "api-v1-tenants",
  "url": "http://rest-api-tenants.service.gra.$NOMAD_VAR_env.consul/api/v1/tenants"
}
POST kong-admin.service.gra.$NOMAD_VAR_env.consul/services/api-v1-tenants/routes/
{
  "hosts": ["rest-api-tenants.service.gra.$NOMAD_VAR_env.consul"],
  "paths": ["/api/v1/tenants"]
}
curl -i -X GET \
  --url https://kong-http.service.gra.$NOMAD_VAR_env.consul/jusmundi
curl -i -X POST \
  --url http://kong-admin.service.gra.$NOMAD_VAR_env.consul/services/ \
  --data 'name=example-service' \
  --data 'url=http://mockbin.org'
curl -i -X POST --url http://localhost:8001/services/ \
  --data 'name=example-service' --data 'url=http://mockbin.org'
curl -i -X POST \
  --url http://kong-admin.service.gra.$NOMAD_VAR_env.consul/services/example-service/routes \
  --data 'hosts[]=example.com'
curl -i -X GET \
  --url http://kong-http.service.gra.$NOMAD_VAR_env.consul/ \
  --header 'Host: example.com'
curl -i -X GET --url http://kong-admin.service.gra.$NOMAD_VAR_env.consul/api/v1/tenants   --header 'Host: example.com'
curl -i -X GET --url http://kong-http.service.gra.$NOMAD_VAR_env.consul/api/v1/tenants \
  --header 'Host: api.ct.id'
http://kong-http.service.gra.$NOMAD_VAR_env.consul/jusmundi/
curl -H 'Content-Type: application/json' https://jsonplaceholder.typicode.com/users
curl -X POST \
  -H "Content-Type: application/json" \
  https://jsonplaceholder.typicode.com/users
curl -X GET \
  -H "Content-Type: application/json" \
  https://jsonplaceholder.typicode.com/users
curl -i http://kong-http.service.gra.$NOMAD_VAR_env.consul:8000/fake-api/users
curl -i -k -X GET -H 'X-Forwarded-Proto: https' https://kong-https.service.gra.dev.consul:8443/fake-api/users
curl -k -i -sv -H 'X-Forwarded-Proto: https' https://kong-https.service.gra.$NOMAD_VAR_env.consul/fake-api/users
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"name":"JohnDoe","username":"jdoe"}' \
  http://kong-http.service.gra.$NOMAD_VAR_env.consul/fake-api/users
curl -i -H "apikey:XXX" http://kong-http.service.gra.$NOMAD_VAR_env.consul/fake-api/users
curl -X POST \
  -H "Content-Type: application/json" \
  -H "apikey: XXX" \
  -d '{"name":"JohnDoe","username":"jdoe"}' \
  http://kong-http.service.gra.$NOMAD_VAR_env.consul/fake-api/users
curl -X POST \
  -H "Content-Type: application/json" \
  -H "apikey: XXX" \
  -d '{"name":"JohnDoe","username":"jdoe"}' \
  http://kong-http.service.gra.$NOMAD_VAR_env.consul/fake-api/users
http://test-demo-webapp-bteam.service.gra.dev.consul/test
http://test-demo-webapp-bteam.service.gra.bteam.consul/test
http://test-demo-webapp-bteam.bteam.service.gra.dev.consul/test
http://test-demo-webapp-ateam.ateam.service.gra.dev.consul/test
ping test-demo-webapp-bteam.bteam.int.jusmundi.com
dig @10.30.0.152 -p 8600 test-demo-webapp-bteam.service.gra.dev.consul
dig @gradns01.int.jusmundi.com test-demo-webapp-ateam.ateam.int.jusmundi.com
http://test.ateam.int.jusmundi.com/fake-api/users
http://test.staging.int.jusmundi.com
curl -sL https://github.com/kong/deck/releases/download/v1.19.1/deck_1.19.1_linux_amd64.tar.gz -o deck.tar.gz
tar -xf deck.tar.gz -C /tmp
sudo cp /tmp/deck /usr/local/bin/
deck ping --kong-addr http://kong-admin.service.gra.$NOMAD_VAR_env.consul/   --tls-skip-verify
deck dump --kong-addr http://kong-admin.service.gra.$NOMAD_VAR_env.consul   --tls-skip-verify --select-tag search-engine-api
deck diff --kong-addr http://kong-admin.service.gra.$NOMAD_VAR_env.consul   --select-tag search-engine-api
deck validate --kong-addr http://kong-admin.service.gra.$NOMAD_VAR_env.consul   --state kong.yaml --select-tag search-engine-api
deck diff --kong-addr http://kong-admin.service.gra.$NOMAD_VAR_env.consul   --select-tag test-haproxy-demo
deck sync --kong-addr http://kong-admin.service.gra.$NOMAD_VAR_env.consul   --state kong.yaml
http http://kong-admin.service.gra.$NOMAD_VAR_env.consul/|    jq ".version"
http://kong-admin.service.gra.$NOMAD_VAR_env.consul/metrics
http test.$NOMAD_VAR_env.int.jusmundi.com/fake-api/users
http DELETE http://kong-admin.service.gra.$NOMAD_VAR_env.consul/plugins/prometheus
curl -X POST http://kong-admin.service.gra.$NOMAD_VAR_env.consul/plugins/ \
  --data "name=syslog"
curl -X POST http://kong-admin.service.gra.$NOMAD_VAR_env.consul/plugins/ \
  --data "name=prometheus"
curl -X POST http://kong-admin.service.gra.$NOMAD_VAR_env.consul/plugins/ \
  --data "name=opentelemetry" \
  --data "config.endpoint=http://otel-collector.service.gra.$NOMAD_VAR_env.consul:4318/v1/traces"
curl -X POST http://localhost:8001/plugins/ \
  --data "name=zipkin" \
  --data "config.http_endpoint=http://otel-collector.service.gra.$NOMAD_VAR_env.consul:9411/api/v2/spans" \
  --data "config.sample_ratio=0.99" \
  --data "config.include_credential=true"
curl -d "username=jmcustomer&custom_id=1000" http://kong-admin.service.gra.$NOMAD_VAR_env.consul/consumers/
curl -d "username=aandrieu&custom_id=1001" http://kong-admin.service.gra.$NOMAD_VAR_env.consul/consumers/
curl -X POST http://kong-admin.service.gra.$NOMAD_VAR_env.consul/routes/keycloak-health/plugins \
  --data "name=key-auth" \
  --data "config.key_names=apikey"
curl -X POST http://kong-admin.service.gra.$NOMAD_VAR_env.consul/consumers/jmcustomer/key-auth
curl http://keycloak.staging.int.jusmundi.com:8000/health?apikey=XXX
curl http://alert-api.dev.int.jusmundi.com/alerts/notifications/count
curl -k -i https://kong-https.service.gra.$NOMAD_VAR_env.consul:443/alert-api/alerts/notifications/count
curl -k -i http://kong-http.service.gra.$NOMAD_VAR_env.consul:8000/alert-api/alerts/notifications/count
curl -i -k http://kong-https.service.gra.$NOMAD_VAR_env.consul:8000/fake-api/users
curl -i -k https://kong-https.service.gra.$NOMAD_VAR_env.consul:8443/fake-api/users
curl -i -v -k http://kong-admin.service.gra.dev.consul/
exit 0
