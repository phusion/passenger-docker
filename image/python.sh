#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

## Install Python.
apt-get install -y python python2.7 python3
