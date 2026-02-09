#!/bin/bash
#set -xv

# https://gist.github.com/berkorbay/6feda478a00b0432d13f1fc0a50467f1

sudo wget https://github.com/shiftkey/desktop/releases/download/release-2.9.3-linux3/GitHubDesktop-linux-2.9.3-linux3.deb
sudo apt-get install gdebi-core
sudo gdebi GitHubDesktop-linux-2.9.3-linux3.deb

# Add custom domain fir repo https://github.com/AlbanAndrieu/nabla-site-apache/settings/pages

# In CF CNAME github to https://github.albandrieu.com/

# Give https://github.albandrieu.com/
echo "https://github.albandrieu.com/public/"

# CLI https://github.com/cli/cli/blob/trunk/docs/install_linux.md
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

exit 0
