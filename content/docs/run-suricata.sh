#!/bin/bash
set -xv

# https://medium.com/@VSpec/suricata-and-crowdsec-setup-cef476204e78

sudo nano /etc/suricata/suricata.yaml
# change ens3
sudo systemctl enable suricata
sudo systemctl status suricata

sudo suricata-update

sudo suricata -T -c /etc/suricata/suricata.yaml -v

sudo systemctl reload suricata

exit 0
