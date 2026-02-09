#!/bin/bash
set -xv

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt-get install python3.11

sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
sudo apt install graphviz libcurl4 mypy

sudo apt install python3-pip
pip3 install --upgrade pip

exit 0
