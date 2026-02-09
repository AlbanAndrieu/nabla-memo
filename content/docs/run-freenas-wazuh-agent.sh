#!/bin/bash
set -xv

# https://www.freebsd.org/status/report-2023-04-2023-06/wazuh/

# pkg install security/wazuh-agent
# Install agent will remove wazuh-manager

# pkg upgrade
portsnap fetch extract update

pkg install security/py-fail2ban

pkg install security/wazuh-agent
service wazuh-agent enable

exit 0
