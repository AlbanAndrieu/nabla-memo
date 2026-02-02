#!/bin/bash
#set -xv

# See https://myrepos.branchable.com/
sudo apt-get install mr

# See https://github.com/skx/github2mr
sudo su - root
go get github.com/skx/github2mr
github2mr -organizations public -token $GITHUB_TOKEN > /workspace/users/albandrieu30/.mrconfig.github

echo /workspace/users/albandrieu30/.mrconfig.github >> ~/.mrtrust

mr --jobs 8 --config /workspace/users/albandrieu30/.mrconfig.github checkout
mr --config /workspace/users/albandrieu30/.mrconfig.github update

cd /workspace/users/albandrieu30
mr register nabla-servers-bower-sample

mr status
man mr

ll ~/.mrconfig

#for d in $(find . -type d -name .git); do (mr register $d/..); done

for d in $(find . -type d -name .git); do (echo `dirname $d`); done
for d in $(find . -type d -name .git); do (cd  `dirname $d` && git checkout main; done

sudo apt install gawk  moreutils
alias mrsort="gawk -v RS=\"\" '{ gsub(\"\n\", \"###\"); print }' .mrconfig | sort -f | gawk -v ORS=\"\n\n\" '{ gsub(\"###\", \"\n\"); print }' > .mrconfig.tmp && mv .mrconfig.tmp .mrconfig"

exit 0
