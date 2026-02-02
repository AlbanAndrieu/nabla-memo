#!/bin/bash
set -xv
distribution=$(. /etc/os-release
  echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey|  sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list|  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update&&  sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
nvidia-smi
docker run --gpus all nvidia/cuda:10.0-base nvidia-smi
sudo journalctl -n -u nvidia-docker
nvidia-container-cli -k -d /dev/tty info
exit 0
