#!/bin/bash
set -xv

sudo apt purge ossec-hids-server ossec-hids-agent
sudo apt purge wazuh-indexer
# sudo apt purge wazuh*

sudo bash wazuh-install.sh --uninstall

rm -rf /var/ossec/
rm -rf /var/lib/wazuh-indexer/
# rm -rf /usr/share/wazuh-indexer/
# rm -rf /etc/wazuh-indexer/
sudo rm wazuh-install*

# sudo dpkg --remove --force-all wazuh-indexer wazuh-manager ossec-hids-server
sudo apt-get --fix-broken install

# See https://documentation.wazuh.com/current/installation-guide/wazuh-server/step-by-step.html
rm -Rf /etc/apt/sources.list.d/wazuh.list*

curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list

apt-get update

# auto install
curl -sO https://packages.wazuh.com/4.9/wazuh-install.sh && sudo bash ./wazuh-install.sh -a

# You can access the web interface https://<wazuh-dashboard-ip>:443
#  User: admin
#  Password: 2J+vaKWXM2REL7*RhZq02K1kqYmgVsis

systemctl status wazuh-manager

nano /var/ossec/etc/ossec.conf

apt-get -y install filebeat
curl -so /etc/filebeat/filebeat.yml https://packages.wazuh.com/4.8/tpl/wazuh/filebeat/filebeat.yml

nano /etc/filebeat/filebeat.yml

filebeat keystore create
echo admin | filebeat keystore add username --stdin --force
echo admin | filebeat keystore add password --stdin --force

# Run the following command to make sure Filebeat is successfully installed.
sudo filebeat test output

curl -XGET https://localhost:9200 -u ${}:${ELASTICSEARCH_PASSWORD} -k

curl -k -u ${}:${ELASTICSEARCH_PASSWORD} "https://localhost:9200/_template/wazuh?pretty&filter_path=wazuh.settings.index.number_of_shards"
# See https://127.0.0.1:9200/

# systemctl restart kibana
# https://127.0.0.1:5601/status

sudo service wazuh-dashboard status
#  Could not connect to API id [default]: 3099
# https://gra1crowdsec1/api/check-api

# https://documentation.wazuh.com/current/user-manual/wazuh-dashboard/troubleshooting.html
cat /var/log/wazuh-indexer/wazuh-cluster.log | grep -i -E "error|warn"

sudo systemctl status wazuh-api

grep -iE 'error|warn' /var/ossec/logs/ossec.log | tail -n 30
# indexer-connector: WARNING: IndexerConnector initialization failed for index 'wazuh-states-vulnerabilities-gra1crowdsec1', retrying until the connection is successful
grep -iE 'error|warn' /var/ossec/logs/api.log | tail -n 30
# ERROR: Some Wazuh daemons are not ready yet in node "node01
sudo systemctl restart wazuh-manager

filebeat setup --pipelines

exit 0
