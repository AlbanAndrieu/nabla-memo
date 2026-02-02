#!/bin/bash
pip3 install --upgrade pip
sudo pip3 install jupyter
jupyter notebook
docker run -d -p 8000:8000 --name jupyterhub jupyterhub/jupyterhub jupyterhub
docker exec -it jupyterhub bash
exit 0
