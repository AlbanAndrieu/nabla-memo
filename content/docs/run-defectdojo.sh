#!/bin/bash
set -xv
git clone https://github.com/DefectDojo/django-DefectDojo
cd django-DefectDojo
./dc-build.sh
./dc-up-d.sh postgres-redis
docker compose logs initializer|  grep "Admin password:"
echo "http://graansible01:8080/api/v2/"
echo "http://graansible01:8080/api/v2/oa3/swagger-ui/"
npm install -g cloc
cloc src --json -out cloc.json
exit 0
