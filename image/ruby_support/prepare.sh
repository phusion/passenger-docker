#!/bin/bash
set -e
source /pd_build/buildconfig

if [[ -e /tmp/ruby_prepared ]]; then
	exit
fi

echo "+ Updating /etc/gemrc"
echo "gem: --no-document" > /etc/gemrc

## Install RVM.
export HOME=/root
run gpg --import /pd_build/ruby_support/mpapis-pubkey.asc
run gpg --import /pd_build/ruby_support/pkuczynski-pubkey.asc
run bash /pd_build/ruby_support/rvm-install.sh stable
echo "+ Updating /etc/profile.d/rvm_secure_path.sh"
echo export rvmsudo_secure_path=1 > /etc/profile.d/rvm_secure_path.sh
echo export rvm_silence_path_mismatch_check_flag=1 >> /etc/profile.d/rvm_silence_path_warning.sh
run chmod +x /etc/profile.d/rvm_secure_path.sh
run chmod +x /etc/profile.d/rvm_silence_path_warning.sh
run usermod -a -G rvm app

# Note: we cannot install an 'rvm' script to /usr/bin because
# then RVM will try to remove /usr/bin from PATH.
run install -o root /pd_build/ruby_support/system-rvm-exec.sh /usr/bin/rvm-exec

# Ensure bash always loads the RVM environment.
echo 'if [[ "$rvm_prefix" = "" ]]; then source /etc/profile.d/*rvm*; fi' >> /etc/bash.bashrc

## Install fake DPKG entry so that Passenger doesn't install Ruby from APT.
echo "+ In /tmp:"
cd /tmp
run mkdir -p ruby-fake/DEBIAN
run cp /pd_build/ruby_support/dpkg-control ruby-fake/DEBIAN/control
run dpkg-deb -b ruby-fake .
run dpkg -i ruby-fake_1.0.0_all.deb

## Ensure that this script isn't run more than once.
touch /tmp/ruby_prepared
