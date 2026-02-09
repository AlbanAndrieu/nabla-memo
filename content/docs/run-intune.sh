#!/bin/bash
set -xv

sudo apt install curl gpg

sudo apt remove intune-portal

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/24.04/prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/microsoft-ubuntu-$(lsb_release -cs)-prod.list'
#sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" > /etc/apt/sources.list.d/microsoft-ubuntu-jammy-prod.list'
sudo rm microsoft.gpg

sudo apt update
sudo apt install intune-portal

sudo systemctl status intune-daemon.service

eixt 0
