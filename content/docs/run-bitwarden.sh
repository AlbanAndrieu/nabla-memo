#!/bin/bash
set -xv
sudo snap remove bitwarden
echo "https://bitwarden.com/fr-fr/download/"
wget https://vault.bitwarden.com/download/?app=desktop&
platform=linux&
variant=deb
sudo useradd -G docker,sudo -s /bin/bash -m -d /opt/bitwarden bitwarden
sudo su - root
passwd bitwarden
su - bitwarden
curl -Lso bitwarden.sh https://go.btwrdn.co/bw-sh
chmod +x bitwarden.sh
sudo ./bitwarden.sh install
ll /app/Bitwarden/bitwarden
tail -n100 /var/log/syslog
snap connections bitwarden
sudo snap connect bitwarden:password-manager-service
sudo apparmor_parser -r /etc/apparmor.d/*snap-confine*
sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/snap-confine*
cd ~/Downloads/
wget https://github.com/bitwarden/sdk/releases/download/bws-v0.5.0/bws-x86_64-unknown-linux-gnu-0.5.0.zip
sudo cp ~/Downloads/bws-x86_64-unknown-linux-gnu-0.5.0/bws /usr/local/bin/
bws project list
sudo snap install bw
bw list --help
bw login
bw unlock --passwordenv BW_PASSWORD
bw sync
bw list items — search BW_GITHUB_TOKEN_READ_ONLY
bw list items --session $BW_SESSION
bw get fingerprint me
exit 0
