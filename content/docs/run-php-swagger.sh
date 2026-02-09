#!/bin/bash
set -xv

php -v

# See https://zircote.github.io/swagger-php/guide/installation.html

composer global require zircote/swagger-php

curl -X GET -I "http://localhost/api/search?lang=en&page=1&exactmatch=" -H "accept: application/json"
curl -X GET -I "http://localhost/api/search?page=1&lang=en&document-types%5B0%5D=case" -H "accept: application/json"
# curl -X GET "http://localhost/api/search?lang=en&page=1&exactmatch=&rules-jurisdiction=test" -H "accept: application/json"

bin/console server:run -q 0.0.0.0:8000

# http://0.0.0.0:8000/api/doc

curl -X GET -I "http://localhost:8000/api/search?lang=en&page=1&exactmatch=" -H "accept: application/json"
curl -X GET -I "http://0.0.0.0:8000/api/search?lang=en&page=1&exactmatch=" -H "accept: application/json"

curl -X GET "http://search-engine-api.service.gra.uat.consul/api/search?page=1&lang=en" -H "accept: application/json"
curl -X GET "http://search-engine-api.service.gra.uat.consul/api/search?query=Germany&page=1&lang=en&document-types%5B0%5D=case" -H "accept: application/json"
curl -X GET "http://search-engine-api.service.gra.uat.consul/api/search?page=1&lang=en&search?query=Germany" -H "accept: application/json"

curl -X GET "http://localhost/api/search?page=1&lang=en&search?query=Germany" -H "accept: application/json"

curl -X GET "http://search-engine-api.service.gra.uat.consul/api/agg/case-institutions" -H "accept: application/json"
curl -X GET "http://search-engine-api.service.gra.uat.consul/api/search?query=Germany&page=1&lang=en&document-types%5B0%5D=case" -H "accept: application/json"
# https://jusmundi.com/en/api/agg/case-institutions?page=1&lang=en
# https://jusmundi.com/en/api/search?query=sport

rm -Rf ~/.cache/composer ~/.config/composer/

exit 0
