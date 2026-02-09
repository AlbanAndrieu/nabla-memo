#!/bin/bash
set -xv

# https://www.baeldung.com/postman-keycloak-endpoints

curl -d "client_id=${KEYCLOAK_CLIENT_ID_UAT}" -d 'username=xxx' -d 'password=xxx' -d 'grant_type=password' \
  'http://localhost:8080/realms/YOUR_REALM_NAME/protocol/openid-connect/token' |
  python -m json.tool

curl -k -d "client_id=${KEYCLOAK_CLIENT_ID_UAT}" -d "client_secret=${KEYCLOAK_CLIENT_SECRET_UAT}" -d "username=${KEYCLOAK_REALM_USER_UAT}" -d "password=${KEYCLOAK_REALM_PASS_UAT}" -d "grant_type=password" \
  "${KEYCLOAK_SERVER_URL_UAT}/realms/${KEYCLOAK_REALM_UAT}/protocol/openid-connect/token" |
  python -m json.tool

export JWT_TOKEN=$(curl -k "http://jm-ksdifu78gwc45gv1s0jshgtr764jnb79.lexsportiva.tech/en/api/valid-jwt")

curl --head -H "Authorization: Bearer $JWT_TOKEN" ${KEYCLOAK_SERVER_URL_UAT}/realms/${KEYCLOAK_REALM_UAT}/protocol/openid-connect/userinfo

exit 0
