#!/bin/bash
set -e
source /build/buildconfig
set -x

$minimal_apt_get_install ruby1.8 ruby1.8-dev rubygems
gem1.8 install rake --no-rdoc --no-ri -v 10.1.1 # last version supporting Ruby 1.8
gem1.8 install bundler --no-rdoc --no-ri
/build/ruby-finalize.sh
