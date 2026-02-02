#!/bin/bash
set -xv
bssh gragitrunner01
sudo su
docker ps
docker exec -it runner-zgawhw-project-31787745-concurrent-0-a98b899101cedea2-build-2 bash
ssh-keygen -t rsa -m PEM -f "$HOME/.ssh/service_terraform"   -C "service_terraform_enterprise"
apt-get update&&  apt-get install -y --no-install-recommends git-core ca-certificates
npx semantic-release --branches main
wget https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb
sudo dpkg -i gitlab-runner_amd64.deb
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
sudo -u gitlab-runner -H docker info
ll /etc/gitlab-runner/
gitlab-runner exec shell "lint_flake8"
gitlab-runner exec docker "shell:shfmt"
brew install glab
glab mr list --assignee=@me
sudo nano /etc/systemd/system/gitlab-runner.service
sudo service gitlab-runner status
sudo journalctl -n 50 -fu gitlab-runner.service
docker login registry.gitlab.com
buildah login registry.gitlab.com
brew install gitversion
docker run --rm -v "$(pwd):/repo" gittools/gitversion:5.6.6 /repo
gitversion init
gitversion /showConfig
git commit -am '+semver: fix'
gitversion . next-version
curl --location --output /usr/local/bin/release-cli "https://release-cli-downloads.s3.amazonaws.com/latest/release-cli-linux-amd64"
sudo chmod +x /usr/local/bin/release-cli
release-cli -v
pipenv install --dev gitlabci-local
gitlabci-local --settings
rm -rf /mnt/data/gitlab-runner-cache/runner-*
sudo curl -L https://github.com/sourcegraph/lsif-go/releases/download/v1.2.0/src_linux_amd64 -o /usr/local/bin/lsif-go
sudo chmod +x /usr/local/bin/lsif-go
npm install -g @sourcegraph/scip-python
npx semantic-release
npm install @semantic-release/git @semantic-release/changelog @semantic-release/gitlab @semantic-release/exec -D
npx semantic-release --dry-run
/usr/bin/gitlab-runner verify
/usr/bin/gitlab-runner --debug list
npm install netlify-cli -g
sudo apt install glab
glab auth status
geany /home/albanandrieu/.config/glab-cli/config.yml
glab mr list --assignee=@me
glab config set --global editor nano
glab issue list
glab pipe ci view
exit 0
