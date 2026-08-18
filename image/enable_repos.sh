#!/bin/bash
set -e
source /pd_build/buildconfig

header "Preparing APT repositories"

## Phusion Passenger
run apt-get update
run apt-get install -y dirmngr gnupg apt-transport-https ca-certificates curl
run curl https://oss-binaries.phusionpassenger.com/auto-software-signing-gpg-key-2025.txt | gpg --dearmor | tee /etc/apt/trusted.gpg.d/phusion.gpg >/dev/null
if [[ "$PASSENGER_ENTERPRISE" ]]; then
    echo "+ Enabling Passenger Enterprise APT repo"
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/phusion.gpg]" https://download:$PASSENGER_ENTERPRISE_DOWNLOAD_TOKEN@www.phusionpassenger.com/enterprise_apt $(lsb_release -cs) main > /etc/apt/sources.list.d/passenger.list
else
    echo "+ Enabling Passenger APT repo"
    echo deb "[signed-by=/etc/apt/trusted.gpg.d/phusion.gpg]" https://oss-binaries.phusionpassenger.com/apt/passenger $(lsb_release -cs) main > /etc/apt/sources.list.d/passenger.list
fi

run apt-get update
