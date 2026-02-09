#!/bin/bash
set -xv

# See https://min.io/docs/minio/container/index.html

# See http://minio.service.gra.dev.consul/

brew install minio/stable/mc

mc --autocompletion

# http://minio.service.gra.dev.consul/access-keys/new-account

mc alias rm minio-dev
# mc alias set --debug minio-dev http://10.30.0.85:27359 --api S3v4 WeKeVsDUIhGhL1TL Cs5Ciphfg4sGD6Zs5RJsZEWplb4Vsm70
# mc alias set --debug minio-dev http://minio-api.service.gra.dev.consul:9092 --api S3v4 WeKeVsDUIhGhL1TL Cs5Ciphfg4sGD6Zs5RJsZEWplb4Vsm70
# mc alias set --debug minio-dev http://10.30.0.85:9091 --api S3v4 WeKeVsDUIhGhL1TL Cs5Ciphfg4sGD6Zs5RJsZEWplb4Vsm70
mc alias set --debug minio-dev http://minio-api.service.gra.dev.consul --api S3v4 WeKeVsDUIhGhL1TL Cs5Ciphfg4sGD6Zs5RJsZEWplb4Vsm70
mc alias rm minio-uat
#mc alias set --debug minio-uat http://10.30.0.141:21235 --api S3v4 WeKeVsDUIhGhL1TL Cs5Ciphfg4sGD6Zs5RJsZEWplb4Vsm70
mc alias set --debug minio-uat http://minio-api.service.gra.uat.consul --api S3v4 WeKeVsDUIhGhL1TL Cs5Ciphfg4sGD6Zs5RJsZEWplb4Vsm70

mc admin prometheus generate minio-dev

# scrape_configs:
# - job_name: minio-job
#   bearer_token: XXX
#   metrics_path: /minio/v2/metrics/cluster
#   scheme: http
#   static_configs:
#   - targets: ['10.30.0.85:22508']

# export MINIO_REGION=gra

mc admin update minio-dev

mc alias ls
mc ls minio-dev/ -debug --insecure

mc ilm tier ls minio-dev

# See https://hub.docker.com/r/minio/console
# mc admin user add minio-dev console test

mc mb minio-dev/loki
mc policy set public minio-dev/loki

exit 0
