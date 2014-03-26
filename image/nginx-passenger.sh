#!/bin/bash
set -e
source /build/buildconfig
set -x

## Install Phusion Passenger.
if [[ "$PASSENGER_ENTERPRISE" ]]; then
	apt-get install -y nginx-extras passenger-enterprise
else
	apt-get install -y nginx-extras passenger
fi
cp /build/config/nginx.conf /etc/nginx/nginx.conf
mkdir -p /etc/nginx/main.d
cp /build/config/nginx.default.env /etc/nginx/main.d/default.env

## Install Nginx runit service.
mkdir /etc/service/nginx
cp /build/runit/nginx /etc/service/nginx/run
touch /etc/service/nginx/down
