#!/bin/bash
set -xv
pipenv install sqlfluff
sqlfluff lint --dialect postgres dev-init-authorization.sql
sqlfluff fix --dialect ansi dev-init-authorization.sql
sqlfluff --version
exit 0
