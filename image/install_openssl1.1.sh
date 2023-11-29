#!/bin/bash

set -e

if [[ ! -d /usr/local/ssl ]]; then
	PWD=$(pwd)
	cd /usr/local/src/
	git clone https://github.com/openssl/openssl.git -b OpenSSL_1_1_1-stable openssl-1.1.1w
	cd openssl-1.1.1w
	./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
	make -j$(nproc)
	make install_sw
	ln -s /etc/ssl/certs /usr/local/ssl/certs

	cd "${PWD}"
	rm -rf /usr/local/src/openssl*
fi
