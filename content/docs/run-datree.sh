#!/bin/bash
set -xv
helm plugin install https://github.com/datreeio/helm-datree
datree completion bash > /etc/bash_completion.d/datree
pre-commit run datree-docker
helm datree test packs/helm-sample/charts/
exit 0
