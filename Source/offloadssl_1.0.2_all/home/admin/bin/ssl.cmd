#!/bin/bash

source /home/admin/lib/cli
source /home/admin/lib/ssl


case "$1" in 
start)
  if [ "$2" = "" ]; then
    for conf in /home/admin/etc/ssl/*.conf; do 
      $sslexec $conf
    done
  else
    $sslexec $2
  fi
chmod 644 $chrootdir/*.log
;;
stop)
  if [ "$2" = "" ]; then
    for pidfile in $chrootdir/*.pid; do 
      pid=$(cat $pidfile)
      kill $pid
    done
  else
    pid=$(cat $chrootdir/$2.pid)
    kill $pid
  fi
;;
status)
  [ "$2" = "" ] && echo "0"
  pid=$(cat $chrootdir/$2.pid)
  [ "$pid" = "" ] && echo 0 && exit 0 
  echo 1
;;
*)
 exit 1
;;
esac
exit 0
