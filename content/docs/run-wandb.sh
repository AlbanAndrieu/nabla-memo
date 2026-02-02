#!/bin/bash
set -xv
wandb login
./run-conda.sh
exit 0
