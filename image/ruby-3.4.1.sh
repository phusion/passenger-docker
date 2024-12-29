#!/bin/bash
set -e
source /pd_build/buildconfig

RVM_ID=$(basename "$0" | sed 's/.sh$//')

header "Installing $RVM_ID"

run mkdir -p "/build_cache/${ARCH}"
if [[ -e "/build_cache/${ARCH}/${RVM_ID}.tar.bz2" ]]; then
	# use cached ruby if present
	run /usr/local/rvm/bin/rvm mount "/build_cache/${ARCH}/${RVM_ID}.tar.bz2"
else
	# otherwise build one
	run minimal_apt_get_install rustc # For compiling Ruby with YJIT
	MAKEFLAGS=-j$(nproc) run /usr/local/rvm/bin/rvm install $RVM_ID --disable-cache || ( cat /usr/local/rvm/log/*${RVM_ID}*/*.log && false )
	run cd "/build_cache/${ARCH}"
	run /usr/local/rvm/bin/rvm prepare "${RVM_ID}"
	run cd /
fi

run /usr/local/rvm/bin/rvm-exec $RVM_ID@global gem install $DEFAULT_RUBY_GEMS --no-document
# Make passenger_system_ruby work.
run create_rvm_wrapper_script ruby3.4 $RVM_ID ruby
run /pd_build/ruby_support/install_ruby_utils.sh
run /pd_build/ruby_support/finalize.sh
