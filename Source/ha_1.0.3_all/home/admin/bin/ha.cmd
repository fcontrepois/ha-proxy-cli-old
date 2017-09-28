#!/bin/bash

source /home/admin/lib/cli
source /home/admin/lib/ha

case $1 in
start)
  source $ucarpconfig
  ${UCARP_EXEC} ${UCARP_OPTS} > /dev/null 2>&1 &
  exit $?
;;
stop)
  pgrep ucarp >/dev/null 2>&1
  [ $? -ne 0 ] && exit 0
  [ -r $ucarppid ] && sudo kill $(cat $ucarppid) && exit 0
  kill $(pgrep ucarp) 
  exit $?
;;
*)
 echo "unknown"
 exit 1
;;
esac
exit 0
