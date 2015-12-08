#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

JRUBY_VERSION=9.0.4.0
JRUBY_MAJOR_MINOR=9.0

minimal_apt_get_install openjdk-8-jre-headless
dpkg-reconfigure ca-certificates-java

# Original URL:
# https://s3.amazonaws.com/jruby.org/downloads/$JRUBY_VERSION/jruby-bin-$JRUBY_VERSION.tar.gz
# We use a mirror at oss-binaries.phusionpassenger.com because it's faster from the Netherlands.
curl --fail -L \
	https://oss-binaries.phusionpassenger.com/jruby/jruby-bin-$JRUBY_VERSION.tar.gz \
	-o /tmp/jruby-bin-$JRUBY_VERSION.tar.gz
cd /usr/local
tar xzf /tmp/jruby-bin-$JRUBY_VERSION.tar.gz
mv jruby-$JRUBY_VERSION jruby-$JRUBY_MAJOR_MINOR

cd /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin
# To keep the image smaller; these are only needed on Windows anyway.
rm -f *.bat *.dll *.exe
# Remove other redundant files
rm -f jruby.bash jruby.sh

cd /
sed -i "s|/usr/bin/env jruby|/usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jruby|" /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/*

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
Version: $JRUBY_VERSION
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
dpkg -i jruby-fake_${JRUBY_VERSION}_all.deb

ln -s /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jruby /usr/bin/jruby
ln -s /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jruby /usr/bin/jruby$JRUBY_MAJOR_MINOR
ln -s /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jgem /usr/bin/jgem
ln -s /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jgem /usr/bin/jgem$JRUBY_MAJOR_MINOR
ln -s /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jirb /usr/bin/jirb
ln -s /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jirb /usr/bin/jirb$JRUBY_MAJOR_MINOR
ln -s /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jrake /usr/bin/jrake
ln -s /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jrake /usr/bin/jrake$JRUBY_MAJOR_MINOR
update-alternatives --install /usr/bin/gem gem /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jgem 151
update-alternatives \
	--install /usr/bin/ruby ruby /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jruby 21 \
	--slave /usr/bin/testrb testrb /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/testrb \
	--slave /usr/bin/rake rake /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/rake \
	--slave /usr/bin/irb irb /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/jirb \
	--slave /usr/bin/rdoc rdoc /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/rdoc \
	--slave /usr/bin/ri ri /usr/local/jruby-$JRUBY_MAJOR_MINOR/bin/ri
jgem$JRUBY_MAJOR_MINOR install rake bundler --no-rdoc --no-ri --bindir /usr/local/bin
/pd_build/ruby-finalize.sh
