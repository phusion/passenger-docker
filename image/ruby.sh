#!/bin/bash
set -e
source /build/buildconfig
set -x

$minimal_apt_get_install ruby1.8 ruby1.8-dev
$minimal_apt_get_install ruby1.9.1 ruby1.9.1-dev
$minimal_apt_get_install ruby2.0 ruby2.0-dev
$minimal_apt_get_install rake ruby-switch

echo "gem: --no-ri --no-rdoc" > /etc/gemrc

gem1.8 install rake bundler --no-rdoc --no-ri
gem1.9.1 install rake bundler --no-rdoc --no-ri
gem2.0 install rake bundler --no-rdoc --no-ri

update-alternatives --set ruby /usr/bin/ruby2.0
update-alternatives --set gem /usr/bin/gem2.0

## Fix shebang lines in rake and bundler so that they're run with the currently
## configured default Ruby instead of the Ruby they're installed with.
sed -i 's|/usr/bin/env ruby2.0|/usr/bin/env ruby|' /usr/local/bin/rake /usr/local/bin/bundle

## Install development headers for native libraries that tend to be used often by gems.
## For nokogiri.
$minimal_apt_get_install libxml2-dev libxslt1-dev
## For rmagick and minimagick.
$minimal_apt_get_install imagemagick libmagickwand-dev
## For mysql and mysql2.
$minimal_apt_get_install libmysqlclient-dev
## For sqlite3.
$minimal_apt_get_install libsqlite3-dev
## For postgres and pg.
$minimal_apt_get_install libpq-dev
## For capybara-webkit.
$minimal_apt_get_install libqt4-webkit libqt4-dev
## For curb.
$minimal_apt_get_install libcurl4-openssl-dev
## For all kinds of stuff.
$minimal_apt_get_install zlib1g-dev


## The Rails asset compiler requires a Javascript runtime.
## Node.js is already installed through another script.
