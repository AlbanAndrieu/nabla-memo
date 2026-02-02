#!/bin/bash
#set -xv

# https://ulauncher.io/

sudo add-apt-repository universe -y && sudo add-apt-repository ppa:agornostal/ulauncher -y && sudo apt update && sudo apt install ulauncher

cd ~

# https://github.com/brpaz/ulauncher-gitlab
pip3 install "python-gitlab >=1.5.1,<2.0.0" --user

# https://github.com/brpaz/ulauncher-cloudflare
cd ~/.local/share/ulauncher/extensions/com.github.brpaz.ulauncher-cloudflare
pip install -r requirements.txt
pip3 install "cloudflare>=2.8.15,<3.0.0" --user

# https://github.com/cacciaresi/ulauncher-asana
pip3 install asana==2.0.0 --user
# https://app.asana.com/0/my-apps/1207941598176318/settings

# https://github.com/brpaz/ulauncher-statuspages

ulauncher-toggle

# troubleshoot
ulauncher -v --dev |& grep "cloudflare"

less ~/.local/share/ulauncher/last.log

pyenv which python
# Upon failure
ll /usr/bin/python # is missing
sudo ln -s /usr/bin/python3 /usr/bin/python

pyenv which pip
# We need to remove pip from linuxbrew
# /home/albandrieu/.linuxbrew/bin/pip
ll ~/.linuxbrew/bin/pip # No such file or directory
rm -Rf ~/.linuxbrew/bin/pip
pyenv which pip
# /home/albandrieu/.local/bin/pip

# https://github.com/Ulauncher/ulauncher-emoji

# https://github.com/brpaz/ulauncher-github
pip3 install pygithub~=1.55 --user

# https://github.com/kbialek/ulauncher-bitwarden

# https://github.com/brpaz/ulauncher-vscode-projects

pip install --user memoization==0.4.0

exit 0
