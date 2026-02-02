#!/bin/bash
set -xv
curl http://traefik.service.gra.dev.consul:8081/api/rawdata|  jq
exit 0
