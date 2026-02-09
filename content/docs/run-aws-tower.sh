#!/bin/bash
set -xv

# See for account check https://github.com/leboncoin/aws-tower
# https://github.com/leboncoin/aws-tower/blob/15d16ad8b0daf3a803c3fc5fdc15039253083de9/config/rules.yaml.sample#L631
alias aws-tower='/workspace/users/albandrieu30/aws-tower/aws_tower_cli.py'
# See https://medium.com/leboncoin-engineering-blog/aws-tower-b3242ca7ca1d
ll ~/.aws/config

./aws_tower_cli.py discover my-aws-account-profile

exit 0
