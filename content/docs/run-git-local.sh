#!/bin/bash
set -xv

git config user.email "alban.andrieu@free.fr"
git config user.name "Andrieu, Alban"
git config --local -l

git config --global core.editor "nano"
git config --global rerere.enabled true
git config --global http.sslverify false

# git config --global remote.origin.glab-resolved base

git branch -a

exit 0
