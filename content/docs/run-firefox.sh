#!/bin/bash
set -xv
gksudo firefox -P owasp-wte -install-global-extension https://addons.mozilla.org/firefox/downloads/latest/1865/addon-1865-latest.xpi
gksudo firefox -P owasp-wte -install-global-extension https://addons.mozilla.org/firefox/downloads/latest/466852/addon-466852-latest.xpi
gksudo firefox -P owasp-wte -install-global-extension https://addons.mozilla.org/firefox/downloads/latest/ssleuth/
gksudo firefox -P owasp-wte -install-global-extension https://addons.mozilla.org/en-US/firefox/addon/https-everywhere/
