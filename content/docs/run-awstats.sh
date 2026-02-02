#!/bin/bash
set -xv
http://www.home.nabla.mobi/cgi-bin/awstats.pl
cd /etc/awstats
sudo cp awstats.conf awstats.home.nabla.mobi.conf
sudo /usr/lib/cgi-bin/awstats.pl -config=home.albandrieu.com update
sudo chown -R www-data:www-data /var/lib/awstats/
cd /var/lib/awstats
rm *
cd /var/log/apache*
for i in $(ls -tr access.log.*.gz);do
  echo "File processed: $i"
  zcat $i|  /usr/lib/cgi-bin/awstats.pl -config=home.albandrieu.com -update -LogFile=-
done
chmod 755 /var/log/apache2/
chgrp -R www-data /var/log/apache2/
http://www.home.albandrieu.com/cgi-bin/awstats.pl?config=home.albandrieu.com
cd /usr/share/awstats/
pkg install awstats
ls -lrta /usr/local/etc/webmin/webalizer/
See http://albandrieu.com/nabla/webalizer/
exit 0
