#!/bin/bash
set -xv
pip3 install pipenv
pipenv shell
pipenv --clear
pipenv --venv
./run-pyenv.sh
pyenv install --list
pyenv install 3.10.9
pipenv lock --clear
pipenv --clear
pipenv install
pipenv lock
pipenv graph
pipenv --support
pip freeze -p different_pipfile
python -m pipenv install --python=/home/albandrieu/miniconda3/bin/python3.8 --site-packages --ignore-pipfile
python -m pipenv install --dev --site-packages
python -m pipenv install --dev --site-packages --verbose > pipenv.log 2>&1
pip install -U pipenv
pipenv install -d --skip-lock
which pg_config
sudo apt-get install libpq-dev
exit 0
