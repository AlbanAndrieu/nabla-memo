#!/bin/bash
set -xv
COPY --chmod=644 oci/crons /etc/cron.d/crons
RUN chmod 0644 /etc/cron.d/crons&&  crontab /etc/cron.d/crons&&  touch /var/log/cron.log
ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-noarch.tar.xz   /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-x86_64.tar.xz   /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz&&  tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz&&  rm -rf /tmp/s6*
ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-symlinks-noarch.tar.xz   /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-symlinks-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-symlinks-arch.tar.xz   /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-symlinks-arch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/syslogd-overlay-noarch.tar.xz   /tmp
RUN tar -C / -Jxpf /tmp/syslogd-overlay-noarch.tar.xz
COPY --chmod=755 oci/s6/php-fpm.sh /etc/s6-overlay/s6-rc.d/php-fpm/run
RUN wget -O /usr/local/bin/php-fpm-healthcheck https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/v0.5.0/php-fpm-healthcheck&&  chmod +x /usr/local/bin/php-fpm-healthcheck
COPY --chmod=755 oci/s6/php-fpm-healthcheck.sh /usr/local/bin/
RUN echo "longrun" > /etc/s6-overlay/s6-rc.d/php-fpm/type
RUN echo "3" > /etc/s6-overlay/s6-rc.d/php-fpm/notification-fd
RUN touch /etc/s6-overlay/s6-rc.d/user/contents.d/php-fpm
COPY --chmod=755 oci/s6/apache2.sh /etc/s6-overlay/s6-rc.d/apache2/run
RUN echo "longrun" > /etc/s6-overlay/s6-rc.d/apache2/type
RUN echo "3" > /etc/s6-overlay/s6-rc.d/apache2/notification-fd
RUN echo "php-fpm" > /etc/s6-overlay/s6-rc.d/apache2/dependencies
RUN touch /etc/s6-overlay/s6-rc.d/user/contents.d/apache2
COPY --chmod=755 oci/s6/cron.sh /etc/s6-overlay/s6-rc.d/cron/run
RUN echo "longrun" > /etc/s6-overlay/s6-rc.d/cron/type
RUN echo "apache2" > /etc/s6-overlay/s6-rc.d/cron/dependencies
RUN touch /etc/s6-overlay/s6-rc.d/user/contents.d/cron
rm /etc/services/sidecar.svc/run
s6-svc -d /etc/services/sidecar.svc/
s6-svc -u /etc/services/sidecar.svc/
/etc/s6-overlay/s6-rc.d/apache2# chmod 777 run
cd /etc/s6-overlay/s6-rc.d/apache2# chown www-data:www-data -R .
exit 0
