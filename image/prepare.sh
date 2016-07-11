#!/bin/bash
set -e
source /pd_build/buildconfig

header "Performing miscellaneous preparation"

## Ensure that docs and non-English locales are not installed.
run cp /pd_build/config/dpkg-nodocs.conf /etc/dpkg/dpkg.cfg.d/01_nodoc
run cp /pd_build/config/dpkg-only-english-locale.conf /etc/dpkg/dpkg.cfg.d/01_only_english_locale

## Create a user for the web app.
run addgroup --gid 9999 app
run adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
run usermod -L app
run mkdir -p /home/app/.ssh
run chmod 700 /home/app/.ssh
run chown app:app /home/app/.ssh
