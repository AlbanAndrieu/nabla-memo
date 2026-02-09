#!/bin/bash
set -xv

## Update CVE database

By doing another docker-compose up it will force feed update

Solution 1 :

# https://greenbone.github.io/docs/latest/22.4/container/workflows.html#updating-the-greenbone-community-containers

$()$(
  bash
  docker compose -f ./docker-compose.yml -p greenbone-community-edition pull notus-data vulnerability-tests scap-data dfn-cert-data cert-bund-data report-formats data-objects
  docker-compose -f ./docker-compose.yml -p greenbone-community-edition up -d notus-data vulnerability-tests scap-data dfn-cert-data cert-bund-data report-formats data-objects
  docker compose -f $DOWNLOAD_DIR/docker-compose.yml -p greenbone-community-edition exec <container-name >/bin/bash
)$()

$()$(
  bash
  sudo docker compose -f docker-compose-22.4.yml -p greenbone-community-edition down openvas
  sudo docker compose -f docker-compose-22.4.yml -p greenbone-community-edition up openvas -d
  sudo docker compose -f docker-compose-22.4.yml -p greenbone-community-edition logs openvas -f

  0 8 * * * echo "" >$(docker inspect --format='{{.LogPath}}' greenbone-community-edition-ospd-openvas-1) >/var/log/openvas-$($DATE).log 2>&1

)$()

$()$(
  bash
  docker exec -it greenbone-community-edition-gvmd-1 bash

  sudo -u gvm gvmd --rebuild && sudo -u gvm gvmd --rebuild-gvmd-data=all

)$()

# https://greenbone.github.io/docs/latest/22.4/container/index.html

## Debug OpenVAS
docker exec -it greenbone-community-edition-gvmd-1 bash

gvmd --get-users --verbose
gvmd --get-scanners
gvmd --optimize=vacuum
gvmd --rebuild
gvmd --rebuild-gvmd-data=all

exit 0
