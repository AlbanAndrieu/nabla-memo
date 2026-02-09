#!/bin/bash
set -xv

# See https://github.com/oobabooga/text-generation-webui

./run-conda.sh

pip3 install chardet

conda create -n textgen python=3.10.9

conda activate textgen

pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
# pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
conda install -y -c "nvidia/label/cuda-11.8.0" cuda-runtime

cd /home/albandrieu/w/follow/text-generation-webui
ln -s /media/model models

./start_linux_alban.sh

# llama 2 7b model re-trained
# https://huggingface.co/meta-llama/Llama-2-7b

ll /media/model

python download-model.py lmsys/vicuna-33b-v1.3
# https://huggingface.co/meta-llama/Llama-2-13b-chat-hf
unset HF_PASS
python download-model.py meta-llama/Llama-2-13b-chat-hf
python download-model.py meta-llama/Llama-2-7b
python download-model.py t5-small

# t5-small is loading
#lmsys_vicuna-33b-v1.3
#Loading checkpoint shards: 100%|███████████████████████████████████████████████████████████████| 7/7 [01:37<00:00, 13.97s/it]
#21:48:55-673066 INFO     Loaded the model in 101.09 seconds.

# Check cuda
sudo apt install nvidia-cuda-toolkit
nvcc --version
nvidia-smi

cd /home/albandrieu/w/follow/privateGPT

ll /home/albandrieu/w/follow/privateGPT/models/
ln -s /media/model models
ll /media/model

# https://docs.privategpt.dev/#section/Quick-Local-Installation-steps

poetry install --with ui,local

PGPT_PROFILES=local make run

# https://github.com/open-webui/open-webui
# pip install open-webui
unset DB_URL
unset DATABASE_URL
unset REDIS_URL
open-webui serve
ll /workspace/users/albandrieu30/nabla/env/linux/.webui_secret_key

exit 0
