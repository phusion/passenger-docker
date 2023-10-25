#!/bin/bash
set -e
source /pd_build/buildconfig

RVM_ID=$(basename "$0" | sed 's/.sh$//')

run mkdir -p "/build_cache/${ARCH}"

# Ruby 3.0 does not support OpenSSL 3.0, so we need to install 1.1 ourselves
header "Installing OpenSSL 1.1"
run minimal_apt_get_install zlib1g-dev
if [[ -f /build_cache/${ARCH}/openssl1.1.tar.gz ]]; then
	cd /usr/local
	tar -xvf /build_cache/${ARCH}/openssl1.1.tar.gz
	cd
else
	run /pd_build/install_openssl1.1.sh
	cd /usr/local
	tar -czvf /build_cache/${ARCH}/openssl1.1.tar.gz ssl
	cd
fi

header "Installing $RVM_ID"
if [[ -e "/build_cache/${ARCH}/${RVM_ID}.tar.bz2" ]]; then
	# use cached ruby if present
	run /usr/local/rvm/bin/rvm mount "/build_cache/${ARCH}/${RVM_ID}.tar.bz2"
else
	# otherwise build one
	MAKEFLAGS=-j$(nproc) run /usr/local/rvm/bin/rvm install $RVM_ID --with-openssl-dir=/usr/local/ssl --disable-cache || ( cat /usr/local/rvm/log/*${RVM_ID}*/*.log && false )
	run cd "/build_cache/${ARCH}"
	run /usr/local/rvm/bin/rvm prepare "${RVM_ID}"
	run cd /
fi

run /usr/local/rvm/bin/rvm-exec $RVM_ID@global gem install $DEFAULT_RUBY_GEMS --no-document
# Make passenger_system_ruby work.
run create_rvm_wrapper_script ruby3.0 $RVM_ID ruby
run /pd_build/ruby_support/install_ruby_utils.sh
run /pd_build/ruby_support/finalize.sh
