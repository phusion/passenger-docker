#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing Python 2 ..."

## Install Python.
run apt-get install -y python2.7
