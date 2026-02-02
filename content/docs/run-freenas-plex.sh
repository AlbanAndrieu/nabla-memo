#!/bin/bash
iocage exec sonarr "pw user add transmission -c media -u 921 -d /nonexistent -s /usr/bin/nologin"
iocage exec radarr "pw user add media -c media -u 8675309 -d /nonexistent -s /usr/bin/nologin"
iocage exec sonarr "pw groupmod media -m plex"
exit 0
