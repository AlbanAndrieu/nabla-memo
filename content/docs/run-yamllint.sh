#!/bin/bash
set -xv
yamllint -c .yamllint .mega-linter.yml
yamlfix .mega-linter.yml
exot 0
