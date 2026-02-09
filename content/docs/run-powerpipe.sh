#!/bin/bash
set -xv

# https://powerpipe.io/downloads

# sudo /bin/sh -c "$(curl -fsSL https://powerpipe.io/install/powerpipe.sh)"
brew install turbot/tap/powerpipe
brew install turbot/tap/steampipe

cd $HOME
mkdir dashboards
cd dashboards

powerpipe mod init
# https://hub.powerpipe.io/mods/turbot/gitlab_insights
powerpipe mod install github.com/turbot/steampipe-mod-gitlab-insights
powerpipe mod install github.com/turbot/steampipe-mod-github-insights
powerpipe mod install github.com/turbot/steampipe-mod-github-compliance
# https://powerpipe.io/blog/migrating-from-steampipe
# powerpipe mod install github.com/turbot/powerpipe-mod-aws-compliance
powerpipe mod install github.com/turbot/steampipe-mod-aws-insights
powerpipe mod install github.com/turbot/steampipe-mod-aws-compliance
powerpipe mod install github.com/turbot/steampipe-mod-tailscale-compliance

steampipe service start
steampipe plugin install github
steampipe plugin install tailscale
steampipe plugin install aws
steampipe plugin update --all

powerpipe server

# Open http://localhost:9033 in your browser.

powerpipe query run "select title from aws_account"

powerpipe benchmark list
powerpipe benchmark run tailscale_compliance.benchmark.security_best_practices
powerpipe benchmark run github_compliance.benchmark.cis_supply_chain_v100

exit 0
