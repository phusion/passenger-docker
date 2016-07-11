#!/bin/bash
set -e
source /pd_build/buildconfig

## Remove useless files.
rm -f /usr/local/rvm/rubies/*/lib/libruby-static.a

## Set the latest available Ruby as the default.

function set_rvm_default()
{
	local regex="$1"
	local match

	match=`/usr/local/rvm/bin/rvm list strings | grep "$regex" | head -n 1`
	echo "+ Setting $match as default RVM Ruby"
	bash -lc "rvm use $match --default"
}

known_rubies=`/usr/local/rvm/bin/rvm list strings`
if [[ "$known_rubies" =~ ^ruby-2\.3 ]]; then
	set_rvm_default '^ruby-2\.3'
elif [[ "$known_rubies" =~ ^ruby-2\.2 ]]; then
	set_rvm_default '^ruby-2\.2'
elif [[ "$known_rubies" =~ ^ruby-2\.1 ]]; then
	set_rvm_default '^ruby-2\.1'
elif [[ "$known_rubies" =~ ^ruby-2\.0 ]]; then
	set_rvm_default '^ruby-2\.0'
elif [[ "$known_rubies" =~ ^jruby ]]; then
	set_rvm_default '^jruby'
fi
