#!/bin/bash
set -e
source /build/buildconfig
set -x

## This script is to be run after ruby1.8.sh, ruby1.9.sh, ruby2.0.sh and ruby2.1.sh.

$minimal_apt_get_install ruby-switch
echo "gem: --no-ri --no-rdoc" > /etc/gemrc

## Fix shebang lines in rake and bundler so that they're run with the currently
## configured default Ruby instead of the Ruby they're installed with.
sed -i 's|/usr/bin/env ruby.*$|/usr/bin/env ruby|' /usr/local/bin/rake /usr/local/bin/bundle

## The Rails asset compiler requires a Javascript runtime.
$minimal_apt_get_install nodejs

## Set the latest available Ruby as the default.
if [[ -e /usr/bin/ruby2.1 ]]; then
	ruby-switch --set ruby2.1
elif [[ -e /usr/bin/ruby2.0 ]]; then
	ruby-switch --set ruby2.0
elif [[ -e /usr/bin/ruby1.9.1 ]]; then
	ruby-switch --set ruby1.9.1
fi
