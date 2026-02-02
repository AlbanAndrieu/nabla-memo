#!/bin/bash
set -xv
sudo apt-get install simple-scan
simple-scan
sudo apt-get install xsane
xsane
wget https://doc.ubuntu-fr.org/_export/code/xsane2tess?codeblock=0
sudo cp ~/Downloads/xsane2tess /usr/bin/
sudo chmod +x /usr/bin/xsane2tess
ll ~/.sane/xsane/Epson:NX100-OCR-TESSERACT.drc
exit 0
