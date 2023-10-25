#!/bin/bash
set -e
source /pd_build/buildconfig

VERSION=${1:-3.10}

header "Installing Python ${VERSION}...."

## Install Python.
rm -f /usr/bin/python
if [[ ${VERSION} == "2.7" ]]; then
	# Jammy still builds 2.7, so install from normal repo
	minimal_apt_get_install python2.7 python2.7-dev
elif [[ ${VERSION} == "3.10" ]]; then
	# baseimage already has 3.10, so just install dev support
	minimal_apt_get_install python3-venv python3-dev
else
	# otherwise install the deadsnakes PPA and install from there
	apt_add_ppa ppa:deadsnakes/ppa
	minimal_apt_get_install "python${VERSION}" "python${VERSION}-dev" "python${VERSION}-venv"
fi
ln -s "/usr/bin/python${VERSION}" /usr/bin/python
