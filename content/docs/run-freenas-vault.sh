#!/bin/bash
#set -xv

ls /vault-data

export VAULT_ADDR='http://172.17.0.44:8200'
export VAULT_TOKEN="${VAULT_TOKEN_NABLA}"

vault secrets enable -tls-skip-verify transit

# https://developer.hashicorp.com/vault/docs/audit
touch /var/log/vault_audit.log
chown vault:wheel /var/log/vault_audit.log
vault audit enable -tls-skip-verify file file_path=/var/log/vault_audit.log

exit 0
