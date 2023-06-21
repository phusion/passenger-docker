#!/bin/bash
set -e
source /pd_build/buildconfig

RVM_ID=$(basename "$0" | sed 's/.sh$//')

run minimal_apt_get_install openjdk-17-jre-headless
run dpkg-reconfigure ca-certificates-java

header "Installing $RVM_ID"
run /pd_build/ruby_support/prepare.sh
run /usr/local/rvm/bin/rvm install $RVM_ID
run /usr/local/rvm/bin/rvm-exec $RVM_ID@global gem install $DEFAULT_RUBY_GEMS --no-document
run create_rvm_wrapper_script jruby9.3 $RVM_ID ruby
run create_rvm_wrapper_script jruby $RVM_ID ruby
# Make passenger_system_ruby work.
run create_rvm_wrapper_script ruby2.6 $RVM_ID ruby
run /pd_build/ruby_support/install_ruby_utils.sh
run /pd_build/ruby_support/finalize.sh
