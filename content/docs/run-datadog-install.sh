#!/bin/bash
#set -xv

sudo php datadog-setup.php  --uninstall
sudo rm -f /etc/php/8.4/cli/conf.d/98-ddtrace.ini

ls -lrta /opt/datadog-httpd/datadog.conf

# https://docs.datadoghq.com/fr/getting_started/agent/

DD_API_KEY=${DATADOG_API_KEY_NABLA} DD_SITE="datadoghq.eu" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

sudo usermod -a -G docker dd-agent

# https://app.datadoghq.eu/fleet/install-agent/latest?platform=overview

# NOK BSD https://github.com/urosgruber/datadog-agent-FreeBSD

cd /etc/datadog-agent/conf.d
sudo cp apache.d/conf.yaml.example apache.d/conf.yaml

sudo setcap CAP_NET_BIND_SERVICE=+ep /opt/datadog-agent/bin/agent/agent
sudo getcap /opt/datadog-agent/bin/agent/agent

# gpasswd -a dd-agent haproxy

# https://docs.datadoghq.com/fr/integrations/traefik/?tab=v2
agent integration install -t datadog-traefik==1.0.0 -r
agent integration install -t datadog-temporal==3.2.0 -r
sudo datadog-agent integration install -r -t datadog-zabbix==1.1.1
cd /etc/datadog-agent/conf.d/zabbix.d
sudo cp conf.yaml.example conf.yaml
sudo -u dd-agent -- datadog-agent integration install datadog-suricata==2.0.0

sudo -u dd-agent -- datadog-agent integration install datadog-ossec_security==2.0.0
sudo /var/ossec/bin/ossec-control status

sudo -u dd-agent -- datadog-agent integration install datadog-wazuh==1.0.0

sudo -u dd-agent install -m 0640 /etc/datadog-agent/system-probe.yaml.example /etc/datadog-agent/system-probe.yaml
sudo usermod -a -G systemd-journal dd-agent

# sudo -u dd-agent datadog-agent snmp walk 172.17.0.57 1.0.8802
sudo -u dd-agent datadog-agent snmp walk 172.17.0.1 1.0.8802
# sudo -u dd-agent datadog-agent snmp walk <DEVICE_IP> 1.3.6.1.4.1.9.9.23

sudo service datadog-agent restart

# as root

curl -sSL https://rum-auto-instrumentation.s3.amazonaws.com/installer/latest/install-proxy-datadog.sh | sh -s -- \
  --proxyKind httpd \
  --appId ${DATADOG_APP_ID_NABLA} \
  --site datadoghq.eu \
  --clientToken ${DATADOG_CLIENT_TOKEN_NABLA} \
  --remoteConfigurationId 07f464ab-a195-4e57-80fc-cd8b4a2ae59d

# freenas

pkg install curl

# ----------------------------------------------------------------------
# Install Datadog Tracing
# ----------------------------------------------------------------------
curl -LO https://github.com/DataDog/dd-trace-php/releases/latest/download/datadog-setup.php &&
  php datadog-setup.php --php-bin=all --enable-appsec --enable-profiling

# pkg which -o /usr/local/lib/libcurl.so.4
# /usr/local/lib/libcurl.so.4 was installed by package ftp/curl
#
# ls -l /usr/local/lib/libcurl*

# ext-curl
pkg install php84-curl
# worked on heimdall
#Installed packages to be UPGRADED:
#	php82-curl: 8.2.25 -> 8.2.28

sudo systemctl stop datadog-agent
sudo systemctl disable datadog-agent

exit 0
