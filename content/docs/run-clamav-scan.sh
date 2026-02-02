#!/bin/bash
set -xv
jail_type="iocage"
jail_location="/mnt/dpool/iocage/jails/"
clamAVJailName="clamav"
your_email=alban.andrieu@free.fr
pid=$$
invalid_email_body=/tmp/jab_clamav_invalid$pid.txt
valid_email_body=/tmp/jab_clamav_valid$pid.txt
clamscan_log=/var/log/clamav/jab_clamscan$pid.log
freshclam_log=/var/log/clamav/freshclam.log
started=$(date "+run_clamav_scan.sh script started at: %Y-%m-%d %H:%M:%S")
scan_location=$1
if [ $jail_type = "iocage" ];then
  scan_location_absolute=$jail_location$clamAVJailName/root/$scan_location
  freshclam_log_fullpath=$freshclam_log
  clamscan_log_fullpath=$clamscan_log
else
  scan_location_absolute=$jail_location$clamAVJailName$scan_location
  freshclam_log_fullpath=$jail_location$clamAVJailName$freshclam_log
  clamscan_log_fullpath=$jail_location$clamAVJailName$clamscan_log
fi
run_tidyup()
             {
  rm -f "$invalid_email_body"
  rm -f "$valid_email_body"
  rm -f "$clamscan_log_fullpath"
}
run_invalid()
              {
  ( echo "To: $your_email"
    echo "Subject: ClamAV Scan - ERROR: $1"
    echo "MIME-Version: 1.0"
    echo -e '\r\n'
    echo "$started$(  date "+ and finished at: %Y-%m-%d %H:%M:%S")"
    echo ""
    echo "To start a ClamAV scan, you need to pass the location of a valid directory or file, i.e."
    echo ""
    echo '     run_clamav_scan.sh "/mnt/tank"'
    echo ""
    echo 'Remember: Placing the scan location in "quotes" allows you to scan files/directories which may have spaces in their name.'
    echo "Also, the directory or file you wish to scan needs to be mounted (read-only is recommended) within the ClamAV Jail."
    echo ""
    echo "------------------------------------------------------------------------------------------------------------------------------"
    echo "Please Note: The latest version of this script can be found at: https://www.github.com/jaburt"
    echo "------------------------------------------------------------------------------------------------------------------------------") > \
"$invalid_email_body"
  sendmail -t -oi < $invalid_email_body
}
run_clamav()
             {
  echo "jail_type : $jail_type - $clamAVJailName"
  if [ $jail_type = "iocage" ];then
    echo "clamscan -i -r -z -a -l $clamscan_log $scan_location in progress"
    iocage exec "$clamAVJailName"   clamscan -i -r -z -a -l $clamscan_log   "$scan_location"
else
    jexec "$clamAVJailName"   clamscan -i -r -l $clamscan_log   "$scan_location"
fi
}
run_sendscanresults()
                      {
  ( echo "To: $your_email"
    echo "Subject: ClamAV Scan - SUCCESS: $scan_location"
    echo "MIME-Version: 1.0"
    echo -e '\r\n'
    echo "$started$(  date "+ and finished at: %Y-%m-%d %H:%M:%S")"
    echo ""
    echo "--------------------------------------"
    echo "ClamAV Scan Summary"
    echo "--------------------------------------"
    tail -n 8 "$clamscan_log_fullpath"
    echo ""
    echo ""
    echo "--------------------------------------"
    echo "freshclam log file"
    echo "--------------------------------------"
    tail -r "$freshclam_log_fullpath"|    tail -n +2|  sed '/--------------------------------------/q'|  sed '$d'|  tail -r
    echo ""
    echo ""
    echo "--------------------------------------"
    echo "List of suspicious files found"
    echo "--------------------------------------"
    tail -n +4 "$clamscan_log_fullpath"|    sed -e :a -e '$d;N;2,10ba' -e 'P;D'
    echo ""
    echo "------------------------------------------------------------------------------------------------------------------------------"
    echo "Please Note: The latest version of this script can be found at: https://www.github.com/jaburt"
    echo "------------------------------------------------------------------------------------------------------------------------------") >> \
$valid_email_body
  sendmail -t -oi < $valid_email_body
}
if [ $# -eq 0 ];then
  run_invalid "No Parameter Provided!"
  run_tidyup
  exit 1
fi
if [ -d "$scan_location_absolute"   ];then
  run_clamav "$scan_location"
  run_sendscanresults
  run_tidyup
  exit 0
elif [ -f "$scan_location_absolute"   ];then
  run_clamav "$scan_location"
  run_sendscanresults
  run_tidyup
  exit 0
else
  run_invalid "Scan Target Location Does Not Exist! $scan_location"
  run_tidyup
  exit 1
fi
