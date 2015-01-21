#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

apt-get install -y memcached
mkdir /etc/service/memcached
cp /pd_build/runit/memcached /etc/service/memcached/run
touch /etc/service/memcached/down
cp /pd_build/config/memcached.conf /etc/memcached.conf
