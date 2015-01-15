#!/bin/bash
set -e
source /build/buildconfig
set -x

## Brightbox Ruby 1.9.3, 2.0 and 2.1
echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main > /etc/apt/sources.list.d/brightbox.list

## Phusion Passenger
if [[ "$PASSENGER_ENTERPRISE" ]]; then
	echo deb https://download:$PASSENGER_ENTERPRISE_DOWNLOAD_TOKEN@www.phusionpassenger.com/enterprise_apt trusty main > /etc/apt/sources.list.d/passenger.list
else
	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list
fi

## Chris Lea's Node.js PPA
echo deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main > /etc/apt/sources.list.d/nodejs.list

## Rowan's Redis PPA
echo deb http://ppa.launchpad.net/rwky/redis/ubuntu trusty main > /etc/apt/sources.list.d/redis.list

# The recv-keys part takes a bit of time, so it's faster to receive multiple keys at once.
#
# Brightbox
# Phusion Passenger
# Chris Lea's Node.js PPA
# Rowan's Redis PPA
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
C3173AA6 \
561F9B9CAC40B2F7 \
C7917B12 \
5862E31D

## Debian's sid repo, needed for OpenJDK 8.
apt-key adv --keyserver pgpkeys.mit.edu --recv-keys 8B48AD6246925553
echo deb http://http.us.debian.org/debian unstable main non-free contrib > /etc/apt/sources.list.d/sid.list
echo -e "\
Package: *\n\
Pin: release o=Debian\n\
Pin-Priority: -10\n" > /etc/apt/preferences.d/sid

apt-get update
