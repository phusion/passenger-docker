#!/bin/bash
set -e
source /build/buildconfig
set -x

## Many Ruby gems and NPM packages contain native extensions and require a compiler.
apt-get install -y --no-install-recommends build-essential
## Bundler has to be able to pull dependencies from git.
apt-get install -y git
## Other often used tools.
apt-get install -y curl less nano vim psmisc

## This tool runs a command as another user and sets $HOME.
cp /build/setuser /sbin/setuser

## Memcached.
apt-get install -y memcached
mkdir /etc/service/memcached
cp /build/runit/memcached /etc/service/memcached/run
touch /etc/service/memcached/down
cp /build/config/memcached.conf /etc/memcached.conf

## Redis.
apt-get install -y redis-server libhiredis-dev
mkdir /etc/service/redis
cp /build/runit/redis /etc/service/redis/run
cp /build/config/redis.conf /etc/redis/redis.conf
touch /etc/service/redis/down

## Simple image bootstrapper.
git clone https://github.com/SamSaffron/pups.git /usr/local/pups
(cd /usr/local/pups && git reset --hard 57108ddb3e91e612fd24d3f85f9134ec28e180b8)
sed -i 's|/usr/bin/env ruby|/usr/bin/ruby2.0|' /usr/local/pups/bin/pups
cat >/usr/local/bin/pups <<EOF
#!/bin/sh
exec /usr/local/pups/bin/pups "\$@"
EOF
chmod +x /usr/local/bin/pups
