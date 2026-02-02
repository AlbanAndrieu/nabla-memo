#!/bin/bash
set -xv
ykman info
ykman piv access unblock-pin
ykman piv reset
ykman piv access change-management-key --generate --protect
ykman piv access change-pin --pin 123456 --new-pin XXX
ykman piv certificates import 9a /home/albanandrieu/w/nabla/env/linux/cnf/ca-nabla.cer
ykman piv keys import 9a /home/albanandrieu/w/nabla/env/linux/cnf/ca-nabla.key
echo $ROOT_CA_PASSPHRASE
yubico-piv-tool -a status
ykman --diagnose
sudo apt remove yubico-piv-tool
sudo apt --fix-broken install
sudo apt autoremove
exit 0
