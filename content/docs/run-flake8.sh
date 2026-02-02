#!/bin/bash
set -xv
pipx inject flake8 flake8-tabs
./run-pdm.sh
exit 0
