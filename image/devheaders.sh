#!/bin/bash
set -e
source /build/buildconfig
set -x

## Install development headers for native libraries that tend to be used often by Ruby gems.

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
