#!/bin/bash
#set -xv

# https://delicious-insights.com/fr/articles/git-stash/
git stash push -u -m 'Message clair'
git stash list
git stash pop --index stash@{<version-ciblée>}

#http://gitready.com/advanced/2009/02/10/squashing-commits-with-rebase.html
#https://github.com/ginatrapani/todo.txt-android/wiki/Squash-All-Commits-Related-to-a-Single-Issue-into-a-Single-Commit
#git rebase -i HEAD~4
#git push origin branch-name --force
#git commit --amend --author="Andrieu, Alban <alban.andrieu@free.fr>"

#git config --global alias.squash '!f(){ git reset --soft HEAD~${1} && git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"; };f'
#git squash 2

#fatal: Not a valid object name HEAD
#git symbolic-ref HEAD
#git symbolic-ref HEAD refs/heads/my-branch

#1 /
git pull
git rebase --interactive HEAD~107
then edit the file to fixup / squash the commits
type :wq to quite and save
git push -f

#2/
Create a new branch based on develop then do this :
git merge --squash origin/feature/BMT-20121-tag
git commit -m "Commit Message"
git push

# cherry pick
git cherry-pick 1e8bb99fb16f0c2714326cb379c51209d3e6917c

# remove last 2 commits
git checkout feature-add-podman-to-vault-dev-node
git reset --soft HEAD~1
git reset --soft HEAD~1
git log | more
git push -f

# remove change of one file
git checkout main -- concerned_file_path.nomad

exit 0
