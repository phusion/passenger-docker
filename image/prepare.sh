#!/bin/bash
set -e
source /build/buildconfig
set -x

## Create a user for the web app.
addgroup --gid 9999 app
adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
usermod -L app
mkdir -p /home/app/.ssh
chmod 700 /home/app/.ssh
chown app:app /home/app/.ssh
cat /build/insecure_key.pub > /home/app/.ssh/authorized_keys
