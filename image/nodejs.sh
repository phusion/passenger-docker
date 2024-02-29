#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

VERSION=${1:-20}
if ( ! egrep -q nodesource.gpg /etc/apt/sources.list.d/nodesource.list ); then
	## Install Node.js (also needed for Rails asset compilation)

	header "Installing NodeJS ${VERSION}"

	mkdir -p /etc/apt/keyrings
	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --batch --dearmor -o /etc/apt/keyrings/nodesource.gpg
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$VERSION.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
	apt-get update

	minimal_apt_get_install nodejs

	echo "+ Updating npm"
	run npm update npm -g || ( cat /root/.npm/_logs/*-debug.log && false )
	if [[ ! -e /usr/bin/node ]]; then
		ln -s /usr/bin/nodejs /usr/bin/node
	fi

	## create corepack command symlinks (yarn, etc)
	corepack enable
fi
