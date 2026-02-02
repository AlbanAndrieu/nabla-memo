#!/bin/bash
set -xv
docker run -it -p "8080:8080" devopsfaith/krakend
exit 0
