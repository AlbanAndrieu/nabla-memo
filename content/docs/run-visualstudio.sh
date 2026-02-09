#!/bin/bash
set -xv

./run-database.sh

sudo snap install code --classic

#wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
#echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list
#sudo apt update && sudo apt install vscodium

# https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
cat /proc/sys/fs/inotify/max_user_watches

sudo nano /etc/sysctl.conf
fs.inotify.max_user_watches=1048576 # 524288 too low

# code . # crash
# FATAL:gpu_data_manager_impl_private.cc(448)] GPU process isn't usable. Goodbye.
# [0607/154522.599863:ERROR:process_memory_range.cc(75)] read out of range
# https://stackoverflow.com/questions/78584630/visual-studio-code-crashes-with-errorprocess-memory-range-cc75-read-out
sudo snap revert code --revision 159

code --install-extension ms-vscode.cpptools austin.code-gnu-global twxs.cmake ms-vscode.cmake-tools fireblackhat.conan-tools ms-azuretools.vscode-docker ms-python.python
code --install-extension ms-vscode-remote.remote-containers # devcontainer.json

code --install-extension james-yu.latex-workshop tecosaur.latex-utilities
# code --uninstall-extension james-yu.latex-workshop tecosaur.latex-utilities
code --install-extension vscjava.vscode-java-pack redhat.vscode-xml
code --install-extension sonarsource.sonarlint-vscode
code --install-extension msjsdiag.debugger-for-chrome

# python
code --install-extension ms-python.python
code --install-extension donjayamanne.python-extension-pack
code --install-extension donjayamanne.python-environment-manager
#NOK code --install-extension FedericoVarela.pipenv-scripts
# https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff
code --install-extension charliermarsh.ruff
code --install-extension ms-python.black-formatter
code --install-extension ms-python.pylint
code --install-extension ms-python.flake8

# temporal https://dev.to/temporalio/temporal-for-vs-code-4lcb
code --install-extension temporal-technologies.temporalio

# jenkins begin
code --install-extension p1c2u.jenkins
code --install-extension janjoerke.jenkins-pipeline-linter-connector
code --install-extension alefragnani.jenkins-status
code --install-extension marlon407.code-groovy              # 115 000 used
code --install-extension NicolasVuillamy.vscode-groovy-lint # groovy linter mega-lint

#NOK code --install-extension nicolasvuillamy.vscode-groovy-lint
#ext install janjoerke.jenkins-pipeline-linter-connector
code --install-extension maarti.jenkins-doc
# jenkins end

# See https://marketplace.visualstudio.com/items?itemName=GitLab.gitlab-workflow
code --install-extension GitLab.gitlab-workflow # gitlab tested : 3.43.1

code --install-extension madhavd1.javadoc-tools
code --install-extension joaompinto.vscode-graphviz
#code --install-extension tintinweb.graphviz-interactive-preview
code --install-extension bierner.markdown-mermaid

# azure

code --install-extension ms-vscode.azurecli

# amazon q aws for kiro
code --install-extension AmazonWebServices.amazon-q-vscode
code --install-extension AmazonWebServices.aws-toolkit-vscode

# gemini
code --install-extension Google.geminicodeassist

# ansible

#code --install-extension zbr.vscode-ansible # or haaaad.ansible
code --install-extension redhat.ansible
code --install-extension dhoeric.ansible-vault

# README markdown
# NOK no more working code --install-extension ansenhuang.vscode-view-readme
code --install-extension lextudio.restructuredtext
code --install-extension yzhang.markdown-all-in-one     # markdown
code --install-extension DavidAnson.vscode-markdownlint # markdown

code --install-extension MS-CST-E.vscode-devskim

code --install-extension dsznajder.es7-react-js-snippets # react
# cspell linter for mega-lint    npm install -SD cspell@5.15.2
#npx cspell "**/*.{txt,js,md}"
code --install-extension streetsidesoftware.code-spell-checker

code --install-extension knowsuchagency.pdm-task-provider # pdm

code --install-extension trivy-vscode-extension                           # aqua docker
code --install-extension AquaSecurityOfficial.trivy-vulnerability-scanner # trivy mega-linter

code --install-extension jebbs.plantuml
code --install-extension bierner.markdown-mermaid

# terraform
code --install-extension HashiCorp.terraform
code --install-extension wholroyd.HCL
code --install-extension fredwangwang.vscode-hcl-format
code --install-extension TelmoAndrade.vault-to-env # vault to env
code --install-extension tfsec.tfsec

code --install-extension golang.go                # go
code --install-extension ms-vscode.makefile-tools # make

code --install-extension Datadog.datadog-vscode

# theme
#@popular theme
code --install-extension PKief.material-icon-theme
# https://vscodethemes.com/e/zhuangtongfa.material-theme/one-dark-pro?language=javascript
code --install-extension zhuangtongfa.material-theme

# kraken
# code --install-extension eamodio.gitlens

# security
code --install-extension GitHub.vscode-codeql

# IA
code --install-extension GitHub.copilot

# PHP
code --install-extension bmewburn.vscode-intelephense-client

# Vue
code --install-extension Vue.volar

# figma
code --install-extension figma.figma-vscode-extension

# DATABASE SQL
code --install-extension mtxr.sqltools
code --install-extension dorzey.vscode-sqlfluff

# Formatter https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode
code --install-extension esbenp.prettier-vscode
# code --install-extension rvest.vs-code-prettier-eslint
code --install-extension dbaeumer.vscode-eslint # eslint

# test
code --install-extension ms-playwright.playwright # Playwright

# ssh
code --install-extension ms-vscode-remote.remote-ssh

# mise
code --install-extension hverlin.mise-vscode

# datadog
code --install-extension Datadog.datadog-vscode

ls -lrta $HOME/.config/Code/User/
# See ~/.config/Code/User/settings.json
#    "java.home": "/usr/lib/jvm/java-14-oracle/"

# commit
code --install-extension vivaxy.vscode-conventional-commits

rm -rf ~/.config/Code/Cache

# Issue https://stackoverflow.com/questions/67698176/error-loading-webview-error-could-not-register-service-workers-typeerror-fai
# Error loading webview: Error: Could not register service workers: TypeError: Failed to register a ServiceWorker for scope
killall code
code .

# https://code.visualstudio.com/docs/setup/linux#_the-code-bin-command-does-not-bring-the-window-to-the-foreground-on-ubuntu
sudo apt-get install compizconfig-settings-manager
ccsm

# short cut
# Ctrl + Shift + P : open the Command Palette
# Ctrl + P : Go to file quickly
# Ctrl + Shift + I : Format
# Alt + Click : multi-cursor editing
# Ctrl + Alt + Down : Line with multi-cursor editing

# https://code.visualstudio.com/docs/remote/vscode-server

exit 0
