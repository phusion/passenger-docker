#!/bin/bash
set -ex

if [[ "$PASSENGER_ENTERPRISE" ]]; then
	apt-get install -y passenger-enterprise
else
	apt-get install -y passenger
fi
