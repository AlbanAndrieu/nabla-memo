#!/bin/bash
set -euo pipefail

# SSH Installation and Configuration Script

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

sudo rm /etc/ssh/revoked_keys
sudo service ssh stop

sudo systemctl unmask sshd
sudo systemctl enable ssh.service
dpkg -l openssh-server

sudo rm /etc/systemd/system/ssh.socket

sudo apt-get purge openssh-server openssh-client
sudo apt-get install openssh-server openssh-client

sudo service ssh restart

#First, check that your SSH daemon is running:
ps -A | grep sshd

sudo ss -lnp | grep sshd

sudo lsof -i | grep ssh
netstat -l --numeric-ports | grep 22

ssh localhost

#ssh tunneling example
ssh -D 9696 albandri@albandrieu.com

As jenkins@192.168.0.29

#https://serverfault.com/questions/132970/can-i-automatically-add-a-new-host-to-known-hosts
#Add wifi
ssh-keyscan 192.168.0.19 >>~/.ssh/known_hosts
#Add ethernet
ssh-keyscan 192.168.0.18 >>~/.ssh/known_hosts

# As jenkins@albandri-laptop-work aka 192.168.0.19 (wifi) or 192.168.0.18 (ethernet)
ssh-keyscan 192.168.0.29 >>~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub | ssh jenkins@192.168.0.29 'cat >> .ssh/authorized_keys'
cat ~/.ssh/id_ed25519

./run-keychain.sh

# ssh-agent must run
eval $(ssh-agent)
echo "$SSH_AUTH_SOCK"
ssh-agent -d
# https://fabianlee.org/2021/04/05/ubuntu-loading-a-key-into-ssh-agent-at-login-with-a-user-level-systemd-service/

# check
#AddKeysToAgent yes
ll /etc/ssh_config
#ForwardAgent yes

# test passphrase prompt
ssh-agent bash

ssh-copy-id SERVER

# See https://unix.stackexchange.com/questions/85920/ssh-agent-not-getting-set-up-ssh-auth-sock-ssh-agent-pid-env-vars-not-set
echo $SSH_AGENT_PID
echo $SSH_AUTH_SOCK

ssh -Q protocol-version gra1nomadworkerprod5

sudo apt install gnustep-base-runtime
show ssh

# https://korben.info/ssh-audit-outil-indispensable-securiser-vos-serveurs.html
# https://github.com/jtesta/ssh-audit
# pip3 install ssh-audit
sudo apt install ssh-audit
ssh-audit targetserver

ssh -Q cipher

ll ~/.ssh/config
# Disable Compression for warp shh to work
Disable #Compression=yes

# Ensure KnownHosts are unreadable if leaked - it is otherwise easier to know
# which hosts your keys have access to.
HashKnownHosts yes

# Host keys the client accepts - order here is honored by OpenSSH
HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-ed25519
KexAlgorithms curve25519-sha256@libssh.org,curve25519-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha256

MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com

Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr

# Check

echo "Uses auditd to trace recent SSH login events."
sudo ausearch -k ssh_login -ts recent

echo "Monitors SSH logins and emails alerts in real time"
tail -F /var/log/auth.log | grep --line-buffered 'Accepted' | while read l; do
  echo "Login: $l" | mail -s "SSH Login Alert" admin@example.com
done

exit 0
