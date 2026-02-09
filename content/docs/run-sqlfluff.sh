#!/bin/bash
set -xv

pipenv install sqlfluff

sqlfluff lint --dialect postgres dev-init-authorization.sql
sqlfluff fix --dialect ansi dev-init-authorization.sql

sqlfluff --version
# sqlfluff, version 1.4.5

exit 0
