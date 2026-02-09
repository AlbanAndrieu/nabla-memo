#!/bin/bash
set -xv

# See https://askubuntu.com/questions/1186058/how-to-enter-ssh-passphrase-key-once-and-for-all
sudo apt install keychain
keychain --stop mine
keychain --stop all
keychain --clear
eval $(keychain --eval)
keychain --agents list

keychain --list

# ll ~/.keychain

sudo apt-get install gnome-keyring
# gnome-keyring-daemon --start --replace --foreground --components=secrets,ssh,pcks11 &
ll ~/.local/share/keyrings

cd /etc/xdg/autostart/
sudo nano gnome-keyring-ssh.desktop
#X-GNOME-Autostart-enabled=false

journalctl -f

./run-secret-tool.sh

# https://bitwarden.com/blog/how-to-securely-store-your-secrets-manager-access-tokens-with-bash-scripting/#storing-access-tokens-with-linux-desktop

exit 0
