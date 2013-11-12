#!/bin/bash
set -e
source /build/buildconfig
set -x

/build/enable_repos.sh
/build/prepare.sh
/build/pups.sh
/build/nginx-passenger.sh

if [[ -z "$minimal" ]]; then
	/build/utilities.sh
	/build/ruby1.8.sh
	/build/ruby1.9.sh
	/build/ruby2.0.sh
	/build/devheaders.sh
	/build/python.sh
	/build/nodejs.sh
	/build/memcached.sh
	/build/redis.sh
fi

/build/finalize.sh
