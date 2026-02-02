#!/bin/bash
set -xv

docker run -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin quay.io/keycloak/keycloak:20.0.3
docker run -it  --network=host -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin --entrypoint /bin/bash quay.io/keycloak/keycloak:20.0.3

/opt/keycloak/bin/kcadm.sh config credentials --server http://keycloak.service.gra.uat.consul/auth --realm master --user admin --password admin

curl -L https://github.com/leroyguillaume/keycloak-bcrypt/releases/download/1.5.3/keycloak-bcrypt-1.5.3.jar > /opt/keycloak/providers/keycloak-bcrypt-1.5.3.jar

/opt/keycloak/bin/kc.sh build
/opt/keycloak/bin/kc.sh show-config

# https://www.keycloak.org/server/importExport

# See https://www.notion.so/jusmundi/Keycloak-configuration-1cdb85f18fee40b1b4e9af6ce9bb7366#100c41974e9c44cc9a906c3e16a0d7d0

/opt/keycloak/bin/kc.sh export --help
# /opt/keycloak/bin/kc.sh export --dir /tmp/jm --realm master --users skip
/opt/keycloak/bin/kc.sh export --dir /tmp/jm --realm master
# /opt/keycloak/bin/kc.sh export --dir /tmp/jm --realm jus_mundi --users skip
/opt/keycloak/bin/kc.sh export --dir /tmp/jm --realm jus_mundi

/opt/keycloak/bin/kc.sh import --file /tmp/jm/jus_mundi-realm.json --override false

nohup php bin/console jm:keycloak-user-migration > /var/www/html/back/var/log/keycloak-2024_02_14-1.out &

scp -r ubuntu@gra1nomadworkerprod1:/tmp/jm-full/*.json ~/Downloads/keycloak

# https://www.spicyomelet.com/sso-with-keycloak-and-hashicorp-vault/
# https://faun.pub/integrate-keycloak-with-hashicorp-vault-5264a873dd2f

curl \
--data "username=alban&password=alban&grant_type=password& client_id=vault&client_secret=<CLIENT_SECRET>" \ https://keycloak-https.service.gra.uat.consul/auth/realms/demo-realm/protocol/openid-connect/token

# TODO See Kong integration
# https://cycykum.medium.com/kong-oauth2-0-keycloak-bearer-only-client-and-jwt-d29e7d860b75
# https://www.jerney.io/secure-apis-kong-keycloak-1/
# https://faun.pub/securing-the-application-with-kong-keycloak-101-e25e0ae9ec56


# "--verbose",
"start",
"--spi-dblock-jpa-lock-wait-timeout=900", # For cluster mode
# "--hostname-admin-url=http://keycloak-admin.staging.int.jusmundi.com:8000/", # Using KC_HOSTNAME_ADMIN_URL
# "--hostname-admin-url=http://keycloak-admin.${var.env}.int.jusmundi.com:8000/", # WORKING as soon as it is not https
# "--hostname-admin-url=https://keycloak-admin.service.gra.${var.env}.consul", # TODO WARNING https not working if frontend is in http
# "--https-certificate-file /secrets/certs/jusmundi.com.cert",
# "--https-certificate-key-file /secrets/certs/jusmundi.com.key",
# TODO "--features=fips", # TODO https://www.keycloak.org/server/fips
# TODO "--fips-mode=strict", # TODO https://www.keycloak.org/server/fips
# TODO WHEN DEV are READY
# "--features=admin-fine-grained-authz,token-exchange,impersonation",

# To fix login on Nomad dev, we must use account
# KEYCLOAK_SERVER_URL=http://keycloak.service.gra.dev.consul
KEYCLOAK_SERVER_URL=http://account.dev.int.jusmundi.com

select FIRST_NAME AS "FIRST_NAME", LAST_NAME AS "LAST_NAME", EMAIL AS "EMAIL",
USERNAME AS "USERNAME", EMAIL_VERIFIED AS "EMAIL_VERIFIED", U.ID AS "ID",
C.SECRET_DATA::jsonb ->> 'value' as "PASSWORD",
C.SECRET_DATA::jsonb ->> 'salt' as "SALT",
C.CREDENTIAL_DATA::jsonb ->> 'hashIterations' as "HASHITERATIONS",
C.CREDENTIAL_DATA::jsonb ->> 'algorithm' as "ALGORITHM",
CREATED_TIMESTAMP AS "CREATED_TIMESTAMP", REALM_ID AS "REALM_ID"
from USER_ENTITY U, CREDENTIAL C
where U.ID = C.USER_ID AND U.REALM_ID = 'nabla'

# Get or create keycloak database backup

# Drop keycloak database

SELECT
    pg_terminate_backend(pid)
FROM
    pg_stat_activity
WHERE
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'keycloakuat'
    ;

-- DROP DATABASE keycloakuat;

# Restore it

cd /workspace/users/albandrieu30/jm/docker/keycloak/providers
wget https://github.com/aerogear/keycloak-metrics-spi/releases/download/5.0.0/keycloak-metrics-spi-5.0.0.jar
wget https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v2.0.0/opentelemetry-javaagent.jar
# wget https://gitlab.com/api/v4/projects/45107021/packages/maven/com/jusmundi/keycloak-theme-jusmundi/2.0.2-SNAPSHOT/keycloak-theme-jusmundi-2.0.2-20240326.095120-3.jar
# wget https://gitlab.com/api/v4/projects/50752317/packages/maven/com/jusmundi/keycloak-2fa-email-authenticator/1.0.0-SNAPSHOT/keycloak-2fa-email-authenticator-1.0.0-20240326.094909-5.jar

docker-compose up keycloak -d

Below urls are available publicly :
https://account.albandrieu.com/realms/nabla/.well-known/openid-configuration
https://account.albandrieu.com/realms/nabla/protocol/openid-connect/certs
Below if for login
https://account.albandrieu.com/realms/nabla/account

# upgrade https://medium.com/fiba-tech-lab/keycloak-migration-9d49563a7772

# tracing
DD_AGENT_HOST=datadog-agent.service.gra.dev.consul
DD_TRACE_AGENT_PORT=8126
DD_SERVICE=keycloak26
DD_WRITER_TYPE=LoggingWriter
DD_INTEGRATION_VERTX_ENABLED=false
DD_LEGACY_INSTALLER_ENABLED=true
DD_TRACE_EXECUTORS=org.jboss.threads.EnhancedQueueExecutor
DD_ENV=uat
DD_TRACE_ENABLED=false
DD_APPSEC_ENABLED=false
DATADOG_PROFILER_ENABLED=true
DD_PROFILING_ENABLED=true

# Disable below upon restoring from prod backup on dev
# KEYCLOAK_ADMIN_PASSWORD=XXX

# KC_HOSTNAME=https://keycloak-https.service.gra.dev.consul
# KC_HOSTNAME_ADMIN=https://keycloak-admin.service.gra.dev.consul
# KC_HOSTNAME_STRICT=false

# KC_HOSTNAME_BACKCHANNEL_DYNAMIC=true
KC_HOSTNAME_BACKCHANNEL_DYNAMIC=false

# Check missing column
--ALTER TABLE public.user_group_membership DROP COLUMN membership_type;

ALTER TABLE public.user_group_membership ADD membership_type varchar(255) NOT NULL;

exit 0
