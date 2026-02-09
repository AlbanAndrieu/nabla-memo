#!/bin/bash
set -xv

#$ virtualenv --python=python3 env
#$ source env/bin/activate

# https://stackabuse.com/managing-python-environments-with-direnv-and-pyenv/
rm -Rf /home/albanandrieu/.pyenv
curl -L https://pyenv.run | bash
echo 'export PATH="~/.pyenv/bin:$PATH"' >>~/.bashrc
echo 'eval "$(pyenv init -)"' >>~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >>~/.bashrc
source ~/.bashrc

pyenv init --path

# Upgrade pyenv
# cd /home/albanandrieu/.pyenv/plugins/python-build/../.. && git pull && cd -
pyenv update

# https://pythonbiellagroup.it/en/gestire-versioni-di-python/pyenv-avanzato/
#pyenv install --list
pyenv install miniconda3-latest
pyenv uninstall 3.10.9
pyenv install 3.10.9
#pyenv global 3.8.6
# sudo apt install lzma
pyenv install 3.12.3
pyenv install 3.13.3
pyenv install 3.14.2
pyenv versions

#pyenv local 3.8.10
pyenv local 3.10.9
cat .python-version

pyenv deactivate
pyenv activate
poetry shell
poetry env list

#poetry env use python3.8
#pyenv shell 3.8.6

pyenv which python
# Upon failure
ll /usr/bin/python # is missing
# Like for run-ansible.sh
sudo ln -s /usr/bin/python3 /usr/bin/python
python --version

pyenv which pip
# /home/albandrieu/.linuxbrew/bin/pip
ll ~/.linuxbrew/bin/pip # No such file or directory
rm -Rf ~/.linuxbrew/bin/pip
pyenv which pip
# /home/albandrieu/.local/bin/pip

./run-pipenv.sh

# https://devguide.python.org/getting-started/setup-building/index.html#build-dependencies
sudo apt-get build-dep python3
sudo apt-get install pkg-config
sudo apt-get install build-essential gdb lcov pkg-config \
  libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
  libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
  lzma lzma-dev tk-dev uuid-dev zlib1g-dev

# pyenv global 3.12.3
pyenv global system
pyenv global
pyenv local

which black
ll /home/albandrieu/.pyenv/shims/black
pyenv which black
ll /home/albandrieu/.pyenv/versions/3.8.10/bin/black

exit 0
