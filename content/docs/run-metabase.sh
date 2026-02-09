#!/bin/bash
set -xv

run-pgp.sh

gpg2 --decrypt metabase-uat-2022-12-15-0000.sql.gz.gpg >metabase-uat-2022-12-15-0000.sql.gz

psql --set ON_ERROR_STOP=on -f metabase-uat-2022-12-15-0000.sql -h postgres-metabase.service.gra.prod.consul -p 5434 -d metabase -U metabase >metabase-uat-2022-12-15-0000.sql.log 2>&1

exit 0
