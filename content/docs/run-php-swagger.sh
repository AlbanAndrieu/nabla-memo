#!/bin/bash
set -xv
php -v
composer global require zircote/swagger-php
curl -X GET -I "http://localhost/api/search?lang=en&page=1&exactmatch=" -H "accept: application/json"
curl -X GET -I "http://localhost/api/search?page=1&lang=en&document-types%5B0%5D=case" -H "accept: application/json"
bin/console server:run -q 0.0.0.0:8000
curl -X GET -I "http://localhost:8000/api/search?lang=en&page=1&exactmatch=" -H "accept: application/json"
curl -X GET -I "http://0.0.0.0:8000/api/search?lang=en&page=1&exactmatch=" -H "accept: application/json"
curl -X GET "http://search-engine-api.service.gra.uat.consul/api/search?page=1&lang=en" -H "accept: application/json"
curl -X GET "http://search-engine-api.service.gra.uat.consul/api/search?query=Germany&page=1&lang=en&document-types%5B0%5D=case" -H "accept: application/json"
curl -X GET "http://search-engine-api.service.gra.uat.consul/api/search?page=1&lang=en&search?query=Germany" -H "accept: application/json"
curl -X GET "http://localhost/api/search?page=1&lang=en&search?query=Germany" -H "accept: application/json"
curl -X GET "http://search-engine-api.service.gra.uat.consul/api/agg/case-institutions" -H "accept: application/json"
curl -X GET "http://search-engine-api.service.gra.uat.consul/api/search?query=Germany&page=1&lang=en&document-types%5B0%5D=case" -H "accept: application/json"
rm -Rf ~/.cache/composer ~/.config/composer/
exit 0
