#!/bin/bash
twadmin -m G -S /etc/tripwire/site.key
twadmin --create-cfgfile -S /etc/tripwire/site.key /etc/tripwire/twcfg.txt
tripwire --init
exit 0
