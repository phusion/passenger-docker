#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

## This script is to be run after ruby1.9.sh, ruby2.0.sh, ruby2.1.sh,
## ruby2.1.sh and jruby9.0.sh.

cp /pd_build/ruby-switch /usr/local/bin/ruby-switch
# The --bindir is necessary for JRuby. We don't want jgem to install to /usr/local/jruby-xxx/bin.
echo "gem: --no-ri --no-rdoc --bindir /usr/local/bin" > /etc/gemrc

## Fix shebang lines in rake and bundler so that they're run with the currently
## configured default Ruby instead of the Ruby they're installed with.
sed -E -i 's|/usr/bin/env j?ruby.*$|/usr/bin/env ruby|; s|/usr/bin/j?ruby.*$|/usr/bin/env ruby|' \
	/usr/local/bin/rake /usr/local/bin/bundle /usr/local/bin/bundler

## The Rails asset compiler requires a Javascript runtime.
minimal_apt_get_install nodejs
if [[ ! -e /usr/bin/node ]]; then
	ln -s /usr/bin/nodejs /usr/bin/node
fi

## Install development headers for native libraries that tend to be used often by Ruby gems.

## For nokogiri.
minimal_apt_get_install libxml2-dev libxslt1-dev
## For rmagick and minimagick.
minimal_apt_get_install imagemagick libmagickwand-dev
## For mysql and mysql2.
minimal_apt_get_install libmysqlclient-dev
## For sqlite3.
minimal_apt_get_install libsqlite3-dev
## For postgres and pg.
minimal_apt_get_install libpq-dev
## For curb.
minimal_apt_get_install libcurl4-openssl-dev
## For all kinds of stuff.
minimal_apt_get_install zlib1g-dev

## Set the latest available Ruby as the default.
if [[ -e /usr/bin/ruby2.3 ]]; then
	ruby-switch --set ruby2.3
elif [[ -e /usr/bin/ruby2.2 ]]; then
	ruby-switch --set ruby2.2
elif [[ -e /usr/bin/ruby2.1 ]]; then
	ruby-switch --set ruby2.1
elif [[ -e /usr/bin/ruby2.0 ]]; then
	ruby-switch --set ruby2.0
elif [[ -e /usr/bin/ruby1.9.1 ]]; then
	ruby-switch --set ruby1.9.1
elif [[ -e /usr/bin/jruby ]]; then
	ruby-switch --set jruby
fi
