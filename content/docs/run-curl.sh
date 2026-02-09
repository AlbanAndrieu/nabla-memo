#!/bin/bash
set -xv

# See https://support.sonatype.com/hc/en-us/articles/115006744008-How-can-I-programmatically-upload-files-into-Nexus-3-

wget http://albandrieu.com/download/scons/scons-2.4.1.zip
curl -v -u $NEXUS_USER:$NEXUS_PASSWORD --upload-file scons-2.4.1.zip https://albandrieu.com/nexus/content/repositories/nabla/download/scons/scons-2.4.1.zip

# Example if it was whole directory:
find download/elk/ -type f -exec curl -u user:token -v --ftp-create-dirs -T {} https://albandrieu.com/nexus/content/repositories/nabla/{} \;

curl -i http://kong-http.service.gra.${NOMAD_VAR_env}.consul/fake-api/users

curl -i http://alert-api.service.gra.dev.consul/server-status?auto/
curl -i -k https://search-engine-api.service.gra.prod.consul/server-status?auto
curl -i http://10.30.0.115:25831/server-status/
curl -i http://127.0.0.1:4688/server-status/

curl -i -k https://albandrieu.com/server-status?auto
curl -i -k https://manager.albandrieu.com/server-status?auto

exit 0
