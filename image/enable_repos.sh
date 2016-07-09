#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

## Brightbox Ruby 2.0, 2.1 and 2.2
echo deb http://ppa.launchpad.net/brightbox/ruby-ng-experimental/ubuntu xenial main > /etc/apt/sources.list.d/brightbox.list

## Phusion Passenger
if [[ "$PASSENGER_ENTERPRISE" ]]; then
	echo deb https://download:$PASSENGER_ENTERPRISE_DOWNLOAD_TOKEN@www.phusionpassenger.com/enterprise_apt xenial main > /etc/apt/sources.list.d/passenger.list
else
	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list
fi

# The recv-keys part takes a bit of time, so it's faster to receive multiple keys at once.
#
# Brightbox
# Phusion Passenger
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
	C3173AA6 \
	561F9B9CAC40B2F7

apt-get update
