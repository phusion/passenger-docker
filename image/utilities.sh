#!/bin/bash
set -e
source /pd_build/buildconfig

## Many Ruby gems and NPM packages contain native extensions and require a compiler.
run minimal_apt_get_install build-essential
## Bundler has to be able to pull dependencies from git.
run minimal_apt_get_install git
## JRuby94 at least requires netbase, and other client stuff must.
run minimal_apt_get_install netbase
## almost everyone needs file, and it sort of randomly gets pulled in during
## the build process anyway
run minimal_apt_get_install file
# install packages needed for ruby builds
run minimal_apt_get_install gawk autoconf automake bison libffi-dev libgdbm-dev libsqlite3-dev libtool libyaml-dev pkg-config sqlite3 zlib1g-dev libgmp-dev libreadline-dev libssl-dev
