#!/bin/bash
#set -xv

#http://jupyter.readthedocs.io/en/latest/install.html

pip3 install --upgrade pip
sudo pip3 install jupyter

#https://www.anaconda.com/download/#linux

#Visual Studio Code installed
#/usr/share/code/code

jupyter notebook

# See jupyterhub
# https://jupyterhub.readthedocs.io/en/stable/tutorial/quickstart-docker.html
docker run -d -p 8000:8000 --name jupyterhub jupyterhub/jupyterhub jupyterhub
docker exec -it jupyterhub bash

exit 0
