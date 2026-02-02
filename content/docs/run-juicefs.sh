#!/bin/bash
set -xv
JFS_LATEST_TAG="v1.2.0"
curl -sSL https://d.juicefs.com/install|  sh -
sudo juicefs version
ps -edf|  grep juicefs
juicefs status redis://juicefs-redis.service.gra.$NOMAD_VAR_env.consul:6380/13
juicefs destroy redis://juicefs-redis.service.gra.$NOMAD_VAR_env.consul:6380/13   9f020b06-54a3-4a0a-b83a-80121c7ccf68
juicefs destroy redis://juicefs-redis.service.gra.$NOMAD_VAR_env.consul:6380/10   f076a254-ad66-45e9-a7da-cc65c75056a5 -v --force
redis-cli --no-auth-warning -h juicefs-redis.service.gra.$NOMAD_VAR_env.consul   -p 6380 -n 13 flushdb
redis-cli --no-auth-warning -h juicefs-redis.service.gra.$NOMAD_VAR_env.consul   -p 6380
SELECT 13
KEYS *
flushdb
export AWS_DEFAULT_REGION="gra"
juicefs status redis://juicefs-redis.service.gra.$NOMAD_VAR_env.consul:6380/3
juicefs fsck redis://juicefs-redis.service.gra.$NOMAD_VAR_env.consul:6380/3
juicefs destroy redis://juicefs-redis.service.gra.$NOMAD_VAR_env.consul:6380/3   bb7c6d5a-0528-4ccc-b29b-ecd2b5b87f41
juicefs format redis://juicefs-redis.service.gra.$NOMAD_VAR_env.consul:6380/3   juicefs-s3-nomad-es-jaeger-dev --storage s3 --bucket https://nomad-es-jaeger-dev.s3.gra.perf.cloud.ovh.net
juicefs load redis://juicefs-redis.service.gra.$NOMAD_VAR_env.consul:6380/4   dump-2023-04-19-093801.json
curl -s "http://localhost:9567/metrics"|  grep -E "# HELP"
curl -s "http://gra1nomadworkerdev1:9567/metrics"|  grep -E "# HELP"
sudo lsof -i :9567
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 9567 -j ACCEPT
aws --endpoint-url https://s3.gra.perf.cloud.ovh.net --profile s3-dev s3 rm s3://juicefs-gra-sample-$NOMAD_VAR_env   --recursive
juicefs status redis://juicefs-redis.service.gra.$NOMAD_VAR_env.consul:6380/2
juicefs destroy redis://juicefs-redis.service.gra.$NOMAD_VAR_env.consul:6380/2   ecf43507-eda5-4cb9-bda1-297d78b63d0b
nomad volume create juicefs-csi.tf
exit 0
