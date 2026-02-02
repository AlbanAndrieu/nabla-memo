#!/bin/bash
set -xv
http --verify=no POST "https://back.service.gra.dev.consul/api/neo4j/csv?name=6-persons&api_key=1234"
curl -X GET -k -i "https://manager.albandrieu.com/api/neo4j/csv?name=6-persons&api_key=XXX" \
  --header "Accept: text/html,application/xhtml+xml,application/xml"
curl -X GET -k -i "https://back.service.gra.dev.consul/api/neo4j/csv?name=7-law_firms&api_key=1234" \
  --header "Accept: text/html,application/xhtml+xml,application/xml"
https://manager.albandrieu.com/api/neo4j/csv?name=6-persons&
api_key=XXX
https://manager.albandrieu.com/service/api/neo4j/csv?api_key=XXX&
name=7-law_firms
exit 0
