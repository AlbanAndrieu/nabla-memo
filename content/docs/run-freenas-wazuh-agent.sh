#!/bin/bash
set -xv
portsnap fetch extract update
pkg install security/py-fail2ban
pkg install security/wazuh-agent
service wazuh-agent enable
exit 0
