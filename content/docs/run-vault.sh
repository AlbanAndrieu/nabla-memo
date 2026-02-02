#!/bin/bash
curl -fsSL https://apt.releases.hashicorp.com/gpg|  sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update&&  sudo apt-get install vault
vault -version
ls -lrta /opt/vault/tls
vault server -dev
export VAULT_ADDR='http://127.0.0.1:8200'
vault login
ll ~/.vault-token
vault status -tls-skip-verify
echo $VAULT_NAMESPACE
export VAULT_NAMESPACE="admin"
export VAULT_ADDR_UAT='http://10.30.0.66:8200'
export VAULT_ADDR=$VAULT_ADDR_UAT
vault operator init
vault operator unseal
vault namespace list
vault namespace create test
vault auth list
vault auth enable github
vault write auth/github/config organization=nabla
vault write auth/github/map/teams/cloud-engineers value=default,applications
vault auth help github
vault secrets enable -path=secret kv-v2
vault kv put secret/test/webapp api-key="XXX"
vault kv get secret/test/webapp
vault secrets enable -path=nabla kv-v2
vault kv put nabla/scan/sonarcloud sonar-token="XXX"
vault kv get nabla/scan/sonarcloud
vault secrets enable -tls-skip-verify transit
vault policy list
vault policy read default
cat secret.policy.hcl|  vault policy write secret -
cat cicd.policy.hcl|  vault policy write cicd -
vault policy list
vault policy read secret
export VAULT_TOKEN="$(vault token create -field token -policy=secret)"
vault token lookup|  grep policies
vault auth enable approle
export ROLE_NAME="secret"
vault write auth/approle/role/$ROLE_NAME \
  secret_id_ttl=10m \
  token_num_uses=10 \
  token_ttl=20m \
  token_max_ttl=30m \
  secret_id_num_uses=40 \
  token_policies=secret
export ROLE_ID="$(vault read -field=role_id auth/approle/role/$ROLE_NAME/role-id)"
export SECRET_ID="$(vault write -f -field=secret_id auth/approle/role/$ROLE_NAME/secret-id)"
vault write auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID"
export VAULT_TOKEN="$(vault token create -field token -policy=cicd)"
vault token lookup|  grep policies
vault kv put infrastructure/cicd/all/slack/vault webhook="http://qsqsq"
vault kv metadata get infrastructure/cicd/all/slack
vault kv get infrastructure/cicd/all/slack
vault policy write admin admin.policy.hcl
vault auth enable userpass
vault write auth/userpass/users/aandrieu \
  password='XXX' \
  policies=admin
vault login -method=userpass \
  username=aandrieu \
  password='XXX'
sudo systemctl status vault.service
sudo systemctl restart vault.service
journalctl -fu vault.service
vault secrets enable nomad
vault mount nomad
vault token create -policy nomad-server -period 72h -orphan
Key Value
--- -----
token XXXX
token_accessor WWWWWWW
token_duration 72h
token_renewable true
token_policies ["default" "nomad-server"]
identity_policies []
policies ["default" "nomad-server"]
export VAULT_TOKEN=XXXX
curl -H "X-Vault-Token: XXXX" -X GET $VAULT_ADDR/v1/auth/token/lookup-self
ansible-vault encrypt_string 'XXXX' --name 'nomad_vault_token'
export ROLE_POLICY="secret"
vault token create -policy=$ROLE_POLICY
export VAULT_TOKEN=YYYYY
vault kv put secret/foo/bar config="jusmundi"
vault kv get secret/foo/bar
vault kv metadata get secret/foo/bar
vault token lookup
vault policy list
vault policy read $ROLE_POLICY
vault policy read nomad-server
vault list auth/token/accessors
curl -H "X-Vault-Token: YYYYY" -X GET $VAULT_ADDR/v1/auth/token/lookup-self
curl -H "X-Vault-Token: ZZZZZ" -X GET $VAULT_ADDR/v1/secret/data/foo/bar
vault token create -policy admin -namespace=infrastructure -period 72h -orphan
vault kv get infrastructure/cicd/all/slack
vault kv metadata get infrastructure/cicd/all/gpg/secret
pip install hvac=0.11.2
vault auth enable approle
vault policy write backup backup.policy.hcl
vault write auth/approle/role/gitlab token_policies=backup \
  token_ttl=1h token_max_ttl=4h
vault read auth/approle/role/gitlab/role-id
vault write -f auth/approle/role/gitlab/secret-id
vault write auth/approle/login \
  role_id=303ee972-YYYY \
  secret_id=f5b7c4d7-XXX
vault kv put secret/gitlab/test config="jusmundi"
vault kv list secret/gitlab
python vault_handler.py print
docker run --network=host --env VAULT_ADDR="$VAULT_ADDR"   --env ROLE_ID="$ROLE_ID"   --env SECRET_ID="$SECRET_ID"   --env VAULT_PREFIX="$VAULT_PREFIX"   --env ENCRYPTION_KEY="$ENCRYPTION_KEY"   --name test-vault-backup --rm jusmundi/vault-backup:latest print
ansible-vault encrypt_string "$ANSIBLE_VAULT_PASSWORD_JM"   --name 'vault_root_token'
curl --insecure -H "X-Vault-Token: $ANSIBLE_VAULT_PASSWORD_JM"   -X GET $VAULT_ADDR/v1/sys/health
curl --insecure \
  --header "X-Vault-Token:$ANSIBLE_VAULT_PASSWORD_JM" \
  $VAULT_ADDR/v1/sys/host-info
vault read sys/internal/counters/tokens
sudo systemctl restart consul.service
vault write sys/internal/counters/config enabled=enable
./run-vault-metabase.sh
envconsul -h
vault kv get secret/foo/bar
envconsul -upcase -pristine -secret secret/foo/bar env
brew install envchain
echo "Retrieves private key from HashiCorp Vault securely"
vault kv get -field=private_key secret/ssh/infra > ~/.ssh/id_ed25519_test
-------- STARTE terraform app role
vault list -tls-skip-verify auth/approle/role
vault write auth/approle/role/terraform \
  token_ttl=1h \
  token_max_ttl=4h \
  secret_id_ttl=0 \
  secret_id_num_uses=0 \
  token_policies="tf-generated-credentials-policy"
vault read auth/approle/role/terraform/role-id
echo "Role ID:"
vault read -field=role_id auth/approle/role/terraform/role-id
echo "Secret ID:"
vault write -field=secret_id -f auth/approle/role/terraform/secret-id
-------- END terraform app role
exit 0
