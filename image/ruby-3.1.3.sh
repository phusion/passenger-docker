#!/bin/bash
set -e
source /pd_build/buildconfig

RVM_ID=$(basename "$0" | sed 's/.sh$//')

header "Installing $RVM_ID"
run /pd_build/ruby_support/prepare.sh
run /usr/local/rvm/bin/rvm install $RVM_ID || ( cat /usr/local/rvm/log/*${RVM_ID}*/*.log && false )
run /usr/local/rvm/bin/rvm-exec $RVM_ID@global gem install $DEFAULT_RUBY_GEMS --no-document
# Make passenger_system_ruby work.
run create_rvm_wrapper_script ruby3.1 $RVM_ID ruby
run /pd_build/ruby_support/install_ruby_utils.sh
run /pd_build/ruby_support/finalize.sh
