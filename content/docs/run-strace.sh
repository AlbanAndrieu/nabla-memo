#!/bin/bash
set -xv
strace -o /tmp/output.txt tail -f /workspace/users/albandri30/nabla-servers/sample/jsf-simple/deploy.log
/usr/bin/truss -f -o /var/tmp/syslog.truss.out /opt/csw/bin/vim test.log
