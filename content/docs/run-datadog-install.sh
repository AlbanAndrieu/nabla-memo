#!/bin/bash
sudo php datadog-setup.php  --uninstall
sudo rm -f /etc/php/8.4/cli/conf.d/98-ddtrace.ini
ls -lrta /opt/datadog-httpd/datadog.conf
DD_API_KEY=$DATADOG_API_KEY_NABLA   DD_SITE="datadoghq.eu" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"
sudo usermod -a -G docker dd-agent
cd /etc/datadog-agent/conf.d
sudo cp apache.d/conf.yaml.example apache.d/conf.yaml
sudo setcap CAP_NET_BIND_SERVICE=+ep /opt/datadog-agent/bin/agent/agent
sudo getcap /opt/datadog-agent/bin/agent/agent
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
sudo -u dd-agent datadog-agent snmp walk 172.17.0.1 1.0.8802
sudo service datadog-agent restart
curl -sSL https://rum-auto-instrumentation.s3.amazonaws.com/installer/latest/install-proxy-datadog.sh|  sh -s -- \
  --proxyKind httpd \
  --appId $DATADOG_APP_ID_NABLA \
  --site datadoghq.eu \
  --clientToken $DATADOG_CLIENT_TOKEN_NABLA \
  --remoteConfigurationId 07f464ab-a195-4e57-80fc-cd8b4a2ae59d
pkg install curl
curl -LO https://github.com/DataDog/dd-trace-php/releases/latest/download/datadog-setup.php&&php datadog-setup.php --php-bin=all --enable-appsec --enable-profiling
pkg install php84-curl
sudo systemctl stop datadog-agent
sudo systemctl disable datadog-agent
exit 0
