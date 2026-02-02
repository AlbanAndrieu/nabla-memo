#!/bin/bash
set -xv
export CERT_HOST_NAME=albandrieu.com home.albandrieu.com
openssl s_client -servername albandrieu.com -connect albandrieu.com:443 2> /dev/null| openssl x509 -noout -dates
exit 0
