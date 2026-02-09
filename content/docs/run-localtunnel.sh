#!/bin/bash
set -xv

# Boringproxy (fait tout)
# Localtunnel (fait pas le proxy)
# Expose (fait tout)

npm install -g localtunnel
npx localtunnel --port 8000
# st -p <your port> -s <your subdomain>

# http://alban.albandrieu.com:3000/
# https://www.notion.so/jusmundi/Local-service-tunneling-dac783f4e4c24c5fbfed8ad26bc3e41b

exit 0
