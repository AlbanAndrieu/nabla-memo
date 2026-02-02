#!/bin/bash
set -xv

sudo systemctl status bind9.service

# https://www.zenarmor.com/docs/linux-tutorials/how-to-set-up-bind-dns-server-on-ubuntu-linux

sudo nano /etc/bind/named.conf

acl "trusted" {
        127.0.0.1;
        10.30.10.0/24;
        10.30.0.0/24;
        10.20.0.0/24;
};

statistics-channels {
        inet 10.30.10.85 port 8053 allow { 10.30.10.85; 10.30.0.115; 100.96.0.105; };
        inet 127.0.0.1 port 8053 allow { 127.0.0.1; };
        inet * port 8053;
        inet * port 8053 allow { trusted; };
		# inet *  port 8080 allow { trusted; };
		#inet 127.0.0.1 port 8053 allow { localhost; any; };
		#inet 127.0.0.1 port 8053;
};


sudo rndc dumpdb -zones
sudo rndc stats

sudo nano /etc/bind/named.conf.options
        # forwarders {
        #         10.30.10.3;
        #         10.30.10.4;
        # };
        forwarders {
                8.8.8.8;
                8.8.4.4;
        };

        allow-query {
                any;
        };

        allow-query-cache { trusted; };

        recursion yes;
        allow-recursion { trusted; };

		listen-on { 127.0.0.1; };
		listen-on port 53 {
		127.0.0.1;
		any;
		};

sudo nano  /etc/bind/named.conf.local

zone "example.com" {
        type master;
        file "/etc/bind/zones/db.example.com";
        zone-statistics yes;
};

zone "10.30.10.in-addr.arpa" {
        type master;
        file "/etc/bind/zones/db.30";
        zone-statistics yes;
};

sudo named-checkconf
sudo named-checkzone example.com /etc/bind/zones/db.example.com
sudo named-checkzone 10.30.10.in-addr.arpa /etc/bind/zones/db.30

sudo systemctl restart bind9
sudo iptables -A INPUT -p tcp --dport 8053 -j ACCEPT
sudo lsof -i :8053
curl http://10.30.10.85:8053/
curl http://graansible01.int.jusmundi.com:8053/

# test
dig -x 127.0.0.1
dig ubuntu-fr.org
dig admin.example.com
dig -x 10.30.10.85
dig @10.30.10.85 example.com AXFR
dig @10.30.10.85 admin.example.com

tail -f /var/log/syslog

dig @8.8.8.8 jusmundi.com
#dig @8.8.8.8 test-demo-webapp-bteam.service.gra.dev.consul
dig @10.30.0.152 -p 8600 test-demo-webapp-bteam.service.gra.dev.consul
dig @gradns01.int.jusmundi.com jusmundi.com
dig @gradns01.int.jusmundi.com test-demo-webapp-bteam.service.gra.dev.consul
dig @gradns01.int.jusmundi.com test.bteam.int.jusmundi.com

dig @gradns01.int.jusmundi.com test-demo-webapp-bteam.service.gra.ateam.consul
NOK dig @gradns01.int.jusmundi.com test-demo-webapp-bteam.service.gra.ateam.consul

dig @gradns01.int.jusmundi.com test-demo-webapp-bteam.bteam.int.jusmundi.com

exit 0
