#!/bin/bash
#set -xv

#check mod ssl
#/usr/ports/www/apache24]#  make showconfig | grep ssl
#     SSL=on: SSL/TLS support (mod_ssl)

# DISABLE grep -n 'mod_ssl' /usr/local/etc/apache24/httpd.conf
# grep -n 'mod_http2' /usr/local/etc/apache24/httpd.conf
grep -n 'mod_remoteip' /usr/local/etc/apache24/httpd.conf
# https://pruszewicz.com/wordpress/category/apache/
# NO remoteip.conf
# Invalid command 'RewriteEngine'
grep -n 'mod_rewrite' /usr/local/etc/apache24/httpd.conf
grep -n 'mod_proxy' /usr/local/etc/apache24/httpd.conf
grep -n 'mod_proxy_fcgi' /usr/local/etc/apache24/httpd.conf
nl -ba /usr/local/etc/apache24/httpd.conf | grep mod_proxy_fcgi.so

grep -n 'mod_deflate' /usr/local/etc/apache24/httpd.conf
grep -n 'mod_logio' /usr/local/etc/apache24/httpd.conf

# You need to enable mod_logio.c to use %I and %O
# AH00526: Syntax error on line 30 of
# Unrecognized LogFormat directive %O

# enable mod_logio
nl -ba /usr/local/etc/apache24/httpd.conf | grep 'mod_logio'
sudo vi +119 /usr/local/etc/apache24/httpd.conf

# https://www.digitalocean.com/community/tutorials/how-to-configure-apache-http-with-mpm-event-and-php-fpm-on-freebsd-12-0
# The mpm module (prefork.c) is not supported by mod_http2. The mpm determines how things are processed in your server. HTTP/2 has more demands in this regard and the currently selected mpm will just not do. This is an advisory warning. Your server will continue to work, but the HTTP/2 protocol will be inactive
php -v
php -m
#a2dismod mpm_prefork
#a2enmod mpm_event
nl -ba /usr/local/etc/apache24/httpd.conf | grep 'mod_mpm_prefork'
sudo vi +68 /usr/local/etc/apache24/httpd.conf
nl -ba /usr/local/etc/apache24/httpd.conf | grep 'mpm_event'
sudo vi +68 /usr/local/etc/apache24/httpd.conf
# a2enmod http2
# sudo pkg remove -y mod_php74

# apachectl -M | grep 'mpm'
#  mpm_prefork_module (shared)

# Apache is running a threaded MPM, but your PHP Module is not compiled to be threadsafe.  You need to recompile PHP.

service apache24 restart

tail -f /var/log/httpd-error.log

grep deflate /usr/local/etc/apache24/httpd.conf
#LoadModule deflate_module libexec/apache24/mod_deflate.so
nano /usr/local/etc/apache24/Includes/mod_deflate.conf

---------------------------

<IfModule mod_deflate.c>
        <IfModule mod_filter.c>
            # these are known to be safe with MSIE 6
            AddOutputFilterByType DEFLATE text/html text/plain text/xml

            # everything else may cause problems with MSIE 6
            AddOutputFilterByType DEFLATE text/css
            AddOutputFilterByType DEFLATE application/x-javascript application/javascript application/ecmascript
            AddOutputFilterByType DEFLATE application/rss+xml
            AddOutputFilterByType DEFLATE application/xml
            AddOutputFilterByType DEFLATE image/svg+xml

            #Highest 9 - Lowest 1
            DeflateCompressionLevel 9

            #Optional
            #Skip browsers with known problems
            BrowserMatch ^Mozilla/4 gzip-only-text/html
            BrowserMatch ^Mozilla/4\.0[678] no-gzip
            BrowserMatch \bMSIE !no-gzip !gzip-only-text/html

            #Optional
            #Logging
            DeflateFilterNote ratio
            LogFormat '"%r" %b (%{ratio}n) "%{User-agent}i"' deflate
            CustomLog /var/log/deflate_log deflate
        </IfModule>
</IfModule>

# AH01873: Init: Session Cache is not configured
httpd.conf:LoadModule ssl_module libexec/apache24/mod_ssl.so
# AH10034: The mpm module (prefork.c) is not supported by mod_http2. The mpm determines how things are processed in your server. HTTP/2 has more demands in this regard and the currently selected mpm will just not do. This is an advisory warning. Your server will continue to work, but the HTTP/2 protocol will be inactive
a2dismod mpm_prefork
a2enmod mpm_event

exit 0
