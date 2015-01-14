#!/bin/bash
set -e
source /build/buildconfig
set -x

apt-get install -y -t sid openjdk-8-jre-headless

curl https://s3.amazonaws.com/jruby.org/downloads/1.7.18/jruby-bin-1.7.18.tar.gz -o /tmp/jruby-bin-1.7.18.tar.gz
cd /usr/local
tar xzf /tmp/jruby-bin-1.7.18.tar.gz

# For convenience.
cd jruby-1.7.18/bin
ln -sf jruby ruby

# To keep the image smaller; these are only needed on Windows anyway.
rm -rf *.bat *.dll *.exe

echo "PATH=\"\$PATH:/usr/local/jruby-1.7.18/bin\"" >> /etc/environment
source /etc/environment

gem install rake bundler --no-rdoc --no-ri

echo "gem: --no-ri --no-rdoc" > /etc/gemrc
