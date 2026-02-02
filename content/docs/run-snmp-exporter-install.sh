#!/bin/bash
set -xv
snmp_exporter_location="/usr/bin"
snmp_exporter_version="0.29.0"
wget -q https://github.com/prometheus/snmp_exporter/releases/download/v$snmp_exporter_version/snmp_exporter-$snmp_exporter_version.linux-amd64.tar.gz -O /tmp/snmp_exporter-$snmp_exporter_version.linux-amd64.tar.gz
tar xvfz /tmp/snmp_exporter-$snmp_exporter_version.linux-amd64.tar.gz -C /tmp
cd /tmp/
sudo mv snmp_exporter-$snmp_exporter_version.linux-amd64/snmp_exporter $snmp_exporter_location
sudo chmod +x $snmp_exporter_location/snmp_exporter
sudo useradd snmp_exporter
sudo cat > /tmp/snmp_exporter.service << EOF
[Unit]
Description=SNMP Exporter
After=network-online.target

# This assumes you are running snmp_exporter under the user "snmp_exporter"

[Service]
User=snmp_exporter
Restart=on-failure
ExecStart=/usr/bin/snmp_exporter --config.file=/etc/snmp_exporter/snmp.yaml

[Install]
WantedBy=multi-user.target
EOF
sudo mv /tmp/snmp_exporter.service /etc/systemd/system/snmp_exporter.service
echo "Enabling systemd service…"
sudo systemctl daemon-reload
sudo systemctl enable snmp_exporter.service
sudo mkdir /etc/snmp_exporter
exit 0
