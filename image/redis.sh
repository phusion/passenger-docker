#!/bin/bash
set -e
source /build/buildconfig
set -x

## Install Redis.
apt-get install -y redis-server libhiredis-dev
mkdir /etc/service/redis
cp /build/runit/redis /etc/service/redis/run
cp /build/config/redis.conf /etc/redis/redis.conf
touch /etc/service/redis/down
