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
if [[ "$known_rubies" =~ ruby-3\.1 ]]; then
	set_rvm_default ruby-3\.1
elif [[ "$known_rubies" =~ ruby-3\.0 ]]; then
	set_rvm_default ruby-3\.0
elif [[ "$known_rubies" =~ ruby-2\.7 ]]; then
	set_rvm_default ruby-2\.7
elif [[ "$known_rubies" =~ ruby-2\.6 ]]; then
	set_rvm_default ruby-2\.6
elif [[ "$known_rubies" =~ jruby ]]; then
	set_rvm_default jruby
fi

create_rvm_wrapper_script ruby default ruby
create_rvm_wrapper_script gem default gem
create_rvm_wrapper_script rake default rake
create_rvm_wrapper_script bundle default bundle
create_rvm_wrapper_script bundler default bundler
