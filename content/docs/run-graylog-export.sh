#!/bin/bash
set -xv

# ${GRAYLOG_JM_URL}/search?q=%22manage%2Fuser%22&rangetype=relative&streams=610d4a6c9ab2bb729a4e36c6%2C610d4a6c9ab2bb729a4e36dc&from=300

printf '%(%Y-%m-%d)T\n' -1
# printf -v date '%(%Y-%m-%d)T\n' -1
date=$(date '+%Y-%m-%d')

echo -e "${magenta} Generating export for ${GRAYLOG_JM_URL}"

curl -s -i -X POST -u ${GRAYLOG_USER_JM}:$(cat ~/.creds/graylog) -H 'Content-Type: application/json' -H 'Accept: text/csv' -H 'X-Requested-By: cli' \
  "${GRAYLOG_JM_URL}/api/views/search/messages/64367ad130445676808e805b" -d '{
"fields_in_order": [ "timestamp", "http_request", "request_active_time", "duration_usec", "source_ip"]
}' >graylog-${date}.csv

echo -e "${magenta} ls -lrta graylog-${date}.csv "

exit 0
