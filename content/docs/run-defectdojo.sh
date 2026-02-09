#!/bin/bash
set -xv

# See https://github.com/DefectDojo/django-DefectDojo

git clone https://github.com/DefectDojo/django-DefectDojo

cd django-DefectDojo

# Building Docker images
./dc-build.sh

# Run the application (for other profiles besides postgres-redis see
# https://github.com/DefectDojo/django-DefectDojo/blob/dev/readme-docs/DOCKER.md)
./dc-up-d.sh postgres-redis

# Obtain admin credentials. The initializer can take up to 3 minutes to run.
# Use docker compose logs -f initializer to track its progress.
docker compose logs initializer | grep "Admin password:"

# https://demo.defectdojo.org/api/v2/oa3/swagger-ui/

echo "http://graansible01:8080/api/v2/"
echo "http://graansible01:8080/api/v2/oa3/swagger-ui/"

# http://graansible01:8080/api/key-v2

# See https://documentation.defectdojo.com/integrations/api-v2-docs/

# https://defectdojo.github.io/django-DefectDojo/integrations/source-code-repositories/

# add to ./docker/environments/postgres-redis.env
# DD_EMAIL_URL=smtp://:@<smtp_domain>:587

# See https://github.com/MaibornWolff/dd-import

npm install -g cloc
# npm install --sav-dev cloc
cloc src --json -out cloc.json

exit 0
