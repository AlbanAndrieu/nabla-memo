#!/bin/bash
#set -xve

# https://developer.hashicorp.com/vault/tutorials/db-credentials/database-secrets#start-postgres

vault secrets enable database
# vault write database/config/postgresql @connection.json

#vault write database/config/postgresql \
#  plugin_name=postgresql-database-plugin \
#  allowed_roles="accessdb" \
#  connection_url="postgresql://{{username}}:{{password}}@gradbintegr01.int.jusmundi.com:5432/postgres?sslmode=disable" \
#  username="dev" \
#  password="2c9bc5bc4XXXXX"

#export POSTGRES_URL=127.0.0.1:5432
export POSTGRES_URL=metabase.service.gra.uat.consul:5434

#  psql -U root -c "CREATE ROLE \"ro\" NOINHERIT;"
#  psql -U root -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"ro\";"

vault write database/config/metabase \
  plugin_name=postgresql-database-plugin \
  connection_url="postgresql://{{username}}:{{password}}@$POSTGRES_URL/metabase?sslmode=disable" \
  allowed_roles=dev \
  username="metabase" \
  password="metabasepass"

tee dev.sql <<EOF
CREATE ROLE "{{name}}" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}' INHERIT;
GRANT ro TO "{{name}}";
EOF

vault write database/roles/dev \
  db_name=metabase \
  creation_statements=@dev.sql \
  default_ttl=1h \
  max_ttl=24h

vault read database/creds/dev

vault list sys/leases/lookup/database/creds/dev
vault write database/config/metabase \
  username_template="jusmundi-{{.RoleName}}-{{unix_time}}-{{random 8}}"

tee metabase_policy.hcl <<EOF
length=20

rule "charset" {
  charset = "abcdefghijklmnopqrstuvwxyz"
  min-chars = 1
}

rule "charset" {
  charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  min-chars = 1
}

rule "charset" {
  charset = "0123456789"
  min-chars = 1
}

rule "charset" {
  charset = "!@#$%^&*"
  min-chars = 1
}
EOF

vault write sys/policies/password/metabase policy=@metabase_policy.hcl
vault read sys/policies/password/metabase/generate

vault write database/config/metabase \
  password_policy="metabase"

vault read database/creds/dev

# https://learn.hashicorp.com/tutorials/nomad/vault-postgres

vault write database/config/metabase \
  plugin_name=postgresql-database-plugin \
  allowed_roles="dev,accessdb" \
  connection_url="postgresql://{{username}}:{{password}}@$POSTGRES_URL/metabase?sslmode=disable" \
  username="metabase" \
  password="metabasepass"
# Success! Data written to: database/config/postgresql

tee accessdb.sql <<EOF
CREATE USER "{{name}}" WITH ENCRYPTED PASSWORD '{{password}}' VALID UNTIL
'{{expiration}}';
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO "{{name}}";
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "{{name}}";
GRANT ALL ON SCHEMA public TO "{{name}}";
EOF

vault write database/roles/accessdb db_name=metabase \
  creation_statements=@accessdb.sql default_ttl=1h max_ttl=24h

vault read database/creds/accessdb

vault policy write access-tables policies/access-tables-policy.hcl

exit 0
