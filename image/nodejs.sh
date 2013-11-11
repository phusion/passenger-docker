#!/bin/bash
set -e
source /build/buildconfig
set -x

## Install Node.js (also needed for Rails asset compilation)
apt-get install -y nodejs
