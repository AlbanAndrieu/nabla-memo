#!/bin/bash
set -xv
cygrunsrv.exe -I remoteos -p /cygdrive/c//workspace/users/albandri30/nabla/myservice -a "-p 4004" --type auto
starting/stopping service
cygrunsrv -S myservice
cygrunsrv -E myservice
exit 0
