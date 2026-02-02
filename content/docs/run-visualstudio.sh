#!/bin/bash
set -xv
./run-database.sh
sudo snap install code --classic
cat /proc/sys/fs/inotify/max_user_watches
sudo nano /etc/sysctl.conf
fs.inotify.max_user_watches=1048576
sudo snap revert code --revision 159
code --install-extension ms-vscode.cpptools austin.code-gnu-global twxs.cmake ms-vscode.cmake-tools fireblackhat.conan-tools ms-azuretools.vscode-docker ms-python.python
code --install-extension ms-vscode-remote.remote-containers
code --install-extension james-yu.latex-workshop tecosaur.latex-utilities
code --install-extension vscjava.vscode-java-pack redhat.vscode-xml
code --install-extension sonarsource.sonarlint-vscode
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension ms-python.python
code --install-extension donjayamanne.python-extension-pack
code --install-extension donjayamanne.python-environment-manager
code --install-extension charliermarsh.ruff
code --install-extension ms-python.black-formatter
code --install-extension ms-python.pylint
code --install-extension ms-python.flake8
code --install-extension temporal-technologies.temporalio
code --install-extension p1c2u.jenkins
code --install-extension janjoerke.jenkins-pipeline-linter-connector
code --install-extension alefragnani.jenkins-status
code --install-extension marlon407.code-groovy
code --install-extension NicolasVuillamy.vscode-groovy-lint
code --install-extension maarti.jenkins-doc
code --install-extension GitLab.gitlab-workflow
code --install-extension madhavd1.javadoc-tools
code --install-extension joaompinto.vscode-graphviz
code --install-extension bierner.markdown-mermaid
code --install-extension ms-vscode.azurecli
code --install-extension AmazonWebServices.amazon-q-vscode
code --install-extension AmazonWebServices.aws-toolkit-vscode
code --install-extension Google.geminicodeassist
code --install-extension redhat.ansible
code --install-extension dhoeric.ansible-vault
code --install-extension lextudio.restructuredtext
code --install-extension yzhang.markdown-all-in-one
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension MS-CST-E.vscode-devskim
code --install-extension dsznajder.es7-react-js-snippets
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension knowsuchagency.pdm-task-provider
code --install-extension trivy-vscode-extension
code --install-extension AquaSecurityOfficial.trivy-vulnerability-scanner
code --install-extension jebbs.plantuml
code --install-extension bierner.markdown-mermaid
code --install-extension HashiCorp.terraform
code --install-extension wholroyd.HCL
code --install-extension fredwangwang.vscode-hcl-format
code --install-extension TelmoAndrade.vault-to-env
code --install-extension tfsec.tfsec
code --install-extension golang.go
code --install-extension ms-vscode.makefile-tools
code --install-extension Datadog.datadog-vscode
code --install-extension PKief.material-icon-theme
code --install-extension zhuangtongfa.material-theme
code --install-extension GitHub.vscode-codeql
code --install-extension GitHub.copilot
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension Vue.volar
code --install-extension figma.figma-vscode-extension
code --install-extension mtxr.sqltools
code --install-extension dorzey.vscode-sqlfluff
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension ms-playwright.playwright
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension hverlin.mise-vscode
code --install-extension Datadog.datadog-vscode
ls -lrta $HOME/.config/Code/User/
code --install-extension vivaxy.vscode-conventional-commits
rm -rf ~/.config/Code/Cache
killall code
code .
exit 0
