#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

echo "+ Enabling Node Source APT repo"
curl -sL https://deb.nodesource.com/setup_16.x | bash -
apt-get update

## Install Node.js (also needed for Rails asset compilation)
minimal_apt_get_install nodejs
echo "+ Updating npm"
run npm update npm -g || ( cat /root/.npm/_logs/*-debug.log && false )
if [[ ! -e /usr/bin/node ]]; then
	ln -s /usr/bin/nodejs /usr/bin/node
fi
