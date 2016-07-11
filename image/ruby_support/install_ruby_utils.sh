#!/bin/bash
set -e
source /pd_build/buildconfig

## The Rails asset compiler requires a Javascript runtime.
if [[ ! -e /usr/bin/node ]]; then
	run minimal_apt_get_install nodejs
	run ln -s /usr/bin/nodejs /usr/bin/node
fi

## Install development headers for native libraries that tend to be used often by Ruby gems.
if ! [[ -e /tmp/ruby_native_libs_installed ]]; then
	## For nokogiri.
	run minimal_apt_get_install libxml2-dev libxslt1-dev
	## For mysql and mysql2.
	run minimal_apt_get_install libmysqlclient-dev
	## For sqlite3.
	run minimal_apt_get_install libsqlite3-dev
	## For postgres and pg.
	run minimal_apt_get_install libpq-dev
	## For curb.
	run minimal_apt_get_install libcurl4-openssl-dev
	## For all kinds of stuff.
	run minimal_apt_get_install zlib1g-dev

	touch /tmp/ruby_native_libs_installed
fi
