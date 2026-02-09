#!/bin/bash
set -xv

# UI at https://designer.krakend.io/#!/

# https://github.com/krakend/krakend-ce
docker run -it -p "8080:8080" devopsfaith/krakend

exit 0
