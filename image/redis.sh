#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing Redis..."

## Install Redis.
run apt-get install -y redis-server libhiredis-dev
run mkdir /etc/service/redis
run cp /pd_build/runit/redis /etc/service/redis/run
run cp /pd_build/config/redis.conf /etc/redis/redis.conf
run touch /etc/service/redis/down
