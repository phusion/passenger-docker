#!/bin/bash
set -ex

## Fix some issues with APT packages.
## See https://github.com/dotcloud/docker/issues/1024
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

## Create a user for the web app.
addgroup --gid 9999 app
adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
usermod -L app
