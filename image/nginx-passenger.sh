#!/bin/bash
set -e
source /pd_build/buildconfig
source /etc/environment
set -x

## Install Phusion Passenger.
if [[ "$PASSENGER_ENTERPRISE" ]]; then
	apt-get install -y nginx-extras passenger-enterprise
else
	apt-get install -y nginx-extras passenger
fi
cp /pd_build/config/30_presetup_nginx.sh /etc/my_init.d/
cp /pd_build/config/nginx.conf /etc/nginx/nginx.conf
mkdir -p /etc/nginx/main.d
cp /pd_build/config/nginx_main_d_default.conf /etc/nginx/main.d/default.conf

## Install Nginx runit service.
mkdir /etc/service/nginx
cp /pd_build/runit/nginx /etc/service/nginx/run
touch /etc/service/nginx/down

mkdir /etc/service/nginx-log-forwarder
cp /pd_build/runit/nginx-log-forwarder /etc/service/nginx-log-forwarder/run

## Precompile Ruby extensions.
if [[ -e /usr/bin/ruby2.3 ]]; then
	ruby2.3 -S passenger-config build-native-support
	setuser app ruby2.3 -S passenger-config build-native-support
fi
if [[ -e /usr/bin/ruby2.2 ]]; then
	ruby2.2 -S passenger-config build-native-support
	setuser app ruby2.2 -S passenger-config build-native-support
fi
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
if [[ -e /usr/local/jruby-1.7.18/bin/jruby ]]; then
  jruby -S passenger-config build-native-support
  setuser app jruby -S passenger-config build-native-support
fi
