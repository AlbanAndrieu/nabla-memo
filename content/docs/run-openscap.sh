#!/bin/bash
set -xv

# sudo apt-get install libopenscap8
sudo apt-get install openscap-common libopenscap25t64

#Check jenkins job docker-scap-admin
git clone https://github.com/GovReady/ubuntu-scap.git || true
cd ubuntu-scap || true
#cp ubuntu-* /media/ftp/download/scap/
#rm -f ubuntu-xccdf.xml || true
#wget http://albandrieu.com/download/ubuntu-xccdf.xml || true
./run_tests.sh || true

#Ensure /tmp Located On Separate Partition
#CCE-26435-8
#https://www.maketecheasier.com/move-home-folder-ubuntu/
#https://help.ubuntu.com/community/Partitioning/Home/Moving

# See http://www.open-scap.org/tools/scap-workbench/

# NOK sudo apt-get install scap-workbench

git clone --recurse-submodules https://github.com/OpenSCAP/openscap.git
cd openscap

sudo apt-get install cmake libdbus-1-dev libdbus-glib-1-dev libcurl4-openssl-dev \
  libgcrypt20-dev libselinux1-dev libxslt1-dev libgconf2-dev libacl1-dev libblkid-dev \
  libcap-dev libxml2-dev libldap2-dev libpcre3-dev swig libxml-parser-perl \
  libxml-xpath-perl libperl-dev libbz2-dev librpm-dev g++ libapt-pkg-dev libyaml-dev
#python-dev

cd build/
cmake ../
make

sudo make install

which oscap
#bash ./run utils/oscap xccdf eval /workspace/users/albandrieu30/ubuntu-scap/ubuntu-xccdf.xml

cd /workspace/users/albandrieu30/ubuntu-scap/

--------

# https://blog.stephane-robert.info/docs/securiser/durcissement/openscap/

ansible-galaxy install stephrobert.openscap

--------

sudo apt-get install openscap-scanner

oscap xccdf eval \
  --profile xccdf_ubuntu_profile_default \
  --cpe ubuntu-cpe.xml \
  --check-engine-results --oval-results --results results.xml \
  --report results.html \
  ubuntu-xccdf.xml

sudo apt install ssg-debian ssg-debderived ssg-applications

# From https://github.com/ComplianceAsCode/content/releases
wget https://github.com/ComplianceAsCode/content/releases/download/v0.1.75/scap-security-guide-0.1.75.zip scap-security-guide-0.1.75.zip
# If you downloaded the zip file
unzip -l scap-security-guide-0.1.75.zip       # List files
unzip scap-security-guide-0.1.75.zip *ubuntu* # Extract files

source /etc/os-release
unzip scap-security-guide-0.1.75.zip "*ansible/$ID*" "*ssg-$ID*xml"

oscap info scap-security-guide-0.1.75/ssg-ubuntu2204-ds.xml
oscap info scap-security-guide-0.1.75/ssg-ubuntu2404-ds.xml

# See https://medium.com/@anshumaansingh10jan/comprehensive-vm-hardening-guide-using-openscap-and-ansible-88bd93186ddd
oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_cis_level2_server --fetch-remote-resources \
  --results before-hardening-results.xml \
  --results-arf before-hardening-arf-results.xml \
  --report /var/www/nabla/public/reports/before-hardening-report.html \
  scap-security-guide-0.1.75/ssg-ubuntu2204-ds.xml

# Or profile
xccdf_org.ssgproject.content_profile_standard

oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_cis_level2_workstation --fetch-remote-resources \
  --results before-hardening-results.xml \
  --results-arf before-hardening-arf-results.xml \
  --report /var/www/nabla/public/reports/before-hardening-report.html \
  scap-security-guide-0.1.75/ssg-ubuntu2204-ds.xml

oscap info before-hardening-results.xml

# Generating Remediation Playbooks
# oscap xccdf generate fix --fix-type ansible --fetch-remote-resources \
# --output hardening-playbook.yml \
# --result-id xccdf_org.ssgproject.content_profile_cis_level2_server \
# scap-security-guide-0.1.75/ssg-ubuntu2204-ds.xml

oscap xccdf generate fix --profile xccdf_org.ssgproject.content_profile_cis_level2_workstation --fix-type ansible \
  --output hardening-playbook.yml \
  before-hardening-results.xml

oscap xccdf generate --verbose DEVEL --verbose-log-file out.out --profile xccdf_org.ssgproject.content_profile_cis_level1_workstation fix --fix-type bash --output harden.sh scap-security-guide-0.1.75/ssg-ubuntu2204-ds.xml
sudo ./harden.sh

exit 0
