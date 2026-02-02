#!/bin/bash
set -xv
pkg install screen lsof
pkg install node
npm install -g private-bower
/usr/local/bin/node: Undefined symbol "nghttp2_option_set_max_settings"
pkg version -vRx node
pkg upgrade
echo 'bower_enable="YES"' >> /etc/rc.conf
cd /usr/local/etc/rc.d/
edit bower
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/root/bin:/usr/local/fusion-io
. /etc/rc.subr
name="bower"
rcvar=bower_enable
load_rc_config "$name"
: ${bower_enable="NO"}
: ${bower_home="/usr/local/bower"}
: ${bower_args=""}
: ${bower_user="bower"}
: ${bower_group="bower"}
: ${bower_log_file="/var/log/bower.log"}
pidfile="/var/run/bower/bower.pid"
command="/usr/sbin/daemon"
procname="$java_cmd"
command_args="-p $pidfile /usr/local/bin/private-bower $bower_args >> $bower_log_file 2>&1"
required_files="$java_cmd"
start_precmd="bower_prestart"
start_cmd="bower_start"
bower_prestart()
                 {
  if [ ! -f "$bower_log_file"   ];then
    touch "$bower_log_file"
    chmod 640 "$bower_log_file"
fi
  if [ ! -d "/var/run/bower" ];then
    install -d -o "$bower_user"   -g "$bower_group"   -m 750 "/var/run/bower"
fi
}
bower_start()
              {
  check_startmsgs&&  echo "Starting $name."
  exec $command   $command_args   $rc_arg
}
run_rc_command "$1"
chmod +x bower
cd /usr/local/lib/node_modules/private-bower/
nano bower.conf.json
git clone git://albandrieu.com:6789/nabla-styles
git ls-remote --tags --heads git://albandrieu.com:6789/nabla-styles
cd /usr/local/lib/node_modules/private-bower/bin/
private-bower --config bower.conf.json
cd /usr/local/lib/node_modules/
ln -s /media/bower/ private-bower
ls -lrta /usr/local/lib/node_modules/private-bower/gitRepoCache
cd /media/bower/gitRepoCache
chown -R bower:bower *
lsof -i :5678
lsof -i :6789
service bower onestart
http://192.168.1.61:5678/
cd /usr/local/lib/node_modules/private-bower/gitRepoCache
git fetch&&  git fetch --tags
git checkout 2.1.4
exit 0
