#!/bin/bash
set -e
source /build/configuration
set -x

apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /build
