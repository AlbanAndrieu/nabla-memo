#!/bin/bash
set -euo pipefail

# Security Tools Installation and Configuration Script

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_HOME="${HOME:-/home/${USER}}"
DEBUG="${DEBUG:-0}"

# Enable debug mode if DEBUG is set
if [[ "${DEBUG}" == "1" ]]; then
    set -xv
fi

# Trap handler for errors
trap 'echo "❌ Error on line ${LINENO}" >&2' ERR

#sudo apt-get install linux-firmware

# disable wifi
sudo nmcli radio wifi off

#TODO disable wifi
sudo dmesg | grep iwl
rfkill list all
modinfo iwlwifi
grep [[:alnum:]] /sys/module/iwlwifi/parameters/*
lshw -c net
#firmware-iwlwifi
sudo rfkill block wifi
sudo rfkill block bluetooth

sudo systemctl is-enabled bluetooth
sudo systemctl disable bluetooth

sudo nano /etc/default/tlp
#DEVICES_TO_DISABLE_ON_STARTUP="bluetooth wifi wwan"

./run-sep.sh
./run-clamav.sh
./run-vuls.sh

#https://shop.hak5.org/pages/videos
#https://hunter.io/
#youtube.com defcon vishing demo
#kali linux 2020
#netsparker
#acunetix
#hashcat
# https://github.com/vavkamil/awesome-bugbounty-tools

# See https://www.scamdoc.com/fr/
# See https://lookup.icann.org/lookup
# See https://www.afnic.fr/fr/produits-et-services/services/whois/

python3 -m pip install 'semgrep>=0.94.0' # 0.80.0 buggy
semgrep login
ll ${USER_HOME}/.semgrep/settings.yml
semgrep scan --config auto

python3 -m pip install njsscan
# gosec
# curl -sfL https://raw.githubusercontent.com/securego/gosec/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v2.11.0

# https://github.com/ossf/scorecard?source=korben.info#goals
scorecard --repo=github.com/AlbanAndrieu/nabla-hooks

# See https://github.com/aquasecurity/cloudsploit
cd /workspace/users/albandrieu30/follow/cloudsploit
./index.js --json=file.json --junit=file.xml --console=text --ignore-ok

# Check tools https://geekflare.com/fr/online-scan-website-security-vulnerabilities/
# https://www.ssllabs.com/ssltest/analyze.html?d=jusmundi.com&latest
# https://www.ssltrust.com.au/ssl-tools/website-security-check?domain=jusmundi.com
# https://app.ox.security/dashboard
# https://semgrep.dev/orgs/alban-andrieu/

# https://lgtm.com/

# See https://github.com/inspec/inspec
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
# https://dev-sec.io/
cd /home/albandrieu/w/follow
git clone https://github.com/dev-sec/linux-baseline
inspec exec linux-baseline
git clone https://github.com/dev-sec/ssh-baseline
inspec exec ssh-baseline

# after hardening
# sudo apt-get purge openssh-client
# sudo rm /etc/ssh/revoked_keys

# fix cannot clone: Operation not permitted
#podman images
sudo nano /proc/sys/kernel/unprivileged_userns_clone
#1

journalctl -f

# See TCP syn flood attacks
./network.sh

sudo apt-get purge openssh-server
sudo systemctl mask ssh
# sudo ufw allow 22

./run-visudo.sh

# https://medium.com/aardvark-infinity/%EF%B8%8F-the-ultimate-cybersecurity-threat-intelligence-dashboard-108-feeds-of-pure-data-excess-%EF%B8%8F-4d8594e333a9
# ctid.html

# https://medium.com/aardvark-infinity/ciso-dashboard-for-strategic-cybersecurity-oversight-6940c93acc59
# ciso.html

# https://medium.com/devsecops-community/top-10-linux-security-best-practices-a-comprehensive-guide-to-protecting-your-system-908bd96dd2c9
sudo apt update && sudo apt upgrade -y
sudo apt list --upgradable

sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades

./run-fail2ban.sh

# o keep track of any suspicious activities, you should regularly monitor system logs. You can use logwatch to get daily reports of potential security incidents.
sudo apt install logwatch
sudo logwatch --detail high --mailto alban.andrieu@free.fr.com --service sshd --range today

# UI to update firmware
firmware-updater

exit 0
