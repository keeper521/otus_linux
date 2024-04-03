#!/bin/bash

yum install -y http://download.zfsonlinux.org/epel/zfs-release.el7_8.noarch.rpm;
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinux;
yum install -y epel-release;
yum install -y kernel-devel;
yum install -y zfs;
yum-config-manager --disable zfs;
yum-config-manager --enable zfs-kmod;
yum install -y zfs && yum install -y wget;
modprobe zfs;