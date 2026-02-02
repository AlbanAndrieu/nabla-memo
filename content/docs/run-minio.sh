#!/bin/bash
set -xv
brew install minio/stable/mc
mc --autocompletion
mc alias rm minio-dev
mc alias set --debug minio-dev http://minio-api.service.gra.dev.consul --api S3v4 WeKeVsDUIhGhL1TL Cs5Ciphfg4sGD6Zs5RJsZEWplb4Vsm70
mc alias rm minio-uat
mc alias set --debug minio-uat http://minio-api.service.gra.uat.consul --api S3v4 WeKeVsDUIhGhL1TL Cs5Ciphfg4sGD6Zs5RJsZEWplb4Vsm70
mc admin prometheus generate minio-dev
mc admin update minio-dev
mc alias ls
mc ls minio-dev/ -debug --insecure
mc ilm tier ls minio-dev
mc mb minio-dev/loki
mc policy set public minio-dev/loki
exit 0
