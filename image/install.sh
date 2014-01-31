#!/bin/bash
set -e
source /build/buildconfig
set -x

/build/enable_repos.sh
/build/prepare.sh
/build/pups.sh
/build/utilities.sh

if [[ "$ruby18" = 1 ]]; then /build/ruby1.8.sh; fi
if [[ "$ruby19" = 1 ]]; then /build/ruby1.9.sh; fi
if [[ "$ruby20" = 1 ]]; then /build/ruby2.0.sh; fi
if [[ "$ruby21" = 1 ]]; then /build/ruby2.1.sh; fi
if [[ "$python" = 1 ]]; then /build/python.sh; fi
if [[ "$nodejs" = 1 ]]; then /build/nodejs.sh; fi

# Must be installed after Ruby, so that we don't end up with two Ruby versions.
/build/nginx-passenger.sh

/build/finalize.sh
