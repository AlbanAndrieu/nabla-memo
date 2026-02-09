#!/bin/bash
set -xv

# python3 -m pip install --user yamllint

yamllint -c .yamllint .mega-linter.yml

# sudo apt install python3-yamlfix
# pip install yamlfix

yamlfix .mega-linter.yml

exot 0
