#!/bin/bash
set -e
source /build/configuration
set -x

apt-get update
apt-get install -y apt-transport-https

## Ubuntu Universe
echo deb http://archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list
echo deb http://archive.ubuntu.com/ubuntu precise-updates main universe >> /etc/apt/sources.list

## Brightbox Ruby 1.9.3 and 2.0.0
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6
echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu precise main > /etc/apt/sources.list.d/brightbox.list

## Phusion Passenger
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
if [[ "$PASSENGER_ENTERPRISE" ]]; then
	echo deb https://download:$PASSENGER_ENTERPRISE_DOWNLOAD_TOKEN@www.phusionpassenger.com/enterprise_apt precise main > /etc/apt/sources.list.d/passenger.list
else
	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main > /etc/apt/sources.list.d/passenger.list
fi

## Chris Lea's Node.js
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12
echo deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu precise main > /etc/apt/sources.list.d/nodejs.list

apt-get update
