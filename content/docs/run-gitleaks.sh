#!/bin/bash
set -xv
cd /workspace/users/albandrieu30/follow/gitleaks/
sudo cp ./gitleaks /usr/local/bin/
/workspace/users/albandrieu30/follow/gitleaks/gitleaks protect --verbose --redact --staged
/workspace/users/albandrieu30/follow/gitleaks/gitleaks detect -v --config gitleaks.toml --source .
cat .gitleaks.toml
gitleaks detect --report-path gitleaks-report.json
gitleaks detect --baseline-path gitleaks-report.json --report-path findings.json
gitleaks protect --verbose --redact --staged
gitleaks detect -v --no-git --config .gitleaks.toml --source .
pre-commit run gitleaks-docker --all-files
39a04cf72dd589fc92fa26862b20c86da666f1dc:terraform/nomad/jobs/test/test-env-secret.nomad:gitlab-pat:104
git add .gitleaksignore
exit 0
