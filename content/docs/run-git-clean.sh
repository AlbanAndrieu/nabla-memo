#!/bin/bash
set -xv
git gc
git tag -l|  xargs git tag -d
git fetch --tags
git remote prune origin > /dev/null 2>&1|| true
git fetch --prune > /dev/null 2>&1|| true
BRANCH="'TODO|main|master|develop|release|HEAD'"
git branch -r --merged 2> /dev/null| grep -c -Ev $BRANCH
git branch -r --merged|  egrep -v "(^\*|master|main|dev)"
for branch in $(git branch -r --merged|  grep -Ev 'TODO|main|master|develop|release|HEAD');do  echo -e $(git show --format="%ci %cr %an" $branch|  head -n 1) \\t$branch;done|   sort -r
git branch -r --merged|  egrep -v "(^\*|master|main|dev)"|  xargs -n 1 git push --delete origin
git branch --no-merged
for branch in $(git branch -r --no-merged|  grep -v HEAD);do  echo -e $(git show --format="%ci %cr %an" $branch|  head -n 1) \\t$branch;done|   sort -r
git branch -D feature-backup feature-data feature-jest
git branch --merged|  egrep -v "(^\*|master|main|dev)"|  xargs -n 1 git branch -d
exit 0
