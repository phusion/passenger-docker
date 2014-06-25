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
cp /build/config/nginx_main_d_default.conf /etc/nginx/main.d/default.conf

## Install Nginx runit service.
mkdir /etc/service/nginx
cp /build/runit/nginx /etc/service/nginx/run
touch /etc/service/nginx/down

mkdir /etc/service/nginx-log-forwarder
cp /build/runit/nginx-log-forwarder /etc/service/nginx-log-forwarder/run

## Precompile Ruby extensions.
if [[ -e /usr/bin/ruby2.1 ]]; then
	ruby2.1 -S passenger-config build-native-support
	setuser app ruby2.1 -S passenger-config build-native-support
fi
if [[ -e /usr/bin/ruby2.0 ]]; then
	ruby2.0 -S passenger-config build-native-support
	setuser app ruby2.0 -S passenger-config build-native-support
fi
if [[ -e /usr/bin/ruby1.9.1 ]]; then
	ruby1.9.1 -S passenger-config build-native-support
	setuser app ruby1.9.1 -S passenger-config build-native-support
fi
