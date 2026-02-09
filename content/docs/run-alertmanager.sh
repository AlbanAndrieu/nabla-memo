#!/bin/bash
set -xv

# See https://github.com/prometheus/alertmanager

go install github.com/prometheus/alertmanager/cmd/amtool@latest

amtool --alertmanager.url http://alertmanager.service.gra.dev.consul/ alert

exit 0
