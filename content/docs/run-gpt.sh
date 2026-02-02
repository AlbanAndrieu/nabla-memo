#!/bin/bash
set -xv
./run-conda.sh
pip3 install chardet
conda create -n textgen python=3.10.9
conda activate textgen
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
conda install -y -c "nvidia/label/cuda-11.8.0" cuda-runtime
cd /home/albandrieu/w/follow/text-generation-webui
ln -s /media/model models
./start_linux_alban.sh
ll /media/model
python download-model.py lmsys/vicuna-33b-v1.3
unset HF_PASS
python download-model.py meta-llama/Llama-2-13b-chat-hf
python download-model.py meta-llama/Llama-2-7b
python download-model.py t5-small
sudo apt install nvidia-cuda-toolkit
nvcc --version
nvidia-smi
cd /home/albandrieu/w/follow/privateGPT
ll /home/albandrieu/w/follow/privateGPT/models/
ln -s /media/model models
ll /media/model
poetry install --with ui,local
PGPT_PROFILES=local make run
unset DB_URL
unset DATABASE_URL
unset REDIS_URL
open-webui serve
ll /workspace/users/albandrieu30/nabla/env/linux/.webui_secret_key
exit 0
