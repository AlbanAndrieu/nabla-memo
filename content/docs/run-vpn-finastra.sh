#!/bin/bash
set -xv
alias workoff='deactivate'
deactivate
echo $WORKON_HOME
unset HTTP_PROXY
unset HTTPS_PROXY
unset NO_PROXY
echo $HTTP_PROXY $HTTPS_PROXY $NO_PROXY
export VPN_USER=${VPN_USER:-"alban.andrieu@finastra.com"}
expressvpn disconnect||  true
case $1 in
paris)vpnhost=parravpn
  shift
;;
london)vpnhost=lonravpn
  shift
;;
bangalore)vpnhost=blrravpn
  shift
;;
*)echo valid entry point: paris, london
  exit 1
esac
echo "$vpnhost.finastra.com"
openconnect-sso --server $vpnhost.finastra.com --user $VPN_USER   -l DEBUG $*
echo "http://crowdstrike.provides.io/"
echo "google-chrome http://crowdstrike.provides.io/ || true"
echo "/opt/cisco/anyconnect/bin/vpnui"
/opt/cisco/anyconnect/bin/vpn_uninstall.sh
exit 0
