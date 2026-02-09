#!/bin/bash
set -xv

sudo apt install rclone

rclone config

ll ~/.config/rclone/rclone.conf

rclone lsd BackupStorageS3:

# rclone ls swift:bucket

# rclone sync remote_swift:container_name remote_s3:bucket_name
rclone ls BackupStorageS3:tf-gra-assistant-user-upload-dev

rclone sync tf-gra-assistant-user-upload-dev:tf-gra-assistant-user-upload-dev tf-gra-assistant-user-upload-uat:tf-gra-assistant-user-upload-uat

source /workspace/users/albandrieu30/nabla/env/home/pass/os-dev.sh
export RCLONE_CONFIG_MYREMOTE_TYPE=swift
export RCLONE_CONFIG_MYREMOTE_ENV_AUTH=true
export OS_REGION_NAME="GRA"

rclone lsd assistant-storage-dev:
rclone ls assistant-storage-dev:
rclone ls assistant-storage-dev:assistant-storage-dev

rclone sync assistant-storage-dev:assistant-storage-dev tf-gra-assistant-user-upload-dev:tf-gra-assistant-user-upload-dev

exit 0
