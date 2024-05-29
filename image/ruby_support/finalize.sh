#!/bin/bash
set -e
source /pd_build/buildconfig

## Remove useless files.
rm -f /usr/local/rvm/rubies/*/lib/libruby-static.a

known_rubies=`/usr/local/rvm/bin/rvm list strings`

## Fix https://github.com/rvm/rvm/issues/5449
for ver in $known_rubies; do
	sed -e 's/require/load/g' -i'' "/usr/local/rvm/rubies/$ver/.irbrc"
done

## Set the latest available Ruby as the default.
function set_rvm_default()
{
	local regex="$1"
	local match

	match=$(grep "$regex" <<< $known_rubies | head -n 1)
	echo "+ Setting $match as default RVM Ruby"
	bash -lc "rvm use $match --default"
}

# descending order is important, with jruby last
if [[ "$known_rubies" =~ ruby-3\.3 ]]; then
	set_rvm_default ruby-3\.3
elif [[ "$known_rubies" =~ ruby-3\.2 ]]; then
	set_rvm_default ruby-3\.2
elif [[ "$known_rubies" =~ ruby-3\.1 ]]; then
	set_rvm_default ruby-3\.1
elif [[ "$known_rubies" =~ jruby ]]; then
	set_rvm_default jruby
fi

create_rvm_wrapper_script ruby default ruby
create_rvm_wrapper_script gem default gem
create_rvm_wrapper_script rake default rake
create_rvm_wrapper_script bundle default bundle
create_rvm_wrapper_script bundler default bundler
