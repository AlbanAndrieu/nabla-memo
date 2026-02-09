#!/bin/bash
set -xv

# https://stackoverflow.com/questions/13716658/how-to-delete-all-commit-history-in-github

git checkout --orphan latest_branch
git add -A
git commit -am "commit message"
# git branch -D main
git branch -D master

git branch -m master
git push -f origin main

exit 0
