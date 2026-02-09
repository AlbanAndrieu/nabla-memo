#!/bin/bash
set -xv

# https://hackertarget.com/install-rapid7s-nexpose-community-edition/

# https://www.rapid7.com/products/nexpose/request-download/thank-you/

sudo apt-get install screen xvfb

wget https://download2.rapid7.com/download/InsightVM/Rapid7Setup-Linux64.bin
sudo chmod +x NeXposeSetup-Linux64.bin
sudo ./NeXposeSetup-Linux64.bin

/opt/rapid7/nexpose

# https://localhost:3780/
# database port 5432

# https://gra1crowdsec1:3780/
# database port 5433

ll /etc/systemd/system/nexposeconsole.service
sudo systemctl start nexposeconsole.service
# User : albandrieu

cd /opt/rapid7/nexpose/nsc

ll /opt/rapid7/nexpose/nsc/conf/userdb.xml

systemctl start nexposeconsole

exit 0
