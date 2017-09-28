#!/bin/bash

LOCAL=$(pwd)
remountrw

echo "create the device for the error led"
lsmod | grep cs5535_gpio >/dev/null && [ ! -c /dev/error_led ] && mknod /dev/error_led c 253 6

sed -i 's/ftp.hk.debian/ftp.it.debian/' /etc/apt/sources.list

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
dpkg --purge pptpd
dpkg --purge tcpdump
dpkg --purge bcrelay
dpkg --purge bridge-utils 
dpkg --purge ebtables
dpkg --purge hostap-utils
dpkg --purge hostapd
dpkg --purge iperf
dpkg --purge vlan
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

echo "removing some files"
rm /README*
rm /CHANGELOG
rm -r /tftpboot/
rm /voyage.d*
rm -r /var/cache/apt/*

dpkg --install mime-support_*.deb
dpkg --install lighttpd_*.deb

for pkg in ./dnsmasq_*_i386.deb ./mime-support_*_all.deb ./lighttpd_*_i386.deb vpnc_*_i386.deb cbl-rt_*_all.deb; do 
  echo "installing $pkg"
  dpkg --install $pkg
done

mv /etc/init.d/lighttpd /tmp
update-rc.d lighttpd remove
mv /tmp/lighttpd /etc/init.d/
update-rc.d lighttpd defaults 89

echo "done"
