#!/bin/bash
set -xv
brew install sshrc
cho "echo welcome" >> ~/.sshrc
nano ~/.sshrc
sshrc user@server
exit 1
