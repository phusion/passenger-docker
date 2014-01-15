#!/bin/bash
set -e
source /build/buildconfig
set -x

$minimal_apt_get_install mercurial bison
update-ca-certificates --fresh
bash < <(curl -s https://raw.github.com/moovweb/gvm/master/binscripts/gvm-installer)
source /root/.gvm/scripts/gvm
gvm install go1.2rc5
gvm use go1.2rc5
gvm pkgset create dev

cat <<EOF >> /root/.bashrc
gvm use go1.2rc5 >/dev/null
gvm pkgset use dev >/dev/null
EOF
