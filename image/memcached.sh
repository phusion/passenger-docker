#!/bin/bash
set -e
source /build/buildconfig
set -x

apt-get install -y memcached
mkdir /etc/service/memcached
cp /build/runit/memcached /etc/service/memcached/run
touch /etc/service/memcached/down
cp /build/config/memcached.conf /etc/memcached.conf
