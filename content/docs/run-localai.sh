#!/bin/bash
set -xv

# https://localai.io/basics/getting_started/

git clone https://github.com/mudler/LocalAGI
cd LocalAGI

docker compose up -d

docker compose -f docker-compose.nvidia.yaml up

docker compose -f docker-compose.intel.yaml up

MODEL_NAME=gemma-3-12b-it docker compose up

MODEL_NAME=gemma-3-12b-it \
MULTIMODAL_MODEL=minicpm-v-4_5 \
IMAGE_MODEL=flux.1-dev-ggml \
docker compose -f docker-compose.nvidia.yaml up

echo "http://172.17.0.57:8083/"

exit 0
