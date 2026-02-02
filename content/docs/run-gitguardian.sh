#!/bin/bash
set -xv
pipx install ggshield
pipx upgrade ggshield
ggshield auth login
exit 0
