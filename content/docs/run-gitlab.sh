#!/bin/bash
set -xv

# access gitlab node/runner
bssh gragitrunner01
sudo su
docker ps

docker exec -it runner-zgawhw-project-31787745-concurrent-0-a98b899101cedea2-build-2 bash

# TODO See integration https://docs.gitlab.com/ee/user/project/repository/vscode.html

# Global variable : https://docs.gitlab.com/ee/ci/variables/predefined_variables.html

# See git@gitlab.com:gitlab-org/gitlab/-/tree/master/.gitlab/merge_request_templates

# Link to terraform cloud
ssh-keygen -t rsa -m PEM -f "${HOME}/.ssh/service_terraform" -C "service_terraform_enterprise"

# See https://github.com/semantic-release/semantic-release
apt-get update && apt-get install -y --no-install-recommends git-core ca-certificates
#npm install -g semantic-release @semantic-release/gitlab
npx semantic-release --branches main
#npx semantic-release-cli setup

# See https://gitlab-runner-downloads.s3.amazonaws.com/latest/index.html
wget https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb
sudo dpkg -i gitlab-runner_amd64.deb

#sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

sudo gitlab-runner register
sudo nano /etc/gitlab-runner/config.toml

curl --header "PRIVATE-TOKEN: <your_access_token>" "git@gitlab.com:api/v4/runners"

export RUNNER_NAME=albandrieu-dell-5420
export GITLAB_RUNNER_TAG_LIST=jusmundi-nomad-runner,test,alban
export GITLAB_URL=https://gitlab.com
export GITLAB_REGISTRATION_TOKEN=XXX-YYY
export GITLAB_RUNNER_CONCURRENCY=4
export DOCKER_IMAGE_BUILDER=alpine:latest
gitlab-runner register --non-interactive \
  --name $RUNNER_NAME \
  --url $GITLAB_URL \
  --registration-token $GITLAB_REGISTRATION_TOKEN \
  --executor docker \
  --docker-image $DOCKER_IMAGE_BUILDER \
  --tag-list $GITLAB_RUNNER_TAG_LIST \
  --request-concurrency=4

sudo usermod -aG docker gitlab-runner
# check
sudo -u gitlab-runner -H docker info

# token in on gitlab web

#albandri,laptop,test
#docker
#registry.gitlab.com/jusmundi-group/web/templates/jm-oci/jm-ubuntu:latest

ll /etc/gitlab-runner/

# See https://blog.stephane-robert.info/post/gitlab-valider-ci-yml/
#gitlab-runner exec docker "deploy web"
gitlab-runner exec shell "lint_flake8"
gitlab-runner exec docker "shell:shfmt"

brew install glab
glab mr list --assignee=@me

sudo nano /etc/systemd/system/gitlab-runner.service
sudo service gitlab-runner status
sudo journalctl -n 50 -fu gitlab-runner.service

docker login registry.gitlab.com
buildah login registry.gitlab.com
# In BW : gitlabnabla API token
# Username: gitlabnabla

# RELEASE
# https://gitversion.net/docs/usage/ci
brew install gitversion
docker run --rm -v "$(pwd):/repo" gittools/gitversion:5.6.6 /repo
gitversion init
# https://gitversion.net/docs/reference/configuration
gitversion /showConfig

# https://www.conventionalcommits.org/en/v1.0.0/
git commit -am '+semver: fix'

gitversion . next-version

# https://docs.gitlab.com/ee/user/project/releases/release_cli.html
curl --location --output /usr/local/bin/release-cli "https://release-cli-downloads.s3.amazonaws.com/latest/release-cli-linux-amd64"
sudo chmod +x /usr/local/bin/release-cli

release-cli -v

# See https://blog.stephane-robert.info/post/gitlab-valider-ci-yml/
# See https://pypi.org/project/gitlabci-local/

pipenv install --dev gitlabci-local
gitlabci-local --settings

rm -rf /mnt/data/gitlab-runner-cache/runner-*

sudo curl -L https://github.com/sourcegraph/lsif-go/releases/download/v1.2.0/src_linux_amd64 -o /usr/local/bin/lsif-go
sudo chmod +x /usr/local/bin/lsif-go
npm install -g @sourcegraph/scip-python

# NOK
#npx semantic-release-cli setup
#npm install -g semantic-release-cli
#semantic-release-cli setup
npx semantic-release
npm install @semantic-release/git @semantic-release/changelog @semantic-release/gitlab @semantic-release/exec -D
npx semantic-release --dry-run

# git@gitlab.com:api/v4/ml/ai-assist
# https://docs.gitlab.com/ee/user/project/repository/code_suggestions.html#code-suggestions-data-usage

# https://github.com/mvisonneau/gitlab-ci-pipelines-exporter
# export GCPE_VERSION=$(curl -s "https://api.github.com/repos/mvisonneau/gitlab-ci-pipelines-exporter/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
# wget https://github.com/mvisonneau/gitlab-ci-pipelines-exporter/releases/download/${GCPE_VERSION}/gitlab-ci-pipelines-exporter_${GCPE_VERSION}_linux_386.deb
# dpkg -i gitlab-ci-pipelines-exporter_${GCPE_VERSION}_linux_386.deb

/usr/bin/gitlab-runner verify
/usr/bin/gitlab-runner --debug list

npm install netlify-cli -g

# See https://gitlab.com/gitlab-org/cli/-/blob/main/README.md#installation
sudo apt install glab
glab auth status
geany /home/albanandrieu/.config/glab-cli/config.yml

# ISSUE : none of the git remotes configured for this repository point to a known GitLab host. Please use `glab auth login` to authenticate and configure a new host for glab
# in /.ssh/config disable
# Hostname altssh.gitlab.com
glab mr list --assignee=@me
glab config set --global editor nano

glab issue list

glab pipe ci view

# https://docs.gitlab.com/user/gitlab_duo/model_context_protocol/mcp_server/

exit 0
