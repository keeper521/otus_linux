#!/bin/bash

yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc;
wget https://nginx.org/packages/centos/8/SRPMS/nginx-1.20.2-1.el8.ngx.src.rpm -P /root;
useradd -s /sbin/nologin builder;
rpm -i /root/nginx-1.*;
wget https://www.openssl.org/source/openssl-1.1.1w.tar.gz -P /root;
tar -xvf /root/openssl-1.1.1w.tar.gz --directory /root;
yum-builddep /root/rpmbuild/SPECS/nginx.spec -y;
sed -i '/--with-ld-opt="%{WITH_LD_OPT}" \\/a \    --with-openssl=/root/openssl-1.1.1w \\' /root/rpmbuild/SPECS/nginx.spec
rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec;
ll /root/rpmbuild/RPMS/x86_64/;
yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el8.ngx.x86_64.rpm;
systemctl start nginx;
mkdir /usr/share/nginx/html/repo;
cp /root/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el8.ngx.x86_64.rpm /usr/share/nginx/html/repo/;
wget https://downloads.percona.com/downloads/percona-distribution-mysql-ps/percona-distribution-mysql-ps-8.0.28/binary/redhat/8/x86_64/percona-orchestrator-3.2.6-2.el8.x86_64.rpm -O /usr/share/nginx/html/repo/percona-orchestrator-3.2.6-2.el8.x86_64.rpm;
createrepo /usr/share/nginx/html/repo/;
sudo sed -i '/location \/ {/ {N;N;s/index  index.html index.htm;/&\n        autoindex on;/}' /etc/nginx/conf.d/default.conf;
nginx -t;
nginx -s reload;
sleep 5;
curl -a http://localhost/repo/;
cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
yum repolist enabled | grep otus;
yum list | grep otus;
yum install percona-orchestrator.x86_64 -y;




