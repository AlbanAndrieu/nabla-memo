#!/bin/bash
set -xv

./run-scan.sh

# https://tesseract-ocr.github.io/tessdoc/Installation.html

sudo apt install tesseract-ocr

pip install pytesseract

exit 1
