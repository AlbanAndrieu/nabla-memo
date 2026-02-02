#!/bin/bash
set -xv
docker exec -it 18db504251fa bash
su - postgres
CREATE USER openvas WITH PASSWORD "$POSTGRES_OPENVAS_PASSWORD"
CREATE DATABASE gvmd WITH OWNER openvas ENCODING 'UTF8'
GRANT ALL PRIVILEGES ON DATABASE gvmd to openvas
ALTER ROLE openvas SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN REPLICATION NOBYPASSRLS
sudo apt-get install gnupg2
gpg2 --list-keys
gpg2 --import jsumundi.asc
gpg2 --trust-model always -o "$final_backup_dir/$DUMP_FILE_GPG"     --encrypt --recipient "Jus Mundi" "$final_backup_dir/$DUMP_FILE_TMP"
gpg2 --decrypt metabase-prod-2024-03-18-0000.sql.gz.gpg > metabase-prod-2024-03-18-0000.sql.gz
gunzip metabase-prod-2024-03-18-0000.sql.gz
psql -f /mnt/data/temp/dump-gvmd-202406261345.sql -h pg-gra.service.gra.uat.consul --port=5432 -U bofo -d gvmd
exit 0
