#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

echo "+ Enabling Node Source APT repo"
NODE_MAJOR=18
mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
apt-get update

## Install Node.js (also needed for Rails asset compilation)
minimal_apt_get_install nodejs
echo "+ Updating npm"
run npm update npm -g || ( cat /root/.npm/_logs/*-debug.log && false )
if [[ ! -e /usr/bin/node ]]; then
	ln -s /usr/bin/nodejs /usr/bin/node
fi
