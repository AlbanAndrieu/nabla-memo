#!/bin/bash
set -xv

curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
apt-get update

WAZUH_MANAGER="10.10.0.126" apt-get install wazuh-agent

sudo apt-get install debconf adduser procps
sudo apt-get install gnupg apt-transport-https

systemctl daemon-reload
systemctl enable wazuh-agent
sudo systemctl start wazuh-agent

sudo systemctl status wazuh-agent

# https://socfortress.medium.com/part-1-wazuh-indexer-siem-backend-9b5ab37a477c

exit 0
