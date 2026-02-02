#!/bin/bash
set -xv
echo "https://app.warp.dev/get_warp?linux=true&auto_download=false"
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/git-prompt.sh
if [[ $TERM_PROGRAM != "WarpTerminal" ]];then
fi
echo "https://www.warp.dev/blog/dynamically-sync-env-vars-into-your-terminal-session"
exit 0
