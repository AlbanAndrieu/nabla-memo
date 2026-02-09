#!/bin/bash
set -xv

# See https://www.howtoforge.com/tutorial/linux-grep-command/
# use grep -r instead
grep cdn.jusmundi.com -Rw
#alias Grep="find . -name '*.[jch]*' -exec grep -n \!* {} + -o -name '.svn' -prune -type f"
#alias hGrep="find . -name '*.h' -exec grep -n \!* {} + -o -name '.svn' -prune -type f"
# grep -r mysearch ./
alias Grep="find . -name '*.*' -type f  -not -path '*/\.git/*' | xargs grep {} "
#alias Grep="grep -r  {} . "
#echo "find . -type d -name ".svn"  -print | xargs rm -Rf"
#echo "find . -name 'pom.xml' | xargs grep SNAPSHOT"

exit 0
