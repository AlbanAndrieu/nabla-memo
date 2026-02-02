#!/bin/bash
set -xv
rm -Rf /home/albanandrieu/.pyenv
curl -L https://pyenv.run|  bash
echo 'export PATH="~/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
source ~/.bashrc
pyenv init --path
pyenv update
pyenv install miniconda3-latest
pyenv uninstall 3.10.9
pyenv install 3.10.9
pyenv install 3.12.3
pyenv install 3.13.3
pyenv install 3.14.2
pyenv versions
pyenv local 3.10.9
cat .python-version
pyenv deactivate
pyenv activate
poetry shell
poetry env list
pyenv which python
ll /usr/bin/python
sudo ln -s /usr/bin/python3 /usr/bin/python
python --version
pyenv which pip
ll ~/.linuxbrew/bin/pip
rm -Rf ~/.linuxbrew/bin/pip
pyenv which pip
./run-pipenv.sh
sudo apt-get build-dep python3
sudo apt-get install pkg-config
sudo apt-get install build-essential gdb lcov pkg-config \
  libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
  libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
  lzma lzma-dev tk-dev uuid-dev zlib1g-dev
pyenv global system
pyenv global
pyenv local
which black
ll /home/albandrieu/.pyenv/shims/black
pyenv which black
ll /home/albandrieu/.pyenv/versions/3.8.10/bin/black
exit 0
