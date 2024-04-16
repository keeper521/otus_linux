#!/bin/bash

cat << EOF > /etc/sysconfig/watchlog 
# Configuration file for my watchlog service
# Place it to /etc/sysconfig

# File and word in that file that we will be monit
WORD="ALERT"
LOG=/var/log/watchlog.log
EOF
cat << EOF > /var/log/watchlog.log 
test ALERT
EOF
cat << EOF > /opt/watchlog.sh
#!/bin/bash

WORD=\$1
LOG=\$2
DATE=\`date\`

if grep \$WORD \$LOG &> /dev/null
then
logger "\$DATE: I found word, Master!"
else
exit 0
fi
EOF
chmod +x /opt/watchlog.sh;
cat << EOF > /etc/systemd/system/watchlog.service
[Unit]
Description=My watchlog service

[Service]
Type=oneshot
EnvironmentFile=/etc/sysconfig/watchlog
ExecStart=/opt/watchlog.sh \$WORD \$LOG
EOF
cat << EOF > /etc/systemd/system/watchlog.timer
[Unit]
Description=Run watchlog script every 30 second

[Timer]
# Run every 30 second
OnUnitActiveSec=30
Unit=watchlog.service

[Install]
WantedBy=multi-user.target
EOF
systemctl start watchlog.timer;
systemctl start watchlog.service;
yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y;
cat << EOF > /etc/sysconfig/spawn-fcgi
# You must set some working options before the "spawn-fcgi" service will work.
# If SOCKET points to a file, then this file is cleaned up by the init script.
#
# See spawn-fcgi(1) for all possible options.
#
# Example :
SOCKET=/var/run/php-fcgi.sock
OPTIONS="-u apache -g apache -s \$SOCKET -S -M 0600 -C 32 -F 1 -- /usr/bin/php-cgi"
EOF
cat << EOF > /etc/systemd/system/spawn-fcgi.service
[Unit]
Description=Spawn-fcgi startup service by Otus
After=network.target

[Service]
Type=simple
PIDFile=/var/run/spawn-fcgi.pid
EnvironmentFile=/etc/sysconfig/spawn-fcgi
ExecStart=/usr/bin/spawn-fcgi -n \$OPTIONS
KillMode=process

[Install]
WantedBy=multi-user.target
EOF
systemctl start spawn-fcgi;
cat << EOF > /usr/lib/systemd/system/httpd.service
[Unit]
Description=The Apache HTTP Server
Wants=httpd-init.service

After=network.target remote-fs.target nss-lookup.target httpd-init.service

Documentation=man:httpd.service(8)

[Service]
Type=notify
Environment=LANG=C
EnvironmentFile=/etc/sysconfig/httpd-%I
ExecStart=/usr/sbin/httpd \$OPTIONS -DFOREGROUND
ExecReload=/usr/sbin/httpd \$OPTIONS -k graceful
# Send SIGWINCH for graceful stop
KillSignal=SIGWINCH
KillMode=mixed
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
cat << EOF > /etc/sysconfig/httpd-first
OPTIONS=-f conf/first.conf
EOF
cat << EOF > /etc/sysconfig/httpd-second
OPTIONS=-f conf/second.conf
EOF
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/first.conf;
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/second.conf;
sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/second.conf;
echo "PidFile /var/run/httpd-second.pid" >> /etc/httpd/conf/second.conf;
systemctl start httpd@first;
systemctl start httpd@second;
