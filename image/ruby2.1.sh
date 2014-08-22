#!/bin/bash
set -e
source /build/buildconfig
set -x

minimal_apt_get_install ruby2.1 ruby2.1-dev
gem2.1 install rake bundler --no-rdoc --no-ri
/build/ruby-finalize.sh
