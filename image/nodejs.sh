#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

## Install Node.js (also needed for Rails asset compilation)
apt-get install -y nodejs
