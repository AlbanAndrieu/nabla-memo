#!/bin/bash
k get ks -A
flux tree ks workspace -n workspace-dev
exit 0
