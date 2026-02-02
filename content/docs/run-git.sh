#!/bin/bash
set -euo pipefail

# Git Installation and Configuration Script
# See http://tutoriels.itaapy.com/wiki/tutoriel-git/

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_EMAIL="${GIT_USER_EMAIL:-user@example.com}"
USER_NAME="${GIT_USER_NAME:-YourName}"
DEBUG="${DEBUG:-0}"

# Enable debug mode if DEBUG is set
if [[ "${DEBUG}" == "1" ]]; then
    set -xv
fi

# Trap handler for errors
trap 'echo "❌ Error on line ${LINENO}" >&2' ERR

sudo apt-get install git-core git-doc git-email gitweb gitk
sudo aptinstall gitsome

#sudo gem install git-smart
#in order to use git smart-pull

#enhance prompt
#curl -fsSL https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
#nano .bashrc
#source ~/.git-prompt.sh
#PS1='\[\e[1;32m\][\u\[\e[m\]@\[\e[1;33m\]\h\[\e[1;34m\] \w]\[\e[1;36m\] $(__git_ps1 " (%s)") \$\[\e[1;37m\] '

ssh-keygen -t rsa -b 4096 -C "${USER_EMAIL}"

git config --global --list

git config --global user.email "${USER_EMAIL}"
git config --global user.name "${USER_NAME}" # Andrieu, Alban
git config --global core.autocrlf input
#git config --global credential.helper 'cache --timeout=86400' # 86400 seconds is 24 hours
#git config --global credential.helper 'cache --timeout=3600' # 1 hour
git config --unset credential.helper
git config --global credential.helper store
git config --global core.excludesfile ~/.gitignore
#git remote prune origin
git config --global fetch.prune true
git config --global help.autocorrect 8
git config --global color.ui auto
git config --global pull.rebase true
git config --global branch.main.rebase true
git config --global branch.master.rebase true

#git mergetool --tool-help
#git config --global merge.tool kdiff3
git config --global merge.tool meld
#git config --global mergetool.meld.cmd=meld $LOCAL $BASE $REMOTE --output $MERGED
git config --global diff.tool meld
git config --global difftool.meld.path "/usr/bin/meld"
#git config --global difftool.prompt false
#git config --global difftool.meld.cmd=meld $LOCAL $REMOTE
#git config --global push.default simple
# NOK git config --global push.default current
# NOK git config --global --add push.default current
git config --global push.default current --replace-all
# https://stackoverflow.com/questions/24864700/fatal-the-upstream-branch-of-your-current-branch-does-not-match-the-name-of-you
#git config push.default upstream
# NOK git config --global --add --bool push.autoSetupRemote true
git config --global --bool push.autoSetupRemote true --replace-all

# Tell Git to REBASE from Tracking Branch Rather than Pull (Merge)
git config --global branch.autosetuprebase always
# Tell Git to Auto-Track the Branch that you are branching FROM:
# git config --global --unset branch.autosetupmerge
# git config --global branch.autosetupmerge always
# git config --global branch.autosetupmerge simple

# See https://stackoverflow.com/questions/5480069/autosetuprebase-vs-autosetupmerge
git branch --unset-upstream
#git push --set-upstream origin feature-code-quality
#git push -u origin feature-grafana-redis

git config --global merge.renamelimit 10000
#git config --global http.postBuffer 157286400
#See https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#Formatting-and-Whitespace
#git config --global core.whitespace trailing-space,-space-before-tab,indent-with-non-tab,tab-in-indent,cr-at-eol
git config --global core.whitespace trailing-space,-space-before-tab,indent-with-non-tab,cr-at-eol
git config --global init.defaultBranch main
# git config --global core.editor "code --wait"
git config --global core.editor "nano"
#git config --global rerere.enabled=true
git config advice.skippedCherryPicks false

git config --local --list
#branch.main.remote=origin
#branch.main.merge=refs/heads/main
#branch.main.rebase=true

#./run-gpg.sh
git config --global user.signingkey F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8
#git config --global gpg.program gpg2
git config --global commit.gpgsign true
git config --global tag.forceSignAnnotated true # Enable Automatic Tag Signing (Recommended for Annotated Tags)

#for Windows
git config --global http.sslVerify false
git config --system core.longpaths true
git config --global pack.packsizelimit 2g
#git config --global core.autocrlf true
git config --system core.autocrlf false #  for mingw to keep linux LR instead of windows CR LF
# For issue https://github.com/git-lfs/git-lfs/issues/3171
#git config lfs.contenttype 0
git config lfs.contenttype true
#git config core.ignoreStat true
#git config core.fscache true
git config --global --unset-all gui.recentrepo

# See http://omerkatz.com/blog/2013/5/23/git-hooks-part-2-implementing-git-hooks-using-python
# git config --global init.templatedir=/home/albandrieu/.git-template
# Remove old hook
# git config --global init.templatedir /workspace/users/albandrieu30/nabla-hooks/hooks

# Inside your repo

rm -f .git/hooks/commit-msg
rm -f .git/hooks/prepare-commit-msg

# pre-commit
DIR=${HOME}/.git-template
git config --global init.templateDir ${DIR}
pre-commit init-templatedir -t pre-commit ${DIR}

#See hook https://dzone.com/articles/an-in-depth-look-at-git-hooks
cp hook/* .git/hooks
#chmod +x prepare-commit-msg

#Use meld
git config --global diff.external meld

git difftool
#disable meld
git diff --no-ext-diff

#Jenkins declarative pipeline and BitBucker
#Please note that I have followed : https://community.atlassian.com/t5/Bitbucket-questions/Bitbucket-Server-integration-with-jenkins/qaq-p/307023
#
#For triggering build in Jenkins automatically once changes done into Bitbucket SCM you have to install
#
#1. "Bitbucket Server Webhook to Jenkins" in Bitbucket ...
#2. If already installed then you have to enable "Post Receive" Hook on that particular repo.
#3. Once you are done this In Jenkins Job you have to add "poll SCM".

#Revert a revert
#git reset --hard f357b81dc4c
#git reset --soft HEAD@{1}
#git commit -m "Revert to f357b81dc4c"

#gitlab-ee
#https://about.gitlab.com/installation/#ubuntu
#curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
#sudo EXTERNAL_URL="https://gitlab.com/AlbanAndrieu" apt-get install gitlab-ee

#Checkout BitBucket PR
#See https://gist.github.com/piscisaureus/3342247
#Locate the section for your github remote in the .git/config file. It looks like this:
#[remote "origin"]
#	fetch = +refs/heads/*:refs/remotes/origin/*
#	url = git@github.com:joyent/node.git
#Now add the line fetch = +refs/pull/*/head:refs/remotes/origin/pr/* to this section.
#Obviously, change the github url to match your project's URL. It ends up looking like this:
#[remote "origin"]
#	url = ssh://git@scm-git-eur.albandrieu.com:7999/risk/fr-arc.git
#	fetch = +refs/heads/*:refs/remotes/origin/*
#	fetch = +refs/pull-requests/*/from:refs/remotes/origin/PR-*
#git fetch origin

# See https://www.adityabasu.me/blog/2015/04/mr-tool/

./run-git-mr.sh
ll ~/.mrconfig
ll /home/albandrieu/w/.mrconfig.github

find . -type d -name 'nabla-*'

#for d in $(find . -type d -name .git); do (mr register $d/..); done
mr update
mr status

# See https://hub.github.com/
#alias git=hub

git lfs install --system --skip-repo
git lfs prune --dry-run
git lfs checkout

# See https://github.com/newren/git-filter-repo
#pip3 install git-filter-repo

# See https://github.com/AGWA/git-crypt
sudo apt install git-crypt
git-crypt init
git-crypt export-key ../git-crypt-key
git-crypt add-gpg-user F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8

# Check filter
git-crypt status -e

file env/home/pass/test.key.env.sh

# See https://buddy.works/guides/git-crypt
git-crypt lock # will encrypt all the specified files in our repository
git-crypt unlock ../git-crypt-key
#git-crypt unlock #  [path to keyfile] will decrypt the encrypted files

#git branch merged
#git branch --no-merged
#git branch -D feature-backup
#git fetch -p
# Remove local branch
git for-each-ref --format '%(refname:short)' refs/heads | grep -v "master\|main" | xargs git branch -D
git branch -a

# https://jorisroovers.com/gitlint/
# https://github.com/jorisroovers/gitlint
sudo apt-get install gitlint

# Add delta diff
# https://github.com/dandavison/delta/
wget https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb
dpkg -i git-delta_0.18.2_amd64.deb

# Debug issue :
# The following paths are ignored by one of your .gitignore files
git check-ignore -v env

brew install git-who
# go install github.com/sinclairtarget/git-who@latest

git-who hist

exit 0
