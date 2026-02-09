#!/bin/bash
set -xv

# https://generativeai.pub/dont-pay-for-chatgpt-ecabf94487f3

sudo apt install nvidia-cuda-toolkit
nvcc --version

curl https://ollama.ai/install.sh | sh

OLLAMA_CONTEXT_LENGTH=8192 ollama serve
ollama run
/set parameter num_ctx 4096
ollama run llama2
# ollama run neural-chat
# ollama run mistral
# ollama run phi3
# ollama run nemotron-3-nano:30b

ollama run llama3.2
ollama run gemma3 # traduction
ollama list

# https://docs.ollama.com/faq

curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2",
  "prompt": "Why is the sky blue?",
  "options": {
    "num_ctx": 4096
  }
}'

ollama ps

ll ~/.ollama/models

export OLLAMA_MODELS="/media/model"

cd ~/.ollama/
mv models/* /media/model/ollama/
ln -s /media/model/ollama models
cd /usr/share/ollama/.ollama/models
sudo ln -s /media/model/ollama models

echo "http://172.17.0.24:30068/"
# http://172.17.0.57:11434

# Add in ollama.service
Environment="OLLAMA_HOST=0.0.0.0:11434"

sudo systemctl status ollama

cloudflared tunnel --url http://localhost:11434 --http-host-header="localhost:11434"

echo "https://ollama-gpu.albandrieu.com/"

exit 1
