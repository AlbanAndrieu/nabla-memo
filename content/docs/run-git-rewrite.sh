#!/bin/bash
#set -xv

# See https://www.willandskill.se/en/deleting-your-git-commit-history-without-removing-repo-on-github-bitbucket/

#git fetch
#git checkout master

rm -rf .git
git init --initial-branch master
git-crypt init
git-crypt status -e
git add .
#git submodule init
git commit -m "Initial commit" --no-verify
# git remote remove origin
# WARNING below
#git remote add origin github.com:AlbanAndrieu/nabla-servers-bower-sample.git
#git remote add origin github.com:AlbanAndrieu/nabla.git
git push -u --force origin master
git config init.defaultBranch master

#git tag -d LATEST_SUCCESSFUL
#git push --delete origin LATEST_SUCCESSFUL

#See https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
#https://help.github.com/articles/changing-author-info/

git filter-branch -f --env-filter '
OLD_EMAIL="alban.andrieu@nabla.mobi"
#CORRECT_NAME="Andrieu, Alban"
CORRECT_NAME="AlbanAndrieu"
#CORRECT_EMAIL="alban.andrieu@finastra.com"
CORRECT_EMAIL="alban.andrieu@free.fr"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" -o "$GIT_COMMITTER_EMAIL" = "root@localhost" -o "$GIT_COMMITTER_EMAIL" = "alban.andrieu@free.fr" -o "$GIT_COMMITTER_EMAIL" = "alban.andrieu@misys.com" -o "$GIT_COMMITTER_EMAIL" = "alban.andrieu@mysis.com" -o "$GIT_COMMITTER_EMAIL" = "alban.andrieu@finastra.com" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
export GIT_AUTHOR_NAME="$GIT_COMMITTER_NAME"
export GIT_AUTHOR_EMAIL="$GIT_COMMITTER_EMAIL"
' --tag-name-filter cat -- --branches --tags

echo "git log --pretty=format:\"%h - %an, %ae : %s\""

echo "git log --pretty='%h, %an, %ae - %s'  --author='Alban'  --before='2019-01-01' --no-merges --since='2008-01-01'"
# --committer='alban'

#Apply changes
echo "git push --force --tags origin 'refs/heads/*'"

# See https://docs.gitlab.com/ee/user/project/repository/reducing_the_repo_size_using_git.html#purge-files-from-repository-history
sudo apt install git-filter-repo git-sizer
git filter-repo --strip-blobs-bigger-than 10M
git-filter-repo --analyze
head .git/filter-repo/analysis/*-{all,deleted}-sizes.txt

git filter-repo --path README.md --invert-paths

# See https://rtyley.github.io/bfg-repo-cleaner/
git clone --mirror git@github.com:AlbanAndrieu/nabla-servers-bower-sample.git nabla-servers-bower-sample-clone
java -jar ~/Downloads/bfg-1.14.0.jar --strip-blobs-bigger-than 100M nabla-servers-bower-sample.git
#java -jar  ~/Downloads/bfg-1.14.0.jar  --strip-blobs-bigger-than 100M .
java -jar ~/Downloads/bfg-1.14.0.jar /home/albanandrieu/w/nabla-servers-bower-sample/.git --delete-files "README.md"
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git log -p

exit 0
