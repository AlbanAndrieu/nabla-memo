#!/bin/bash
set -xv

# https://github.com/adorsys/keycloak-config-cli
cd /workspace/users/albandrieu30/follow/keycloak-config-cli
sudo update-java-alternatives -s java-1.17.0-openjdk-amd64

# git checkout v5.11.1
git checkout v5.10.0
git checkout v6.1.5
./mvnw clean install -DskipTests

unset KEYCLOAK_CLIENT_ID

# java -jar ./target/keycloak-config-cli.jar \
#     --keycloak.url=http://localhost:58080 \
#     --keycloak.ssl-verify=false \
#     --keycloak.user=${KEYCLOAK_ADMIN_USER} \
#     --keycloak.password=${KEYCLOAK_ADMIN_PASS} \
#     --import.files.locations=./contrib/example-config/moped.json

java -jar /workspace/users/albandrieu30/follow/keycloak-config-cli/target/keycloak-config-cli.jar \
  --keycloak.url=${KEYCLOAK_SERVER_URL} \
  --keycloak.ssl-verify=false \
  --keycloak.user=${KEYCLOAK_ADMIN_USER} \
  --keycloak.password=${KEYCLOAK_ADMIN_PASS} \
  --import.files.locations=./config/realm-jusmundi-ci-export.json*

java -jar /workspace/users/albandrieu30/follow/keycloak-config-cli/target/keycloak-config-cli.jar \
  --keycloak.url=${KEYCLOAK_SERVER_URL_LOCAL} \
  --keycloak.ssl-verify=false \
  --keycloak.user=${KEYCLOAK_ADMIN_USER_LOCAL} \
  --keycloak.password=${KEYCLOAK_ADMIN_PASS_LOCAL} \
  --import.files.locations=./config/*realm-jusmundi*

docker run \
  --network=host \
  -e KEYCLOAK_URL="${KEYCLOAK_SERVER_URL_LOCAL}" \
  -e KEYCLOAK_SSL_VERIFY=false \
  -e KEYCLOAK_USER="${KEYCLOAK_ADMIN_USER_LOCAL}" \
  -e KEYCLOAK_PASSWORD="${KEYCLOAK_ADMIN_PASS_LOCAL}" \
  -e KEYCLOAK_AVAILABILITYCHECK_ENABLED=true \
  -e KEYCLOAK_AVAILABILITYCHECK_TIMEOUT=120s \
  -e IMPORT_FILES_LOCATIONS='/config/realm-jusmundi-ci-export.json*' \
  -v ./config/:/config \
  adorsys/keycloak-config-cli:latest-25

docker run \
  --network=host \
  -e KEYCLOAK_URL="${KEYCLOAK_SERVER_URL}" \
  -e KEYCLOAK_SSL_VERIFY=false \
  -e KEYCLOAK_USER="${KEYCLOAK_ADMIN_USER}" \
  -e KEYCLOAK_PASSWORD="${KEYCLOAK_ADMIN_PASS}" \
  -e KEYCLOAK_AVAILABILITYCHECK_ENABLED=true \
  -e KEYCLOAK_AVAILABILITYCHECK_TIMEOUT=1200s \
  -e IMPORT_FILES_LOCATIONS='config/uat/11_realm-jusmundi-export.json' \
  -v ./config:/config \
  adorsys/keycloak-config-cli:latest-25

exit 0
