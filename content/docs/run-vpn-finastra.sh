#!/bin/bash
set -xv

#pip uninstall PyQt5
#pip uninstall PyQt5-sip
#pip uninstall PyQtWebEngine

#sudo apt-get install python3-pyqt5
#pip install pyqt5
#pip install PyQtWebEngine

alias workoff='deactivate'
deactivate
echo $WORKON_HOME

unset HTTP_PROXY
unset HTTPS_PROXY
unset NO_PROXY
echo $HTTP_PROXY $HTTPS_PROXY $NO_PROXY

export VPN_USER=${VPN_USER:-"alban.andrieu@finastra.com"}

expressvpn disconnect || true

# issue : Error: ipv4: Invalid values in header for route get request
# get latest https://gitlab.com/openconnect/vpnc-scripts/-/raw/master/vpnc-script and copy to /usr/share/vpnc-scripts/vpnc-script
#ls -lrta /usr/share/vpnc-scripts/vpnc-script

case $1 in
paris)
  vpnhost=parravpn
  shift
  ;;
london)
  vpnhost=lonravpn
  shift
  ;;
bangalore)
  vpnhost=blrravpn
  shift
  ;;
*)
  echo valid entry point: paris, london
  exit 1
  ;;
esac

echo "$vpnhost.finastra.com"

openconnect-sso --server $vpnhost.finastra.com --user ${VPN_USER} -l DEBUG $*
#openconnect-sso --server lonravpn.finastra.com --user ${VPN_USER}
# London DNS
#nameserver 10.80.48.30
#nameserver 10.80.48.31
# Paris DNS
#nameserver 10.41.200.15

# https://parravpn.finastra.com/+webvpn+/index.html
# https://ise-paris.finastra.global:8443/portal/PortalSetup.action?portal=27b1bc30-2e58-11e9-98fb-0050568775a3&sessionId=0a15fbdc1a64a0005ea54564&action=cpp

echo "http://crowdstrike.provides.io/"
#https://ise-bangalore.finastra.global:8443/
echo "google-chrome http://crowdstrike.provides.io/ || true"

echo "/opt/cisco/anyconnect/bin/vpnui"
#sudo nmcli con show
# tun cscotun0

# Cisco AnyConnect Secure Mobility Client
/opt/cisco/anyconnect/bin/vpn_uninstall.sh

exit 0
