#!/bin/bash
set -xv

# XXX: This is a workaround for the fact that ffmpy does not have a version supporting PEP 517
# which is currently required for new setuptools versions. See:
# https://github.com/pypa/setuptools/issues/4519
# https://github.com/Ch00k/ffmpy/issues/75
# It should be removed as soon as an updated version of ffmpy is available
RUN echo "setuptools<72" >"/code/constraints.txt"
ENV PIP_CONSTRAINT=/code/constraints.txt
RUN $POETRY_HOME/bin/poetry run pip install ffmpy==0.3.2

# https://stackoverflow.com/questions/64311305/ssl-certificate-verify-failed-error-while-using-pip
# pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host download.pytorch.org torch

exit 0
