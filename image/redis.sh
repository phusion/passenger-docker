#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

## Install Redis.
apt-get install -y redis-server libhiredis-dev
mkdir /etc/service/redis
cp /pd_build/runit/redis /etc/service/redis/run
cp /pd_build/config/redis.conf /etc/redis/redis.conf
touch /etc/service/redis/down
