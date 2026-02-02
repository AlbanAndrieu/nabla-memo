#!/bin/bash
set -xv

# https://www.freebsd.org/status/report-2023-04-2023-06/wazuh/

# pkg install security/wazuh-agent
# Install agent will remove wazuh-manager

pkg install security/py-fail2ban
pkg remove openjdk8 openjdk11
pkg install openjdk17

pkg upgrade
pkg install security/wazuh-server
# It will install wazuh-manager beats7 logstash8
# And remove security/wazuh-agent
# pkg install security/wazuh-manager

Message from wazuh-manager-4.7.5:

--
Wazuh Manager was installed

1) Copy /etc/locatime to /var/ossec/etc directory

   # cp /etc/localtime /var/ossec/etc

2) You must edit /var/ossec/etc/ossec.conf.sample for your setup and rename/copy
   it to ossec.conf.

   Take a look wazuh manager configuration at the following url:

   https://documentation.wazuh.com/current/user-manual/manager/index.html

3) Move /var/ossec/etc/client.keys.sample to /var/ossec/etc/client.keys. This
   file is used to store all agents credentials connected to wazuh-manager

   # mv /var/ossec/etc/client.keys.sample /var/ossec/etc/client.keys

4) You can find additional useful files installed at

  # /var/ossec/packages_files/manager_installation_scripts

5) Do not forget generate auth certificate

  openssl req -x509 -batch -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=US/ST=California/CN=Wazuh/" \
	-keyout /var/ossec/etc/sslmanager.key -out /var/ossec/etc/sslmanager.cert
  # chmod 640 /var/ossec/etc/sslmanager.key
  # chmod 640 /var/ossec/etc/sslmanager.cert

6) FreeBSD rules, decoders and SCA files are installed by default. For more
   information about updates take a look at:

   https://github.com/alonsobsd/wazuh-freebsd

   Decoders and rules are used for extract some /var/log/userlog and
   /var/log/messages entries from FreeBSD agents. It is necessary add a localfile
   entry to /var/ossec/etc/ossec.conf

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/userlog</location>
  </localfile>

7) Add Wazuh manager to /etc/rc.conf

  # sysrc wazuh_manager_enable="YES"

  or

  # service wazuh-manager enable

8) Start Wazuh manager

  # service wazuh-manager start

9) Add Filebeat and Logstash to /etc/rc.conf

   # sysrc filebeat_enable="YES"
   # sysrc logstash_enable="YES"

10) Start Filebeat and Logstash services

   # service filebeat start
   # service logstash start


ls -lrta /var/ossec/logs
tail -f /var/ossec/logs/ossec.log

# echo "https://10.0.0.30:5601"

# API
echo "https://172.17.0.2:55000/"

echo "https://172.17.0.2:5601/"

pkg install security/wazuh-indexer # wazuh-kibana-app
# will install opensearch210:

Wazuh indexer components were installed

1) Wazuh indexer is based on opensearch project. This guide help you for adapt
   wazuh configuration for it works on FreeBSD using apps are part of ports
   tree.

2) Copy /usr/local/etc/wazuh-indexer/wazuh-indexer.yml to /usr/local/etc/opensearch/opensearch.yml

3) Edit /usr/local/etc/opensearch/opensearch.yml and changes options accord to your
   setup. For example host, ssl, nodes options, etc. On this guide we will use
   like host 172.17.0.2

4) If you want use a simple way to generate wazuh infrastructure certificates
   you can use a simplified version of certificates generator script located at:

   cd /usr/local/etc/opensearch/
   pkg install wget
   wget https://people.freebsd.org/~acm/ports/wazuh/wazuh-gen-certs.tar.gz
   gunzip wazuh-gen-certs.tar.gz
   tar -xvf  wazuh-gen-certs.tar
   cd wazuh-gen-certs

5) Wazuh needs opensearch-security features. Rename or copy samples files
   into /usr/local/etc/opensearch/opensearch-security

   # cd /usr/local/etc/opensearch/opensearch-security
   # sh -c 'for i in $(ls *.sample ) ; do cp -p ${i} $(echo ${i} | sed "s|.sample||g") ; done'

6) You can define a custom admin password modifying internal_users.yml file into
   /usr/local/etc/opensearch/opensearch-security/

   admin:
     hash: "XXX"

   Hash password can be generated using opensearch-security hash script tool

   # cd /usr/local/lib/opensearch/plugins/opensearch-security/tools/
   # sh -c "OPENSEARCH_JAVA_HOME=/usr/local/openjdk11 ./hash.sh -p adminpass"

7) Add OpenSearch to /etc/rc.conf

   # sysrc opensearch_enable="YES"

8) Start OpenSearch

 cat /usr/local/lib/opensearch/bin//opensearch-env
  cat /usr/local/lib/opensearch/bin/opensearch

  # service opensearch start

  ls -lrt /usr/local/openjdk17

  ls -lrt /usr/local/lib/opensearch

  tail -f /var/log/opensearch/opensearch.log

9) Finally you must initialize opensearch cluster

  cd /usr/local/lib/opensearch/plugins/opensearch-security/tools/
  ln -s wazuh-gen-certs/wazuh-certificates/ certs

  # https://wiki.freebsd.org/OpenSearch

  cat /usr/local/etc/opensearch/opensearch-security/internal_users.yml

  sh -c "OPENSEARCH_JAVA_HOME=/usr/local/openjdk11 ./securityadmin.sh \
    -cd /usr/local/etc/opensearch/opensearch-security/ -cacert /usr/local/etc/opensearch/certs/root-ca.pem \
    -cert /usr/local/etc/opensearch/certs/admin.pem -key /usr/local/etc/opensearch/certs/admin-key.pem -h 172.17.0.2 -p 9200 -icl -nhnv"

  sh -c "OPENSEARCH_JAVA_HOME=/usr/local/openjdk17/ /usr/local/lib/opensearch/plugins/opensearch-security/tools/securityadmin.sh \
  -icl \
  -t internalusers \
  -cacert /usr/local/etc/opensearch/root-ca.pem \
  -cert /usr/local/etc/opensearch/osnode.pem \
  -key /usr/local/etc/opensearch/osnode-key.pem \
  -cd /usr/local/etc/opensearch/opensearch-security/ \
  -h  172.17.0.2 -p 9200 "

10) You can look more useful information at the following link:

    https://documentation.wazuh.com/current/installation-guide/wazuh-indexer/step-by-step.html

    Take on mind wazuh architecture on FreeBSD is configured not similar like
    you can read at wazuh guide

11) Testing your server installation

   # curl -k -u admin:xxx https://10.0.0.10:9200 #nosec allow:gitleaks
   # curl -k -u admin:xxx https://10.0.0.10:9200/_cat/nodes?v #nosec allow:gitleaks
   curl -k -u admin:xxx http://172.17.0.2:9200/ #nosec allow:gitleaks

pkg install security/wazuh-dashboard

sysrc opensearch_dashboards_enable="YES"

service opensearch-dashboards start

service opensearch restart
rm -f /var/log/opensearch/opensearch-2024-*.gz
tail -f /var/log/opensearch/opensearch.log

cat /var/log/opensearch/nabla-wazuh.log

# Issue : https://github.com/wazuh/wazuh-packages/issues/2139
ls -lrte /usr/local/etc/wazuh-indexer/
nano /usr/local/etc/opensearch/opensearch-performance-analyzer/opensearch_security.policy
# Add
grant {
  permission java.lang.RuntimePermission "accessUserInformation";
};

java.lang.IllegalStateException: failed to load plugin class [org.opensearch.security.OpenSearchSecurityPlugin]
Likely root cause: OpenSearchException[plugins.security.ssl.transport.keystore_filepath or plugins.security.ssl.transport.server.pemcert_filepath and plugins.security.ssl.transport.client.pemcert_filepath must be set if transport ssl is requested.]
rm -Rf  /tmp/opensearch-*

cd /usr/local/etc/opensearch/opensearch-security
cp opensearch.yml.sample opensearch.yml
chown opensearch:opensearch opensearch.yml

# Disable security
plugins.security.disabled: true
plugins.security.ssl.transport.enabled: false
# plugins.security.ssl.transport.enabled: true
plugins.security.ssl.transport.enforce_hostname_verification: false
plugins.security.ssl.http.enabled: false
# -----------------------------------------
plugins.security.ssl.transport.keystore_type: JKS
plugins.security.ssl.transport.keystore_filepath: wazuh-gen-certs/wazuh-certificates/server1-keystore.jks
plugins.security.ssl.transport.keystore_password: xxx
plugins.security.ssl.transport.truststore_type: JKS
plugins.security.ssl.transport.truststore_filepath: wazuh-gen-certs/wazuh-certificates/server1-keystore.jks
plugins.security.ssl.transport.truststore_password: xxx
# -----------------------------------------
plugins.security.ssl.transport.server.pemcert_filepath: wazuh-gen-certs/wazuh-certificates/server1.pem
plugins.security.ssl.transport.pemcert_filepath: wazuh-gen-certs/wazuh-certificates/server1.pem
plugins.security.ssl.transport.client.pemcert_filepath: wazuh-gen-certs/wazuh-certificates/server1.pem
plugins.security.ssl.transport.client.pemkey_filepath: wazuh-gen-certs/wazuh-certificates/server1-key.pem
plugins.security.ssl.transport.client.pemtrustedcas_filepath: wazuh-gen-certs/wazuh-certificates/root-ca.pem
plugins.security.ssl.transport.client.enforce_hostname_verification: false
plugins.security.allow_unsafe_democertificates: true

cd /usr/local/etc/opensearch/
nano opensearch.yml

ls -lrta /usr/local/etc/opensearch/wazuh-gen-certs/wazuh-certificates

ls -lrta /usr/local/etc/opensearch/esnode.pem
ls -lrta /usr/share/opensearch/config/esnode.pem

cd /usr/local/etc/opensearch/wazuh-gen-certs/wazuh-certificates

openssl pkcs12 -export -in server1.pem -inkey server1-key.pem -out server1-keystore.p12
# alban
#openssl pkcs12 -export -in server1.pem -inkey server1-key.pem -certfile server1CA-crt.pem -out server1-keystore.p12

keytool -importkeystore                              \
  -srcstoretype PKCS12                               \
  -deststoretype JKS                                 \
  -srckeystore /usr/local/etc/opensearch/wazuh-gen-certs/wazuh-certificates/server1-keystore.p12 \
  -destkeystore /usr/local/etc/opensearch/wazuh-gen-certs/wazuh-certificates/server1-keystore.jks
# albandrieu
# alban

# keytool -importkeystore  \
#   -srckeystore /usr/local/etc/opensearch/wazuh-gen-certs/wazuh-certificates/server1-keystore.jks \
#   -destkeystore /usr/local/etc/opensearch/wazuh-gen-certs/wazuh-certificates/server1-keystore.jks \
#   -deststoretype pkcs12

exit 0
