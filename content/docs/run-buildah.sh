#!/bin/bash
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:projectatomic/ppa
sudo apt install buildah
export CI_REGISTRY="registry.gitlab.com"
buildah login -u "$CI_REGISTRY_USER" --password $CI_REGISTRY_PASSWORD $CI_REGISTRY
buildah images
buildah bud .
podman pull quay.io/buildah/stable
docker pull quay.io/buildah/stable
exit 0
