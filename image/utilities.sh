#!/bin/bash
set -e
source /pd_build/buildconfig

## Many Ruby gems and NPM packages contain native extensions and require a compiler.
run minimal_apt_get_install build-essential
## Bundler has to be able to pull dependencies from git.
run minimal_apt_get_install git
