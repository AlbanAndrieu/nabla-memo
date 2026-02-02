#!/bin/sh
curl -s https://www.iblocklist.com/lists.php|sed -n "s/.*value='\(http:.*\)'.*/\1/p"|sed "s/\&amp;/\&/g"|sed 's/http/"http/g'|sed 's/gz/gz"/g'|xargs curl -s -L|gunzip|egrep -v '^#'|gzip - > ./bt_blocklist.gz
exit 0
