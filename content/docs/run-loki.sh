#!/bin/bash
set -xv

# See https://github.com/Neo23x0/Loki

#wget https://github.com/Neo23x0/Loki/releases/download/0.32.1/loki_0.32.1.zip

# See https://grafana.com/docs/loki/latest/tools/logcli/

git clone https://github.com/grafana/loki.git
cd loki
make logcli
cp cmd/logcli/logcli /usr/local/bin/logcli

eval "$(logcli --completion-script-bash)"

logcli query '{nomad_job="fastapi-sample"}'
# https://grafana.com/docs/loki/latest/query/query_examples/
logcli query \
  --timezone=UTC \
  --from="2023-08-11T10:00:00Z" \
  --to="2023-09-06T20:00:00Z" \
  --output=jsonl \
  '{nomad_job="front"} |= `error` != "/en/js/onerror" '

logcli query --timezone=UTC --from="2023-08-11T10:00:00Z" --to="2023-09-06T20:00:00Z" --output=jsonl '{nomad_job="front"} |= `error` != "/en/js/onerror" | logfmt'
#  | duration > 30s or status_code != "200"
# {nomad_job="front"} |= `error=\w+`

source /opt/ansible/env/bin/activate
pip install yara-python psutil netaddr pylzma colorama
#pip install psutil netaddr wmi colorama pylzma pycrypto yara-python pywin32 rfc5424-logging-handler setuptools==19.2 pyinstaller==2.1
/opt/ansible/env/bin/python loki-upgrader.py --sigsonly
/opt/ansible/env/bin/python loki.py -p /opt/ -l loki-report.log --nolisten --onlyrelevant --dontwait --noprocscan

docker plugin disable loki --force
docker plugin rm loki
sudo docker plugin install grafana/loki-docker-driver:2.8.0 --alias loki --grant-all-permissions
docker plugin enable loki

#"log-driver": "json-file",
#  "log-driver": "loki",
#  "log-opts": {
#    "loki-url": "http://loki.service.gra.dev.consul:3100/loki/api/v1/push",
#    "max-size": "100m"
#},

# In grafana
# (?i)(error|fail|lost|closed|panic|fatal|crash|password|authentication|denied)

# https://grafana.com/docs/loki/latest/alert/#interacting-with-the-ruler
sudo /usr/local/bin/lokitool rules lint files/loki/rules.yml

http://loki-read.service.gra.dev.consul:3100/ready
http://loki-read.service.gra.dev.consul:3100/loki/api/v1/rules

exit 0
