#!/bin/bash
set -xv
savscan -h
sudo /opt/sophos-av/bin/savlog --today
sudo /opt/sophos-av/bin/savdstatus
sudo /opt/sophos-av/bin/savdctl enable
sudo /opt/sophos-av/bin/savdctl disable
