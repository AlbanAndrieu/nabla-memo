#!/bin/bash
set -xv
pkg install python311 py311-sqlite3
sysrc homeassistant_python=/usr/local/bin/python3.11
service homeassistant reinstall homeassistant
pkg install py-paperless-ngx
exit 0
