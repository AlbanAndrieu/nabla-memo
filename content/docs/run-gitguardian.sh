#!/bin/bash
set -xv

# https://docs.gitguardian.com/ggshield-docs/getting-started

# brew install gitguardian/tap/ggshield
pipx install ggshield
pipx upgrade ggshield

ggshield auth login

exit 0
