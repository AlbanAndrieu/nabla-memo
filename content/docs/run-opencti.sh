#!/bin/bash
set -xv

# opencti

./run-crowdsec.sh

# See https://doc.crowdsec.net/u/cti_api/integration_opencti/

sudo apt install python3 python3-pip
sudo apt install docker-compose

docker-compose up

# https://github.com/OpenCTI-Platform/connectors

export RELEASE_VERSION="5.12.21"
wget https://github.com/OpenCTI-Platform/connectors/archive/${RELEASE_VERSION}.zip
unzip ${RELEASE_VERSION}.zip
cd connectors-${RELEASE_VERSION}/internal-enrichment/crowdsec
cd src
pip3 install -r requirements.txt
cp config.yml.sample config.yml

export CROWDSEC_OPENCTI_API_NAME="jm-2024-01-26"
# export CROWDSEC_OPENCTI_API_KEY="XXX";
curl -H "x-api-key: ${CROWDSEC_OPENCTI_API_KEY}" https://cti.api.crowdsec.net/v2/smoke/185.7.214.104 | jq .

python3 crowdsec.py

exit 0
