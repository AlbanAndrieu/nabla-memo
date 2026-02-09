#!/bin/bash
set -xv

#Add DevTools terminal
#https://chrome.google.com/webstore/detail/devtools-terminal/leakmhneaibbdapdoienlkifomjceknl?hl=en

#Chrome remote desktop
#https://chrome.google.com/webstore/detail/chrome-remote-desktop/gbchcmhmhahfdphkhkmpfmihenigjmpp?hl=en

#Secure shell
#https://chrome.google.com/webstore/detail/secure-shell/pnhechapfaindjhompbnflcldabbghjo/related?hl=en

#Switchy omega
#https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif/related?hl=en

#RECX Security Analyzer
#https://chrome.google.com/webstore/detail/recx-security-analyser/ljafjhbjenhgcgnikniijchkngljgjda/related?hl=en

#[ubuntu] Bizarre Chromium/Chrome black screen problem
#Click drop-down menu on top-right corner –> click “Settings” –> click “Show advanced settings…” on the bottom –> scroll to the bottom, and uncheck “Use hardware acceleration when available”.

#See chrome://net-internals
#To disable HTS
#See chrome://net-internals/#hsts

#Fix : Google Chrome opens in a new window in a new launcher icon
#\rm -Rf ~/.local/share/applications/google-chrome-*.desktop

sudo apt purge google-chrome-stable
# User config
rm -r ~/.config/google-chrome/OptGuideOnDeviceModel
rm -r ~/.config/google-chrome/Default/
rm -r ~/.config/google-chrome/Profile\ 7/
rm -r ~/.config/google-chrome/
rm -r ~/.cache/google-chrome/

#NOK sudo apt install google-chrome-stable

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

gnome-keyring-daemon --start --replace --foreground --components=secrets,ssh,pcks11 &
#gnome-keyring-daemon &
mv ~/.config/google-chrome ~/.config/google-chrome-SAV
/usr/bin/google-chrome

# kubernetes dashboard
#chrome://flags/#allow-insecure-localhost

#RedHat fix
#yum install firefox
#yum install mesa-libGLU*.i686 mesa-libGLU*.x86_64

#Bug video
#See https://gist.github.com/ruario/3c873d43eb20553d5014bd4d29fe37f1#file-latest-widevine-sh

# The GIMP Toolkit, anciennement GTK+
# https://fr.wikipedia.org/wiki/GTK_(bo%C3%AEte_%C3%A0_outils)
# sudo apt-get install libgtk-3-dev

# ERR_CERT_COMMON_NAME_INVALID
# https://medium.com/idomongodb/chrome-bypassing-ssl-certificate-check-18b35d2a19fd

# chrome://flags/#unsafely-treat-insecure-origin-as-secure
# https://localhost,https://keycloak-admin.service.gra.dev.consul
# type thisisunsafe

exit 0
