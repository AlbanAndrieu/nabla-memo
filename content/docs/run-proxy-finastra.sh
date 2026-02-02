#!/bin/bash
set -xv

# On the host

nano /etc/environment
http_proxy="http://150.151.144.119:3128/"
https_proxy="http://150.151.144.119:3128/"
ftp_proxy="http://150.151.144.119:3128/"
no_proxy="10.1.0.0/16,10.21.191.93/24,150.151.160.25,localhost,127.0.0.1,.finastra.com,.albandrieu.com,.finastra.global,.azurecr.io,.blob.core.windows.net,verdaccio,10.199.52.11"
HTTP_PROXY="http://150.151.144.119:3128/"
HTTPS_PROXY="http://150.151.144.119:3128/"
FTP_PROXY="http://150.151.144.119:3128/"
NO_PROXY="10.1.0.0/16,10.21.191.93/24,150.151.160.25,localhost,127.0.0.1,.finastra.com,.albandrieu.com,.finastra.global,.azurecr.io,.blob.core.windows.net,verdaccio,10.199.52.11"

#See http://www.squid-cache.org/
export HTTP_PROXY=192.168.1.57:3128
export HTTPS_PROXY=192.168.1.57:3128
export NO_PROXY=.albandrieu.com.ad,.nabla.com,.albandrieu.com

#maven .settings.xml

<proxies>
  <proxy>
    <id>id</id>
    <active>true</active>
    <protocol>http</protocol>
    <host>192.168.1.57</host>
    <port>3128</port>
    <nonProxyHosts>artifacts.albandrieu.com.ad|artifacts.albandrieu.com|artifacts</nonProxyHosts>
  </proxy>
</proxies>

#.npmrc

proxy=http://192.168.1.57:3128
https-proxy=http://192.168.1.57:3128
noproxy[]=alm-npmjs
noproxy[]=alm-npmjs.albandrieu.com.ad
noproxy[]=alm-npmjs.albandrieu.com

#.bowerrc

  "proxy": "http://192.168.1.57:3128",
  "https-proxy": "http://192.168.1.57:3128",
  "no-proxy": "alm-artifacts.albandrieu.com.ad",

#docker

nano /lib/systemd/system/docker.service

#sudo mkdir -p /etc/systemd/system/docker.service.d
#nano /etc/systemd/system/docker.service.d/http-proxy.conf
Environment="HTTP_PROXY=http://192.168.1.57:3128"
Environment="HTTPS_PROXY=http://192.168.1.57:3128"
Environment="NO_PROXY=localhost,127.0.0.1,.nabla.com,.albandrieu.com.ad,.albandrieu.com,.azure.io"

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl show --property=Environment docker

#bash

export http_proxy=http://192.168.1.57:3128
export https_proxy=http://192.168.1.57:3128
export no_proxy=localhost,127.0.0.1,.nabla.com,.albandrieu.com.ad,.albandrieu.com,.azure.io

#apt

sudo nano /etc/apt/apt.conf.d/proxy.conf
Acquire::http::Proxy "http://192.168.1.57:3128/";

#snap

sudo snap set system proxy.http="http://192.168.1.57:3128"
sudo snap set system proxy.https="http://192.168.1.57:3128"

#k8s

nano /var/snap/microk8s/current/args/containerd-env
HTTP_PROXY=http://150.151.144.119:3128
NO_PROXY=10.1.0.0/16,10.21.191.93/24,localhost,127.0.0.1,.finastra.com,.albandrieu.com,.finastra.global,.azurecr.io,.blob.core.windows.net,verdaccio,10.199.52.11
sudo systemctl restart snap.microk8s.daemon-containerd.service

exit 0
