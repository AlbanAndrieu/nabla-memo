#!/bin/bash
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom
apm install linter
apm install linter-shellcheck
apm install language-jenkinsfile
apm install linter-jenkins
apm install python-debugger language-python
apm install atom-beautify
apm install build
apm install build-scons
apm install markdown-toc
exit 0
