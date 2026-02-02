#!/bin/bash
set -xv
sudo nano /etc/suricata/suricata.yaml
sudo systemctl enable suricata
sudo systemctl status suricata
sudo suricata-update
sudo suricata -T -c /etc/suricata/suricata.yaml -v
sudo systemctl reload suricata
exit 0
