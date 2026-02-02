#!/bin/bash
set -xv
sudo apt install git
sudo apt install openjdk-18-jre-headless openjdk-20-jdk
sudo update-java-alternatives -s java-1.17.0-openjdk-amd64
sudo apt install apt-transport-https rpm ansible shellcheck
sudo apt install --no-install-recommends pass git pwgen xclip gnome-keysign gpa
sudo apt install meld curl wget grc
sudo apt install maven composer golang
sudo apt install libffi-dev libsqlite3-dev
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
sudo apt install sshpass
sudo apt install xvfb
sudo apt install python3-full
sudo apt install python3-pytest python3-cairo
sudo apt install pipenv pipx
sudo apt-get install python-dev-is-python3
cd /var/www/html/
sudo ln -s /home/$USER/w/jm/docker/projects/front   front
sudo ln -s /home/$USER/w/jm/docker/projects/back   back
sudo gpasswd -a $USER   docker
sudo mkdir -p /target/lib/
sudo mkdir -p /mnt/data/temp
sudo chown -R $USER:docker   /mnt/data/
sudo chown -R $USER:docker   /var/www/html/
cd "$HOME"
sudo chown -h $USER:docker   pg_dump
cd "/home/$USER"
ln -s ./w/jm/infra/infrastructure/scripts scipts
sudo apt-get install libnss3-dev
sudo apt install podman-compose docker-compose pre-commit ansible-lint
sudo apt install npm
npx mega-linter-runner
npx update-browserslist-db@latest
npm install -g bower
npm i -g sarif-codeclimate@2.1.2
npm i -g sarif-junit@1.1.4
sudo add-apt-repository ppa:deadsnakes/ppa
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo apt install xscreensaver
./run-gnome.sh
rm -Rf /home/albanandrieu/.pyenv
curl -L https://pyenv.run|  bash
pyenv update
pyenv install 3.8.19
pyenv install 3.10.9
./run-fonts.sh
curl -sS https://starship.rs/install.sh|  sh
cd ~/w/nabla/env/linux
git-crypt status -e
sudo apt install python3-openstackclient
openstack server list
sudo mkdir /var/log/ansible/
sudo chown albanandrieu:docker /var/log/ansible/
sudo apt install ruby gem
ruby --version
brew install ruby-install
sudo apt install gradle
sudo gem install sass compass
sudo rm -rf /usr/lib/python3.11/EXTERNALLY-MANAGED
sudo apt install python3-pydrive2
CHECKOV_EXPERIMENTAL_TERRAFORM_MANAGED_MODULES=True checkov -d .
sudo apt install libbz2-dev
sudo rm -Rf /home/albanandrieu/.pyenv/versions/3.10.9
pyenv install 3.10.9
pip3 install termcolor jira pre-commit
pip3 install -U checkov
pip install --upgrade pip
sudo apt-get install gnome-browser-connector
sudo LC_ALL=C.UTF-8 sudo add-apt-repository ppa:ondrej/php
exit 0
