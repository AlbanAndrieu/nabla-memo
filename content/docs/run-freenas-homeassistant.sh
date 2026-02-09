#!/bin/bash
set -xv

# NO MORE MAINTAINED ON FREEBSD

# https://community.home-assistant.io/t/home-assistant-core-truenas-core-community-plugin/170542
# https://github.com/tprelog/iocage-homeassistant/wiki/Upgrading-Python

pkg install python311 py311-sqlite3
sysrc homeassistant_python=/usr/local/bin/python3.11
service homeassistant reinstall homeassistant

pkg install py-paperless-ngx

exit 0
