#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

## Install Node.js (also needed for Rails asset compilation)
minimal_apt_get_install -y nodejs npm
if [[ ! -e /usr/bin/node ]]; then
	ln -s /usr/bin/nodejs /usr/bin/node
fi
