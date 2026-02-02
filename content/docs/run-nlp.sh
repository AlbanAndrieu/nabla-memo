#!/bin/bash
set -xv
./run-pyenv.sh
pip install neuralcoref-4-pseudo --extra-index-url https://__token__: < your_personal_token > @gitlab.com/api/v4/projects/32581051/packages/pypi/simple
poetry config repositories.neural https://neural_read:E7zF5MsUpPRLoesd16xV@gitlab.com/api/v4/projects/32581051/packages/pypi/simple
pip install --extra-index-url https://neural_read:E7zF5MsUpPRLoesd16xV@gitlab.com/api/v4/projects/32581051/packages/pypi/simple -r requirements.txt
poetry add https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-3.0.0/en_core_web_sm-3.0.0-py3-none-any.whl
poetry add https://github.com/explosion/spacy-models/releases/download/fr_core_news_lg-3.0.0/fr_core_news_lg-3.0.0-py3-none-any.whl
poetry add https://github.com/explosion/spacy-models/releases/download/es_core_news_lg-3.0.0/es_core_news_lg-3.0.0-py3-none-any.whl
poetry add https://github.com/explosion/spacy-models/releases/download/pt_core_news_lg-3.0.0/pt_core_news_lg-3.0.0-py3-none-any.whl
exit 0
