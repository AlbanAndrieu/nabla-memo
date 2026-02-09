#!/bin/bash
set -xv

sudo snap remove bitwarden # NOK login
#NOK sudo snap install bitwarden

echo "https://bitwarden.com/fr-fr/download/"

# https://bitwarden.com/help/cli/#download-and-install

#wget https://vault.bitwarden.com/download/?app=desktop&platform=linux
wget https://vault.bitwarden.com/download/?app=desktop &
platform=linux &
variant=deb

# install as webapplication

sudo useradd -G docker,sudo -s /bin/bash -m -d /opt/bitwarden bitwarden
sudo su - root
passwd bitwarden

su - bitwarden

curl -Lso bitwarden.sh https://go.btwrdn.co/bw-sh
chmod +x bitwarden.sh
sudo ./bitwarden.sh install

ll /app/Bitwarden/bitwarden

tail -n100 /var/log/syslog

# Fix issue AccessDenied: An AppArmor policy prevents this sender from sending this message to this recipient
# https://github.com/bitwarden/desktop/issues/215

# Go to Ubuntu Software
# Search for the app throwing the error
# Click Permissions
# Turn ON Read, add, change, or remove saved passwords

snap connections bitwarden
sudo snap connect bitwarden:password-manager-service

# snap-confine has elevated permissions and is not confined but should be. Refusing to continue to avoid permission escalation attacks
sudo apparmor_parser -r /etc/apparmor.d/*snap-confine*
sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/snap-confine*

# https://bitwarden.com/blog/how-to-securely-store-your-secrets-manager-access-tokens-with-bash-scripting/
# CLI_ACCESS

# Download SDK https://github.com/bitwarden/sdk/releases
cd ~/Downloads/
wget https://github.com/bitwarden/sdk/releases/download/bws-v0.5.0/bws-x86_64-unknown-linux-gnu-0.5.0.zip
sudo cp ~/Downloads/bws-x86_64-unknown-linux-gnu-0.5.0/bws /usr/local/bin/
bws project list

# CLI
sudo snap install bw
bw list --help

bw login
bw unlock --passwordenv BW_PASSWORD
# bw login --raw $BW_USER $BW_PASSWORD

bw sync

bw list items — search BW_GITHUB_TOKEN_READ_ONLY
bw list items --session $BW_SESSION
bw get fingerprint me

exit 0
