#!/bin/bash
set -e
source /build/buildconfig
set -x

apt-get install -y -t sid openjdk-8-jre-headless

curl https://s3.amazonaws.com/jruby.org/downloads/1.7.18/jruby-bin-1.7.18.tar.gz -o /tmp/jruby-bin-1.7.18.tar.gz
cd /usr/local
tar xzf /tmp/jruby-bin-1.7.18.tar.gz

# For convenience.
cd /usr/local/jruby-1.7.18/bin
ln -sf /usr/local/jruby-1.7.18/bin/jruby /usr/bin/ruby

# To keep the image smaller; these are only needed on Windows anyway.
rm -rf *.bat *.dll *.exe

echo "PATH=\"\$PATH:/usr/local/jruby-1.7.18/bin\"" >> /etc/environment
source /etc/environment

gem install rake bundler --no-rdoc --no-ri

echo "gem: --no-ri --no-rdoc" > /etc/gemrc

# This part is needed to get Debian dependencies working correctly, so that the nginx-passenger.sh script does not
# install Ruby 1.9 and/or other YARV Ruby versions (if all we want is JRuby).
cd /tmp
mkdir -p jruby-fake/DEBIAN
cat <<-EOF > jruby-fake/DEBIAN/control
Source: jruby-fake
Section: ruby
Priority: optional
Maintainer: Unmaintained <noreply@debian.org>
Build-Depends: debhelper (>= 9~), openjdk-7-jdk (>= 7u71-2.5.3), ant-optional,
 libasm3-java, libcommons-logging-java, libjarjar-java, libjoda-time-java,
 junit4, libbsf-java, libjline-java, bnd, libconstantine-java,
 netbase, libjgrapht0.8-java, libjcodings-java, libbytelist-java, libjffi-java,
 libjaffl-java, libjruby-joni-java, yydebug, nailgun, libjnr-posix-java,
 libjnr-netdb-java, libyecht-java (>= 0.0.2-2~), cdbs, maven-repo-helper
Standards-Version: 3.9.6
Homepage: http://jruby.org
Package: jruby-fake
Version: 1.7.18
Architecture: all
Replaces: jruby1.0, jruby1.1, jruby1.2
Provides: ruby-interpreter, rubygems1.9
Depends: default-jre | java6-runtime | java-runtime-headless
Recommends: ri
Description: 100% pure-Java implementation of Ruby (fake package)
 JRuby is a 100% pure-Java implementation of the Ruby programming language.
 .
 JRuby provides a complete set of core "builtin" classes and syntax
 for the Ruby language, as well as most of the Ruby Standard
 Libraries. The standard libraries are mostly Ruby's own complement of
 ".rb" files, but a few that depend on C language-based extensions have
 been reimplemented. Some are still missing, but JRuby hopes to
 implement as many as is feasible.
 .
 This is a fake package that does not contain any files; it exists just to
 satisfy dependencies.
EOF

dpkg-deb -b jruby-fake .
dpkg -i jruby-fake_1.7.18_all.deb
