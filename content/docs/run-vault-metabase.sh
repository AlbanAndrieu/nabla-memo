#!/bin/bash
vault secrets enable database
export POSTGRES_URL=metabase.service.gra.uat.consul:5434
vault write database/config/metabase \
  plugin_name=postgresql-database-plugin \
  connection_url="postgresql://{{username}}:{{password}}@$POSTGRES_URL/metabase?sslmode=disable" \
  allowed_roles=dev \
  username="metabase" \
  password="metabasepass"
tee dev.sql << EOF
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
tee metabase_policy.hcl << EOF
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
vault write database/config/metabase \
  plugin_name=postgresql-database-plugin \
  allowed_roles="dev,accessdb" \
  connection_url="postgresql://{{username}}:{{password}}@$POSTGRES_URL/metabase?sslmode=disable" \
  username="metabase" \
  password="metabasepass"
tee accessdb.sql << EOF
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
