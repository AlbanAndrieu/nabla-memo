#!/bin/bash
set -xv

sudo apt-get install s3cmd

# scaleway

s3cmd la
s3cmd -c ~/.s3cfg_scaleway_fr_par la

s3cmd put -c ~/.s3cfg_scaleway_fr_par --recursive --no-progress --no-preserve backup-*.snap s3://ovh-replica/vault/ 2>&1

#Defaults to $HOME/.s3cfg
ll .s3cfg_scaleway_fr_par

# ovh
# See https://help.ovhcloud.com/csm/fr-public-cloud-storage-s3-s3cmd?id=kb_article_view&sysparm_article=KB0047492

s3cmd --configure
s3cmd ls
s3cmd ls s3://tf-gra-assistant-user-upload-dev

s3cmd put $HOME/Downloads/2024-04-Jus_AI-security-fact-sheet.pdf s3://tf-gra-assistant-user-upload-dev/test
s3cmd -c $HOME/.s3cfg-tf-gra-assistant-user-upload-dev ls s3://tf-gra-assistant-user-upload-dev
s3cmd -c $HOME/.s3cfg-tf-gra-assistant-user-upload-dev get s3://tf-gra-assistant-user-upload-dev/test $HOME/Downloads/test-TODELETE.pdf
# NOK s3cmd -c $HOME/.s3cfg-tf-gra-assistant-user-upload-dev info s3://tf-gra-assistant-user-upload-dev

s3cmd -c $HOME/.s3cfg-tf-gra-assistant-user-upload-uat ls s3://tf-gra-assistant-user-upload-dev
s3cmd -c $HOME/.s3cfg-tf-gra-assistant-user-upload-dev rm s3://tf-gra-assistant-user-upload-dev/test

exit 0
