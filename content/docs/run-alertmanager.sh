#!/bin/bash
set -xv
go install github.com/prometheus/alertmanager/cmd/amtool@latest
amtool --alertmanager.url http://alertmanager.service.gra.dev.consul/ alert
exit 0
