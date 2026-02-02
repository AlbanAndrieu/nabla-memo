#!/bin/bash
set -xv
git clone https://github.com/grafana/loki.git
cd loki
make logcli
cp cmd/logcli/logcli /usr/local/bin/logcli
eval "$(logcli --completion-script-bash)"
logcli query '{nomad_job="fastapi-sample"}'
logcli query \
  --timezone=UTC \
  --from="2023-08-11T10:00:00Z" \
  --to="2023-09-06T20:00:00Z" \
  --output=jsonl \
  '{nomad_job="front"} |= `error` != "/en/js/onerror" '
logcli query --timezone=UTC --from="2023-08-11T10:00:00Z" --to="2023-09-06T20:00:00Z" --output=jsonl '{nomad_job="front"} |= `error` != "/en/js/onerror" | logfmt'
source /opt/ansible/env/bin/activate
pip install yara-python psutil netaddr pylzma colorama
/opt/ansible/env/bin/python loki-upgrader.py --sigsonly
/opt/ansible/env/bin/python loki.py -p /opt/ -l loki-report.log --nolisten --onlyrelevant --dontwait --noprocscan
docker plugin disable loki --force
docker plugin rm loki
sudo docker plugin install grafana/loki-docker-driver:2.8.0 --alias loki --grant-all-permissions
docker plugin enable loki
sudo /usr/local/bin/lokitool rules lint files/loki/rules.yml
http://loki-read.service.gra.dev.consul:3100/ready
http://loki-read.service.gra.dev.consul:3100/loki/api/v1/rules
exit 0
