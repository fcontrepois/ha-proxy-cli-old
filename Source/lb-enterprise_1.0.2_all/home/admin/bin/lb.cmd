#!/bin/bash

source /home/admin/lib/cli
source /home/admin/lib/lb

case $1 in 
start)
  $lbexec -f $lbconfig -c
  if [ $? -eq 0 ];then
    sudo $lbexec -f $lbconfig
  fi
;;
stop)
if [ -f /tmp/lb.pid ]; then
  sudo kill $(cat /tmp/lb.pid)
else
  sudo kill $(pgrep lb)
fi

;;
*)
 echo "unknown"
 exit 1
;;
esac
exit 0
