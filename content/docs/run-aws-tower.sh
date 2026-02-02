#!/bin/bash
set -xv
alias aws-tower='/workspace/users/albandrieu30/aws-tower/aws_tower_cli.py'
ll ~/.aws/config
./aws_tower_cli.py discover my-aws-account-profile
exit 0
