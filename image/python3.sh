#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing Python 3 ..."

## Install Python.
run apt-get install -y python3
