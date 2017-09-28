#!/bin/bash
# Copyright 2005 Mike Glenn & Homechicken Software
# Distributed under the terms of the GNU General Public License v2

# read in the configuration file
source /home/admin/etc/ha/ucarp.cfg

# bring up the virtual interface (this is one line)
sudo $IFCONFIG $INTERFACE $VIRTUAL_ADDRESS netmask $VIRTUAL_NETMASK

#activate all modules with ha capabilities
for exec in /home/admin/etc/ha/*-master.sh ; do 
  [ -x $exec ] && $exec;
done
