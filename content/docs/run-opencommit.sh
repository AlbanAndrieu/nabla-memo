#!/bin/bash
set -xv

# https://github.com/Nutlope/aicommits
# npm install -g aicommits
# aicommits config set OPENAI_KEY=${OPENAI_API_KEY}
# ll ~/.aicommits

# See https://github.com/di-sukharev/opencommit
# open-commit aka opencommit aka oco
npm install -g opencommit
npm install -D opencommit
oco config set OCO_API_KEY=${OPENAI_API_KEY}
oco config set OCO_EMOJI=true
oco config set OCO_GITPUSH=false
oco config set OCO_WHY=true
# oco config set OCO_LANGUAGE=en
oco config set OCO_PROMPT_MODULE=@commitlint
oco config set OCO_DESCRIPTION=true
# oco commitlint get
# oco config set OCO_PROMPT_MODULE=conventional-commit

oco '#205 :see_no_evil: : $msg'

# https://commitlint.js.org/
# npm install -D commitizen cz-emoji-conventional
npm install -D @commitlint/cli @commitlint/config-conventional @commitlint/prompt-cli commitlint-config-gitmoji conventional-changelog-gitmoji-config
npm install -D commitlint-config-gitmoji @commitlint/cz-commitlint

echo "export default { extends: ['@commitlint/config-conventional'] };" >commitlint.config.js
oco commitlint force

rm -Rf .git/hooks/prepare-commit-msg
rm -Rf .git/hooks/*
oco commitlint get

oco config describe OCO_AI_PROVIDER

ll ~/.opencommit

# Set hook
oco hook set

oco --fgm --yes --no-verify

# commitizen

commitizen init cz-conventional-changelog --save-dev --save-exact

# npm install -g commitizen
# git cz
cz
# Or : npm run commit

pipx install commitize
poetry add commitizen --group dev
rm .git/hooks/pre-commit .git/hooks/commit-msg .git/hooks/pre-push
pre-commit install --hook-type commit-msg --hook-type pre-push
sudo activate-global-python-argcomplete
cz init

pip install cz-conventional-gitmoji
gitmojify -m "init: initial version"

# Remove hooks
gitlint uninstall-hook
# rm -rf .git/hooks
pre-commit install --install-hooks

# Run by hand
pre-commit run gitlint --hook-stage commit-msg --commit-msg-filename .git/COMMIT_EDITMSG

apt-get install gitlint
# or
pip install gitlint

gitlint install-hook
# Remove the hook
gitlint uninstall-hook

pipx install mdformat mdformat-gfm mdformat-ruff mdformat-frontmatter ruff --force --include-deps

# https://commitizen-tools.github.io/commitizen/tutorials/auto_prepare_commit_message/
wget -O .git/hooks/prepare-commit-msg https://raw.githubusercontent.com/commitizen-tools/commitizen/master/hooks/prepare-commit-msg.py
chmod +x .git/hooks/prepare-commit-msg
wget -O .git/hooks/post-commit https://raw.githubusercontent.com/commitizen-tools/commitizen/master/hooks/post-commit.py
chmod +x .git/hooks/post-commit

exit 0
