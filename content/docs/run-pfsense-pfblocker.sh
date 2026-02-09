#!/bin/bash
set -xv

# Check router http://172.17.0.12/start.htm
# it getblocked
# if  https://home.albandrieu.com:10443/pfblockerng/pfblockerng_category.php?type=ipv4 PRI1 Deny outbound

# Check log https://home.albandrieu.com:10443/pfblockerng/pfblockerng_log.php
# ip_block.log
# Nov 18 23:04:39,1770011929,mvneta0.4090,WAN,block,4,17,UDP,95.214.27.41,82.66.4.247,13618,53,in,BG,pfB_PRI1_v4,95.214.27.0/24,ET_Block_v4,Unknown,wan,Unknown,+
# Nov 18 23:04:43,1770011929,mvneta0.4090,WAN,block,4,6,TCP-S,79.124.49.226,82.66.4.247,41657,3997,in,BG,pfB_PRI1_v4,79.124.49.226,CINS_army_v4,ip-49-226.4vendeta.com,wan,Unknown,+

exit 0
