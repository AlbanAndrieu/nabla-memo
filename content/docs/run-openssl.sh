#!/bin/bash
set -xv

#https://securitychecklist.org/
openssl s_client -showcerts -connect albandrieu.albandrieu.com:19084 |& grep '^Server public key'
curl -k --sslv3 https://albandrieu.albandrieu.com:19084
curl -k --tlsv1.0 -I https://albandrieu.albandrieu.com:19084
curl -k --tlsv1.1 -I https://albandrieu.albandrieu.com:19084
curl -k --tlsv1.2 -I https://albandrieu.albandrieu.com:19084

nmap --script ssl-enum-ciphers -p 19084 albandrieu.albandrieu.com
openssl s_client -connect albandrieu.albandrieu.com:19084 -cipher "EDH" |& grep "^Server Temp Key"
curl -k -s -I https://albandrieu.albandrieu.com:19084 | grep '^X-Frame-Options'
curl -k -s -I https://albandrieu.albandrieu.com:19084 | grep '^X-Content'

openssl version

FYI : Do not use sslscan (It is buggy) : It does not support TLSv1.1 and TLSv1.2

https://bugs.launchpad.net/ubuntu/+source/sslscan/+bug/1372741

sslscan --version
sslscan version 1.8.2
http://www.titania.co.uk
Copyright (C) Ian Ventura-Whiting 2009
sslscan --no-failed albandrieu.albandrieu.com:19097

Use instead command :
openssl s_client -connect albandrieu.albandrieu.com:19084 -tls1
openssl s_client -connect albandrieu.albandrieu.com:19084 -tls1_1
openssl s_client -connect albandrieu.albandrieu.com:19084 -tls1_2

exit 0
