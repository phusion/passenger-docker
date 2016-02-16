#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

## Install Node.js (also needed for Rails asset compilation)
minimal_apt_get_install nodejs
