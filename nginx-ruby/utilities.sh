#!/bin/bash
set -e
source /build/configuration
set -x

## Many Ruby gems and NPM packages contain native extensions and require a compiler.
apt-get install -y --no-install-recommends build-essential
## Bundler has to be able to pull dependencies from git.
apt-get install -y git
## Other often used tools.
apt-get install -y curl less nano vim

## Memcached
apt-get install -y memcached
mkdir /etc/service/memcached
cp /build/runit/memcached /etc/service/memcached/run
touch /etc/service/memcached/down

## Redis
apt-get install -y redis-server libhiredis-dev
mkdir /etc/service/redis
cp /build/runit/redis /etc/service/redis/run
cp /build/redis.conf /etc/redis/redis.conf
touch /etc/service/redis/down
