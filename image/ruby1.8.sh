#!/bin/bash
set -e
source /build/buildconfig
set -x

$minimal_apt_get_install ruby1.8 ruby1.8-dev
gem1.8 install rake bundler --no-rdoc --no-ri
/build/ruby-finalize.sh
