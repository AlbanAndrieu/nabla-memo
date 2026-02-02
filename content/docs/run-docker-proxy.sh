#!/bin/bash
set -xv
docker run --rm --name docker_registry_proxy -it \
  -p 0.0.0.0:3128:3128 -e ENABLE_MANIFEST_CACHE=true \
  -v $(pwd)/docker_mirror_cache:/docker_mirror_cache \
  -v $(pwd)/docker_mirror_certs:/ca \
  -e REGISTRIES="k8s.gcr.io gcr.io quay.io your.own.registry another.public.registry" \
  -e AUTH_REGISTRIES="auth.docker.io:dockerhub_username:dockerhub_password your.own.registry:username:password" \
  rpardini/docker-registry-proxy:0.6.2
exit 0
