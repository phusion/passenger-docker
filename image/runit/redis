#!/bin/sh
set -e

RUNDIR=/var/run/redis
PIDFILE=$RUNDIR/redis.pid

mkdir -p $RUNDIR
touch $PIDFILE
chown redis:redis $RUNDIR $PIDFILE
chmod 755 $RUNDIR

exec chpst -u redis /usr/bin/redis-server /etc/redis/redis.conf
