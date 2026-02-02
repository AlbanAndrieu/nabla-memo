#!/bin/bash
/tmp/paperless.json
{
  "pkgs": [
  "py39-pip",
  "py39-pikepdf",
  "py39-scikit-learn",
  "liberation-fonts-ttf",
  "imagemagick7",
  "zbar",
  "unpaper",
  "icc-profiles-adobe-cs4",
  "qpdf",
  "leptonica",
  "pngquant",
  "lzlib",
  "tesseract",
  "redis",
  "git",
  "mysql80-client",
  "mysql80-server",
  "py39-psycopg2",
  "cmake",
  "py39-scipy",
  "gcc",
  "rust",
  "gnupg",
  "py39-pyinotify",
  "py39-sqlite3",
  "py39-django42",
  "py39-celery",
  "py39-nltk",
  "libxml2",
  "libxslt",
  "expect"
  ]
}
iocage create -n "paperless" -p /tmp/paperless.json -r 13.2-RELEASE ip4_addr="vnet0|172.16.0.28/30" defaultrouter="172.16.0.1" vnet="on" \
  dhcp="on" allow_raw_sockets="1" boot="on" --basejail
jexec 12 sh
cat /etc/resolv.conf
search albandrieu.com
nameserver 172.17.0.1
pkg version -v
pkg update
pkg install bash nano node_exporter zabbix6-agent security/wazuh-agent security/py-fail2ban
pkg install py311-pip py311-pikepdf py311-scikit-learn py311-pyinotify py311-sqlite3 py311-django42 py311-celery py311-nltk py311-psycopg2 py311-scipy
pkg install liberation-fonts-ttf imagemagick7 zbar unpaper icc-profiles-adobe-cs4 qpdf leptonica pngquant lzlib tesseract redis git mysql80-client mysql80-server cmake gcc rust gnupg libxml2 libxslt expect
iocage fetch
iocage upgrade -r 13.5-RELEASE paperless
apt-cache search tesseract-ocr|  grep nor
apt-get install tesseract-ocr-nor tesseract-ocr-fra tesseract-ocr-deu tesseract-ocr-eng tesseract-ocr-spa

PAPERLESS_OCR_LANGUAGE=nor+fra+deu+eng+spa
ls -lrta /usr/src/paperless/media/documents/archive/0000001.pdf
ls -lrta /usr/src/paperless/media/documents/originals/0000001.pdf
exit 0
