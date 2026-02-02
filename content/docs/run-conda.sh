#!/bin/bash
set -xv
sudo apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
echo $PYTHONPATH
rm -Rf /home/albandrieu/miniconda3
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
ll /home/albandrieu/miniconda3
pyenv install miniconda3-latest
ll /home/albanandrieu/.pyenv/versions/miniconda3-latest
conda --version
cat ~/.local/share/python_keyring/keyringrc.cfg
python -m keyring.cli --list-backends
PYTHON_KEYRING_BACKEND=keyring.backends.Windows.WinVaultKeyring
conda install python=3.8
conda info
pipenv install torch
conda list
conda create --name
conda create --name dvc python=3.8
conda activate dvc
sudo snap install dvc --classic
dvc pull
pip install dvc --upgrade
pip install dvc-s3
dvc pull
conda run which python
conda update -n base -c defaults conda
conda env export > environment.yml
conda env create -f .\environment.yml
exit 0
