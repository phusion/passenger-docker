#!/bin/bash
set -e
source /build/configuration
set -x

## Many Ruby gems and NPM packages contain native extensions and require a compiler.
apt-get install -y --no-install-recommends build-essential
## Bundler has to be able to pull dependencies from git.
apt-get install -y git
## Other often used tools.
apt-get install -y curl less nano vim
