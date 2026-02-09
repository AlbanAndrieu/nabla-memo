#!/bin/bash
set -xv

# See https://pipenv.pypa.io/en/latest/
#sudo apt install pipenv
pip3 install pipenv
pipenv shell
#pipenv lock --requirements > requirements.txt
pipenv --clear
pipenv --venv

# Install the right python version
./run-pyenv.sh
pyenv install --list
# sudo apt install lzma-dev
pyenv install 3.10.9

# Clean current project
pipenv lock --clear
# Clean all
pipenv --clear

pipenv install
#pipenv install --dev pytest
pipenv lock

# Fix https://pyup.io/posts/pipfiles-and-docker/
# pipenv shell
# source /home/ubuntu/.local/share/virtualenvs/ubuntu-7Wf190Ea/bin/activate
#. $(pipenv --venv)/bin/activate || true

pipenv graph
pipenv --support

pip freeze -p different_pipfile

# python -m pip install pip-tools

# https://pipenv-fork.readthedocs.io/en/latest/advanced.html

#python -m pipenv install --python=/opt/conda/bin/python3.8 --site-packages --ignore-pipfile
python -m pipenv install --python=/home/albandrieu/miniconda3/bin/python3.8 --site-packages --ignore-pipfile

python -m pipenv install --dev --site-packages
python -m pipenv install --dev --site-packages --verbose >pipenv.log 2>&1

pip install -U pipenv
# pipenv lock --pre --clear
pipenv install -d --skip-lock
# Error: pg_config executable not found
which pg_config
sudo apt-get install libpq-dev

exit 0
