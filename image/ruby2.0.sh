#!/bin/bash
set -e
source /build/buildconfig
set -x

$minimal_apt_get_install ruby2.0 ruby2.0-dev
gem2.0 install rake bundler --no-rdoc --no-ri
/build/ruby-finalize.sh
