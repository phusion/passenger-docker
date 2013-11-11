#!/bin/bash
set -e
source /build/buildconfig
set -x

## Install Python.
apt-get install -y python python2.7 python3
