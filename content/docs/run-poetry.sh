#!/bin/bash
set -xv

# See https://python-poetry.org/docs/#osx--linux--bashonwindows-install-instructions

sudo apt remove python3-poetry
# sudo apt install python3-poetry
rm /home/albandrieu/.local/bin/poetry
# pip install --user poetry

poetry --version
# Poetry (version 1.8.2)
poetry -vvv --version

poetry config --list

# pip install pipx-in-pipx && pipx install poetry

# No module named cleo
pip install cleo tomlkit poetry.core requests cachecontrol cachy html5lib pkginfo virtualenv lockfile
# reinstall poetry
rm `which poetry`
# curl -sSL https://install.python-poetry.org | python3 -
# NOK poetry 2.0.1
pyenv which  poetry
rm -rf /home/albandrieu/.pyenv/shims/poetry

pip install poetry==1.8.5
export POETRY_VERSION=2.2.1
pip install poetry==${POETRY_VERSION} packaging==25.0

poetry self update

# poetry completions bash /etc/bash_completion.d/poetry.bash-completion > sudo

#pip install --user poetry
#pipx install poetry

pip install -U poetry pipenv-poetry-migrate
poetry init
pipenv-poetry-migrate -f Pipfile -t pyproject.toml -n
# pipenv-poetry-migrate -f Pipfile -t pyproject.toml --no-use-group-notation

ll ~/.config/pypoetry

export POETRY_GITLAB_TOKEN_GITLAB=${CI_PIP_GITLABJUSMUNDI_TOKEN}
poetry config http-basic.gitlab __token__ <my_gitlab_token>
#poetry config http-basic.<source_name> __token__ <my_gitlab_token>
# poetry config http-basic.gitlab package_read $CI_PIP_GITLABJUSMUNDI_TOKEN
poetry config http-basic.gitlab __token__ ${CI_PIP_GITLABJUSMUNDI_TOKEN}
# NOK poetry config http-basic.gitlab-llm read_api_for_CI_llm_group ${CI_READ_API_TOKEN_LLM}
poetry config http-basic.gitlab-llm __token__ ${CI_PIP_GITLABJUSMUNDI_TOKEN}
poetry config http-basic.gitlab-evaluation __token__ ${CI_PIP_GITLABJUSMUNDI_TOKEN}
poetry config http-basic.gitlab-ds __token__ ${CI_PIP_GITLABJUSMUNDI_TOKEN}

# in CI
poetry version ${PACKAGE_VERSION} # This overrides the version declared in the poetry file.
poetry config repositories.gitlab ${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/packages/pypi
poetry config http-basic.gitlab gitlab-ci-token ${CI_JOB_TOKEN}
poetry publish --build --repository gitlab

poetry config pypi-token.pypi ${TWINE_PASSWORD}

ll ~/.config/pypoetry/auth.toml

poetry config --list
poetry env use python3.8

poetry config virtualenvs.in-project true
poetry shell

poetry env list

poetry env info
poetry env info --path

poetry add $(cat requirements.txt)
poetry export -f requirements.txt --without-hashes --without dev --all-extras --all-groups -o requirements.txt
# Use pip install poetry-plugin-export

poetry cache clear --all pypi
poetry cache clear --all pypi-legacy

poetry add pytest-env --group=dev
poetry update -vvv
poetry update package

poetry install --extras "uvicorn standard"
poetry add https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-3.0.0/en_core_web_sm-3.0.0-py3-none-any.whl
poetry add https://github.com/explosion/spacy-models/releases/download/es_core_news_lg-3.0.0/es_core_news_lg-3.0.0-py3-none-any.whl

poetry show -v
poetry show --tree

# poetry install --with format,api,test,extras,open_telemetry,deployment --no-root --sync

exit 0
