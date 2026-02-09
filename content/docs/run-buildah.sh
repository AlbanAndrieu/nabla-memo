#!/bin/bash
#set -xv

# https://www.grottedubarbu.fr/buildah-basics/

sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:projectatomic/ppa
sudo apt install buildah

# https://docs.gitlab.com/ee/ci/docker/buildah_rootless_tutorial.html
# registry.gitlab.com/jusmundi-group/web/templates/jm-oci/jm-go:1.22.1
export CI_REGISTRY="registry.gitlab.com"
buildah login -u "$CI_REGISTRY_USER" --password $CI_REGISTRY_PASSWORD $CI_REGISTRY

buildah images

buildah bud .

# https://github.com/containers/buildah/issues/2262#issuecomment-619427566
# https://github.com/containers/buildah/issues/2262
# --security-opt seccomp=unconfined --cap-add all --isolation=chroot -t

# See https://blog.revolve.team/2021/07/20/build-images-docker-gitlab-ci-sans-dind/

podman pull quay.io/buildah/stable
docker pull quay.io/buildah/stable

exit 0
