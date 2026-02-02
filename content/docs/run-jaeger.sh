#!/bin/bash
set -xv
docker run -d --name jaeger \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -p 5775:5775/udp \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 14268:14268 \
  -p 14250:14250 \
  -p 9412:9411 \
\
jaegertracing/all-in-one:1.28
See http://localhost:16686
curl -ivX POST -H "Content-Type: application/json" jaeger-elasticsearch.service.gra.uat.consul/_aliases -d '{
    "actions" : [
        { "add" : { "index" : "jaeger-span-*-*-*", "alias" : "jaeger-span-read" } },
 { "add" : { "index" : "jaeger-service-*-*-*", "alias" : "jaeger-service-read" } }
    ]
}'
exit 0
