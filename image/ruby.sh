#!/bin/bash
set -e
source /build/configuration
set -x

apt-get install -y ruby ruby-dev
apt-get install -y ruby1.8 ruby1.8-dev
apt-get install -y ruby1.9.1 ruby1.9.1-dev
apt-get install -y ruby2.0 ruby2.0-dev
apt-get install -y rake ruby-switch

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
apt-get install -y libxml2-dev libxslt1-dev
## For rmagick and minimagick.
apt-get install -y imagemagick libmagickwand-dev
## For mysql and mysql2.
apt-get install -y libmysqlclient-dev
## For sqlite3.
apt-get install -y libsqlite3-dev
## For postgres and pg.
apt-get install -y libpq-dev
## For capybara-webkit.
apt-get install -y libqt4-webkit libqt4-dev
## For curb.
apt-get install -y libcurl4-openssl-dev
## For all kinds of stuff.
apt-get install -y zlib1g-dev


## The Rails asset compiler requires a Javascript runtime.
## Node.js is already installed through another script.
