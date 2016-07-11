#!/bin/bash
set -e
source /pd_build/buildconfig

RVM_ID=`basename "$0" | sed 's/.sh$//'`

header "Installing $RVM_ID"
run /pd_build/ruby_support/prepare.sh
run /usr/local/rvm/bin/rvm install $RVM_ID
run /usr/local/rvm/bin/rvm-exec $RVM_ID@global gem install rake bundler --no-document
run /usr/local/rvm/bin/rvm-exec $RVM_ID@global gem install rack -v 1.6.4 --no-document
# Make passenger_system_ruby work.
run create_rvm_wrapper_script ruby2.0 $RVM_ID ruby
run /pd_build/ruby_support/install_ruby_utils.sh
run /pd_build/ruby_support/finalize.sh
