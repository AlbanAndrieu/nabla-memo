#!/bin/bash
#set -xv

# App Launcher
echo "https://albandrieu.cloudflareaccess.com/"

echo "https://heimdall.albandrieu.com:30120/"
# add env variable APP_SOURCE=https://heimdall.albandrieu.com/
# echo "https://freenas.albandrieu.com:30120/settings"
# then added to cloudflarz tunnel : echo "http://adguardhome.albandrieu.com:30004/"
echo "https://adguardhome.albandrieu.com/login.html"
# echo "http://domain-watchdog.albandrieu.com:30317/"
echo "https://domain-watchdog.albandrieu.com/"
echo "http://twofactor-auth.albandrieu.com:30081/"
echo "https://freenas.albandrieu.com:30103/onboarding.html"
echo "https://nabla.albandrieu.com/info"
echo "https://nabla.albandrieu.com/test"
echo "https://nabla.albandrieu.com/users"

# honeypot
echo "http://172.17.0.57:3000/keywaspish.php"
# aka http://172.17.0.57:3000/ http://albandrieu.albandrieu.com:3000/keywaspish.php
echo "https://nabla.albandrieu.com/honeypot/keywaspish"
echo "https://honeypot.albandrieu.com/"
echo "http://login.albandrieu.com:3000/keywaspish.php"
echo "https://nabla.albandrieu.com/login.html"

# honeypot is failing due to wrong port 3000 on vercel https://nabla.albandrieu.com/honeypot/keywaspish
# See https://www.projecthoneypot.org/
echo "https://nextjs.albandrieu.com/"
echo "https://keycloak.albandrieu.com/"
echo "http://172.17.0.24:30238/"
# working with hostname	 http://172.17.0.24:30238/ and https://keycloak.albandrieu.com/
#  Created temporary admin user with username temp-admin
# KEYCLOAK_ADMIN="nabla"
# KEYCLOAK_ADMIN_PASSWORD="XXX"

# apache
echo "http://172.17.0.57:8082/test.php"
echo "https://home.albandrieu.com:8082/test.php"
echo "https://apache.albandrieu.com:8082/"
echo "http://albandrieu.albandrieu.com:8082/"

# home-assistant
echo "http://freenas.albandrieu.com:30103/"
echo "http://home-assistant.albandrieu.com:30103/"
echo "http://freenas:30103/"

# TODO fix http://172.17.0.57:9000/

# ntopng
echo "http://172.17.0.57:4000/"

# ollama
echo "https://ollama-gpu.albandrieu.com/"

echo "https://albandrieu.com/login"

# ftp / download

echo "http://albandrieu.albandrieu.com:8082/public/ftp/HEADER.html"
echo "http://albandrieu.albandrieu.com:8082/public/ftp/D2BUL2cuEiVxGMXh.Baba-compilation.tar.gz"
echo "http://albandrieu.albandrieu.com:8082/public/ftp/download/README.html"

exit 0
