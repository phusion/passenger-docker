#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing OS updates"

run apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
