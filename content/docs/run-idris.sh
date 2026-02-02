#!/bin/bash
set -xv

# See http://www.idris.fr/faqs/ssh_keys.html
ssh uvu37iq@jean-zay.idris.fr

# See http://www.idris.fr/jean-zay/cpu/jean-zay-cpu-connexion-ssh-certificats.html
idr_keygen -t interactive -o ~/interactive_certif.zip
scp uvu37iq@jean-zay.idris.fr:~/interactive_certif.zip ~/
unzip ~/interactive_certif.zip -d ~/.ssh
chmod 600 ~/.ssh/*
ssh-add ~/.ssh/id_ecc_pty

ssh -vi ~/.ssh/id_ecc_pty uvu37iq@jean-zay.idris.fr

idracct

idrproj
Available projects:
-------------------
  ssm (101807/AD011012667R1) [default][active]

idrdoc
idrenv
idr_quota_user
idr_quota_project

# Files transferred over Shell protocol (FISH)
# In Gnom nautilus
# resource ---> connect to server
ssh://jean-zay.idris.fr

exit 0
