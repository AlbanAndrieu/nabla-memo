#!/bin/bash
set -xv
sudo apt install glances
glances --print-completion bash|  sudo tee -a /etc/bash_completion.d/glances
source /etc/bash_completion.d/glances
pip install --upgrade pip
pip install glances
pip install bottle batinfo zeroconf netifaces pymdstat influxdb potsdb statsd pystache docker-py pysnmp pika py-cpuinfo scandir
ll ./.config/glances/glances.conf
exit 0
