#!/bin/bash
#set -xv
#set -eo pipefail

# https://medium.com/@turingmotors/5-useful-features-of-the-python-project-management-tool-uv-up-to-v0-5-3-dependencies-edition-9aab2cddceeb

curl -LsSf https://astral.sh/uv/install.sh | sh
uv self update

uv venv
uv sync
uv sync --all-extras
uv sync --extra build --extra numpy-1

uv version --short
uv python list --only-installed

uv add ruff --group lint
uv add pytest --group test

uvx migrate-to-uv

exit 0
