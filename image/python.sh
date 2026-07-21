#!/bin/bash
set -e
source /pd_build/buildconfig

VERSION=${1:-3.14}

header "Installing Python ${VERSION}...."

## Install Python.
rm -f /usr/bin/python
if [[ ${VERSION} == "3.14" ]]; then
	# baseimage already has 3.14, so just install dev support
	minimal_apt_get_install python3-venv python3-dev
else
	# otherwise install the deadsnakes PPA and install from there
	apt_add_ppa ppa:deadsnakes/ppa
	minimal_apt_get_install "python${VERSION}" "python${VERSION}-dev" "python${VERSION}-venv"
fi
ln -s "/usr/bin/python${VERSION}" /usr/bin/python
