#!/bin/bash
export VAULT_ADDR_HCL='https://vault-cluster.vault.aa257bb4-2600-4ef4-b9ce-a97076835404.aws.hashicorp.cloud:8200'
export VAULT_TOKEN="XXX"
vault write auth/github/config organization=Banbou
vault auth enable jwt
vault write auth/jwt/config \
  oidc_discovery_url="https://token.actions.githubusercontent.com" \
  bound_issuer="https://token.actions.githubusercontent.com" \
  default_role="nabla"
vault write auth/jwt/role/nabla - << EOF
{
    "role_type": "jwt",
    "bound_subject": "",
    "bound_claims": {
        "sub": ["repo:AlbanAndrieu/nabla:ref:refs/*"]
    },
    "bound_claims_type": "glob",
    "bound_audiences": "https://github.com/AlbanAndrieu",
    "user_claim": "workflow",
    "policies": "github-policy ",
    "ttl": "1h"
}
EOF
vault policy write github-policy - << EOF
path "secret/test/*" {
  capabilities = ["read","create", "delete", "update"]
}
path "secret/data/*" {
  capabilities = ["read","create", "delete", "update"]
}
path "secret/*" {
  capabilities = ["read", "create", "delete", "update"]
}
path "nabla/data/*" {
  capabilities = ["read","create", "delete", "update"]
}
path "nabla/scan/*" {
  capabilities = ["read","create", "delete", "update"]
}
path "nabla/scan/sonarcloud/*" {
  capabilities = ["read"]
}
path "nabla/*" {
  capabilities = ["read", "create", "delete", "update"]
}
EOF
vault kv get secret/test/webapp
vault kv put nabla/scan/sonarcloud sonar-token="$SONAR_TOKEN"
vault kv get nabla/scan/sonarcloud/
GITHUB_REPO_TOKEN=$(vault token create -policy=github-policy -format json|  jq -r ".auth.client_token")
echo $GITHUB_REPO_TOKEN
VAULT_TOKEN=$GITHUB_REPO_TOKEN
vault kv get nabla/scan/sonarcloud/
vault auth enable oidc
exit 0
