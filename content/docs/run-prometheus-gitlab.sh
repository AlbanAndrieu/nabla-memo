#!/bin/bash
set -xv
./run-gitlab.sh
geany /home/albandrieu/.gitlab-runner/config.toml
curl -s "http://localhost:9252/metrics"|  grep -E "# HELP"
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 9252 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 8093 -j ACCEPT
curl -s "http://gragitrunner01.int.jusmundi.com:9252/metrics"|  grep -E "# HELP"
curl -s "http://grabackprod01.int.jusmundi.com:9252/metrics"|  grep -E "# HELP"
exit 0
