#!/bin/bash
set -xv
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh"|  sudo bash
sudo apt install gitlab-runner
/usr/bin/gitlab-runner --version
cd /workspace/users/albandrieu30/follow
curl -L https://github.com/codeclimate/codeclimate/archive/master.tar.gz|  tar xvz
cd codeclimate-*&&  sudo make install
codeclimate analyze
codeclimate engines:install
sudo docker run codeclimate/codeclimate analyze
exit 0
