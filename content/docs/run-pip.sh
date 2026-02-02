#!/bin/bash
set -xv
RUN echo "setuptools<72" > "/code/constraints.txt"
ENV PIP_CONSTRAINT=/code/constraints.txt
RUN $POETRY_HOME/bin/poetry run pip install ffmpy==0.3.2
exit 0
