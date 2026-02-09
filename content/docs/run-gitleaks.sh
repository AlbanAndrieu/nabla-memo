#!/bin/bash
set -xv

# See https://github.com/zricethezav/gitleaks
cd /workspace/users/albandrieu30/follow/gitleaks/
sudo cp ./gitleaks /usr/local/bin/
/workspace/users/albandrieu30/follow/gitleaks/gitleaks protect --verbose --redact --staged
/workspace/users/albandrieu30/follow/gitleaks/gitleaks detect -v --config gitleaks.toml --source .

cat .gitleaks.toml

# [allowlist]
# description = "global allow lists"
# regexes = [
#     '''219-09-9999''',
#     '''078-05-1120''',
#     '''(9[0-9]{2}|666)-\d{2}-\d{4}''',
#     '''#nosec''',
#     '''allow:gitleaks''',
#     ]
# paths = [
#     '''gitleaks.toml''',
#     '''(.*?)(jpg|gif|doc|pdf|bin|svg|socket)$''',
#     '''(go.mod|go.sum)$''',
#     '''terraform/nomad/jobs/files/alertmanager/config.yml''',
#     '''terraform/nomad/jobs/4-2-keycloak.nomad''',
#     '''megalinter-reports/''',
# ]

gitleaks detect --report-path gitleaks-report.json
gitleaks detect --baseline-path gitleaks-report.json --report-path findings.json

gitleaks protect --verbose --redact --staged
gitleaks detect -v --no-git --config .gitleaks.toml --source .

pre-commit run gitleaks-docker --all-files

# Add fingerprint
39a04cf72dd589fc92fa26862b20c86da666f1dc:terraform/nomad/jobs/test/test-env-secret.nomad:gitlab-pat:104
# to
git add .gitleaksignore

exit 0
