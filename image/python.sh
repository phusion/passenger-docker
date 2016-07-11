#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing Python..."

## Install Python.
run apt-get install -y python python2.7 python3
