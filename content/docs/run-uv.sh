#!/bin/bash
curl -LsSf https://astral.sh/uv/install.sh|  sh
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
