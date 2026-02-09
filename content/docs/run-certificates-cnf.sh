#!/bin/bash
set -xv

cd cnf/

# example

openssl req -x509 -new -keyout root.key -out root.cer -config root.cnf
# passphrase ${ROOT_CA_PASSPHRASE}
openssl req -nodes -new -keyout server.key -out server.csr -config server.cnf
openssl x509 -days 825 -req -in server.csr -CA root.cer -CAkey root.key -set_serial 123 -out server.cer -extfile server.cnf -extensions x509_ext

# nabla

openssl req -x509 -new -keyout ca-nabla.key -out ca-nabla.cer -config ca-nabla.cnf
# passphrase ${ROOT_CA_PASSPHRASE}
openssl req -nodes -new -keyout server-nabla.key -out server-nabla.csr -config server-nabla.cnf
openssl x509 -days 825 -req -in server-nabla.csr -CA ca-nabla.cer -CAkey ca-nabla.key -set_serial 123 -out server-nabla.cer -extfile server-nabla.cnf -extensions x509_ext

openssl x509 -in server-nabla.cer -noout -text | grep DNS

openssl verify -CAfile ca.crt server-nabla.crt

openssl verify -CAfile ca-nabla.cer server-nabla.cer

# nabla albandrieu.com bababou.com

openssl req -x509 -new -keyout ca-nabla.key -out ca-nabla.cer -config ca-nabla.cnf
# passphrase ${ROOT_CA_PASSPHRASE}
openssl req -nodes -new -keyout server-nabla.key -out server-nabla.csr -config server-nabla.cnf
openssl x509 -days 3600 -req -in server-nabla.csr -CA ca-nabla.cer -CAkey ca-nabla.key -set_serial 123 -out server-nabla.cer -extfile server-nabla.cnf -extensions x509_ext

open .

# https://www.sslshopper.com/certificate-decoder.html

sudo cp ca-nabla.cer /usr/local/share/ca-certificates/ca-nabla.cer
sudo update-ca-certificates

exit 0
