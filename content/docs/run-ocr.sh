#!/bin/bash
set -xv
./run-scan.sh
sudo apt install tesseract-ocr
pip install pytesseract
exit 1
