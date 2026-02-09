#!/bin/bash
set -xv

# See https://docs.anaconda.com/anaconda/install/linux/

sudo apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

echo $PYTHONPATH

rm -Rf /home/albandrieu/miniconda3

curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh # -u

ll /home/albandrieu/miniconda3

pyenv install miniconda3-latest

ll /home/albanandrieu/.pyenv/versions/miniconda3-latest

# To disable conda on startup
#conda config --set auto_activate_base false

conda --version
#conda 4.12.0

#source /opt/ansible/env38/bin/activate
cat ~/.local/share/python_keyring/keyringrc.cfg
python -m keyring.cli --list-backends
PYTHON_KEYRING_BACKEND=keyring.backends.Windows.WinVaultKeyring

conda install python=3.8
conda info
#conda deactivate

#conda install -c pytorch pytorch
pipenv install torch

conda list

conda create --name #NAME_ENV# python=#VERSION#
conda create --name dvc python=3.8
conda activate dvc

# OR
sudo snap install dvc --classic
dvc pull

# Update available 2.1.0 -> 3.19.0
pip install dvc --upgrade
pip install dvc-s3
dvc pull

conda run which python

conda update -n base -c defaults conda

conda env export >environment.yml
# conda env export --no-builds > environment.yml
conda env create -f .\environment.yml

exit 0
