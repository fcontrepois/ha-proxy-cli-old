#!/bin/bash
# Copyright 2005 Mike Glenn & Homechicken Software
# Distributed under the terms of the GNU General Public License v2

# read in the configuration file
source /home/admin/etc/ha/ucarp.cfg

#remove all modules with ha capabilities
for exec in /home/admin/etc/ha/*-slave.sh ; do 
  [ -x $exec ] && $exec;
done

# bring down the virtual interface
sudo $IFCONFIG $INTERFACE down


