#!/bin/bash
set -xv

# https://docs.stirlingpdf.com/Installation/Unix%20Installation/
cd /workspace/users/albandrieu30/nabla/infra/docker-compose
docker compose --env-file .env --env-file .env.secrets -f  docker-compose.yml up -d

echo "http://localhost:8085/"

# sudo apt-get update
# sudo apt-get install -y git automake autoconf libtool \
#     libleptonica-dev pkg-config zlib1g-dev make g++ \
#     openjdk-21-jdk python3 python3-pip
#
# mkdir ~/.git
# cd ~/.git &&\
# git clone https://github.com/agl/jbig2enc.git &&\
# cd jbig2enc &&\
# ./autogen.sh &&\
# ./configure &&\
# make &&\
# sudo make install
#
# sudo apt-get install -y libreoffice-writer libreoffice-calc libreoffice-impress tesseract-ocr
# pip3 install uno opencv-python-headless unoserver pngquant WeasyPrint --break-system-packages

exit 0
