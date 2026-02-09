#!/bin/bash
set -xv

# https://jswheeler.medium.com/logging-pfsense-to-graylog-using-input-extraction-rules-e7dc4972fab0
# https://172.17.0.1:10443/status_logs_settings.php
# https://82.66.4.247:10443/status_logs_settings.php
# 172.17.0.24:1514

# Issue in https://82.66.4.247:10443/status_logs.php
# syslogd sendto: Host is down
# Go to https://82.66.4.247:10443/status_logs_settings.php
# graylog is down http://10.20.0.24:9000/

# Local LoggingDisable writing log files to the local disk

exit 0
