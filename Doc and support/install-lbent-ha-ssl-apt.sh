#!/bin/bash

LOCAL=$(pwd)
remountrw

echo "create the device for the error led"
lsmod | grep cs5535_gpio >/dev/null && [ ! -c /dev/error_led ] && mknod /dev/error_led c 253 6


echo "removing some packages"
#removing some packages
dpkg --purge casper 
dpkg --purge syslinux 
dpkg --purge atftpd 
dpkg --purge nfs-user-server 
dpkg --purge bzip2 
dpkg --purge unionfs-tools 
dpkg --purge sg3-utils 
dpkg --purge minicom 
dpkg --purge dnsmasq 
dpkg --purge pptpd
dpkg --purge tcpdump
dpkg --purge bcrelay
dpkg --purge bridge-utils 
dpkg --purge ebtables
dpkg --purge hostap-utils
dpkg --purge hostapd
dpkg --purge iperf
dpkg --purge vlan
dpkg --purge iproute
dpkg --purge iptable
dpkg --purge libatm1
dpkg --purge wireless-tools 
dpkg --purge libiw29
dpkg --purge sqlite3
dpkg --purge libsqlite3-0
dpkg --purge lilo
dpkg --purge madwifi-modules-2.6.23-486-voyage
dpkg --purge madwifi-tools
dpkg --purge parprouted
dpkg --purge pcmciautils
dpkg --purge portmap
dpkg --purge ppp
dpkg --purge watchdog
dpkg --purge wpasupplicant
dpkg --purge rsync
dpkg --purge wget

echo "removing some files"
rm /README*
rm /CHANGELOG
rm -r /tftpboot/
rm /voyage.d*
rm -r /var/cache/apt/*

echo "adding some files"
mkdir -p /var/cache/apt/archives/partial
[ ! -f /etc/hosts ] && echo "127.0.0.1 localhost voyage" > /etc/hosts

cat > /etc/apt/sources.list << EOF
deb http://ftp.it.debian.org/debian etch main
deb http://update.coblan.it/default/UaR-rep appliance/
deb http://update.coblan.it/default/UaR-rep lb-ent/
deb http://update.coblan.it/default/UaR-rep ha/
deb http://update.coblan.it/default/UaR-rep ssl/
EOF

apt-get update

apt-get -y install ntp
apt-get -y install lb-enterprise
apt-get -y install ha
apt-get -y install offloadssl

echo "done"
