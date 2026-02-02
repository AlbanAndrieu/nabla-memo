#!/bin/bash
set -xv
docker pull p21d13401013001.azurecr.io/fusion-risk/bower-fr-integration-test:1.8.1
docker save p21d13401013001.azurecr.io/fusion-risk/bower-fr-integration-test:1.8.1 > my-image.tar
microk8s ctr image import my-image.tar
docker pull p21d13401013001.azurecr.io/fusion-risk/jenkins-pipeline-scripts:1.0.1
docker save p21d13401013001.azurecr.io/fusion-risk/jenkins-pipeline-scripts:1.0.1 > my-image.tar
microk8s ctr image import my-image.tar
sudo microk8s ctr --debug images pull p21d13401013001.azurecr.io/fusion-risk/bower-fr-integration-test:1.8.1
exit 0
