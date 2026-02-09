#!/bin/bash
#set -xve

# https://developer.hashicorp.com/vault/tutorials/secrets-management/pki-engine

# https://developer.hashicorp.com/vault/tutorials/secrets-management/pki-engine-external-ca

# https://www.hashicorp.com/blog/certificate-management-with-vault

vault secrets enable -tls-skip-verify pki
# vault secrets enable -path=pki_int pki

vault status -tls-skip-verify

# https://developer.hashicorp.com/vault/tutorials/pki/pki-engine#policy-requirements

git clone https://github.com/hashicorp-education/learn-vault-pki-engine
cd learn-vault-pki-engine/terraform

vault read -tls-skip-verify pki_int/roles/example-dot-com
# Get issues
# vault list -tls-skip-verify  -format=json pki/issuers/ | jq -r '.[]'
vault read -tls-skip-verify pki/issuer/default

# https://developer.hashicorp.com/vault/api-docs/secret/pki#generate-certificate

ll root_2024_ca.crt
ll intermediate.cert.pem
ll pki_intermediate.csr

vault auth enable approle

echo $VAULT_NAMESPACE
export VAULT_NAMESPACE=cicd

curl -k \
  --header "X-Vault-Token: $VAULT_TOKEN" \
  --request LIST \
  $VAULT_ADDR/v1/pki/roles

curl -k \
  --header "X-Vault-Token: $VAULT_TOKEN" \
  $VAULT_ADDR/v1/pki/roles/test-example-dot-com

# https://developer.hashicorp.com/vault/api-docs/secret/pki#generate-certificate-and-key
curl -k \
  --header "X-Vault-Token: echo $VAULT_TOKEN" \
  --request POST \
  --data @payload.json \
  $VAULT_ADDR/v1/pki/issue/test-example-dot-com

curl -k \
  --header "X-Vault-Token: echo $VAULT_TOKEN" \
  --request POST \
  --data @payload.json \
  $VAULT_ADDR/v1/pki_int/issue/test-example-dot-com

curl -k \
  --header "X-Vault-Token: echo $VAULT_TOKEN" \
  --request POST \
  --data @payload.json \
  https://hashistack-servers.service.gra.dev.consul:8200/v1/pki_int/issue/example-dot-com

--------

export NOMAD_NAMESPACE=cicd
vault write -tls-skip-verify pki_int/issue/example-dot-com common_name="fastapi-sample.service.gra.dev.consul" ttl="24h"
write pki_int/issue/example-dot-com common_name=fastapi-sample.service.gra.dev.consul

# https://developer.hashicorp.com/vault/docs/audit
vault audit enable -tls-skip-verify file file_path=/var/log/vault_audit.log

exit 0
