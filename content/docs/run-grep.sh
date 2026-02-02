#!/bin/bash
set -xv
grep cdn.jusmundi.com -Rw
alias Grep="find . -name '*.*' -type f  -not -path '*/\.git/*' | xargs grep {} "
exit 0
