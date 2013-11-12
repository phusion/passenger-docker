#!/bin/bash
set -e
source /build/buildconfig
set -x

$minimal_apt_get_install ruby1.9.1 ruby1.9.1-dev
gem1.9.1 install rake bundler --no-rdoc --no-ri
/build/ruby-finalize.sh
