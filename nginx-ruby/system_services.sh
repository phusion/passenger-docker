#!/bin/bash
set -ex

## Install runit, it will be configured later as the init process.
apt-get install -y runit

## Install a syslog daemon.
apt-get install -y syslog-ng
mkdir /etc/service/syslog-ng
cp /build/syslog-ng /etc/service/syslog-ng/run

## Install the SSH server.
apt-get install -y openssh-server
mkdir /var/run/sshd
mkdir /etc/service/sshd
cp /build/sshd /etc/service/sshd/run

## Install default SSH key for root and app.
mkdir -p /root/.ssh /home/app/.ssh
chmod 700 /root/.ssh /home/app/.ssh
chown root:root /root/.ssh
chown app:app /home/app/.ssh
cat /build/insecure_key.pub >> /root/.ssh/authorized_keys
cat /build/insecure_key.pub >> /home/app/.ssh/authorized_keys
