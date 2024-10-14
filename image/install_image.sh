#!/bin/bash
set -e
source /pd_build/buildconfig

# base cleans up apt before here now
run apt-get update

if [[ "$ruby31" = 1 ]]; then run /pd_build/ruby-3.1.*.sh; fi
if [[ "$ruby32" = 1 ]]; then run /pd_build/ruby-3.2.*.sh; fi
if [[ "$ruby33" = 1 ]]; then run /pd_build/ruby-3.3.*.sh; fi
if [[ "$ruby34" = 1 ]]; then run /pd_build/ruby-3.4.*.sh; fi
if [[ "$jruby93" = 1 ]]; then run /pd_build/jruby-9.3.*.sh; fi
if [[ "$jruby94" = 1 ]]; then run /pd_build/jruby-9.4.*.sh; fi
if [[ "$jruby95" = 1 ]]; then run /pd_build/jruby-9.5.*.sh; fi
if [[ "$nodejs" = 1 ]]; then run /pd_build/nodejs.sh; fi
if [[ "$redis" = 1 ]]; then run /pd_build/redis.sh; fi
if [[ "$memcached" = 1 ]]; then run /pd_build/memcached.sh; fi
if [[ "$python39" = 1 ]]; then run /pd_build/python.sh 3.9; fi
if [[ "$python310" = 1 ]]; then run /pd_build/python.sh 3.10; fi
if [[ "$python311" = 1 ]]; then run /pd_build/python.sh 3.11; fi
if [[ "$python312" = 1 ]]; then run /pd_build/python.sh 3.12; fi
if [[ "$python313" = 1 ]]; then run /pd_build/python.sh 3.13; fi
if [[ "$python314" = 1 ]]; then run /pd_build/python.sh 3.14; fi

# Must be installed after Ruby, so that we don't end up with two Ruby versions.
run /pd_build/nginx-passenger.sh

run /pd_build/finalize.sh

cleanup_apt
