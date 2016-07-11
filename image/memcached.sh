#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing memcached..."

run apt-get install -y memcached
run mkdir /etc/service/memcached
run cp /pd_build/runit/memcached /etc/service/memcached/run
run touch /etc/service/memcached/down
run cp /pd_build/config/memcached.conf /etc/memcached.conf
