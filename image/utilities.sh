#!/bin/bash
set -e
source /build/buildconfig
set -x

## Many Ruby gems and NPM packages contain native extensions and require a compiler.
$minimal_apt_get_install build-essential
## Bundler has to be able to pull dependencies from git.
$minimal_apt_get_install git
