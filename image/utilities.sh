#!/bin/bash
set -e
source /build/buildconfig
set -x

## Many Ruby gems and NPM packages contain native extensions and require a compiler.
$minimal_apt_get_install build-essential
## Bundler has to be able to pull dependencies from git.
$minimal_apt_get_install git

## Simple image bootstrapper.
pushd /tmp
curl -L -o pups.tar.gz https://github.com/SamSaffron/pups/archive/b9d203820620903c6990c1de044496658bfcb3ee.tar.gz
tar xzf pups.tar.gz
mv pups-* /usr/local/pups
rm -f pups.tar.gz
cat >/usr/local/bin/pups <<EOF
#!/bin/sh
if [[ -e /usr/bin/ruby2.0 ]]; then
	exec /usr/bin/ruby2.0 /usr/local/pups/bin/pups "\$@"
elsif [[ -e /usr/bin/ruby ]]; then
	# Maybe user removed Ruby 2.0. We'll want to use the
	# default Ruby interpreter.
	exec /usr/bin/ruby /usr/local/pups/bin/pups "\$@"
else
	# No default Ruby either. Maybe the user removed Ruby
	# completely or installed a custom one. This will use
	# the Ruby in PATH or throw an error if not found.
	exec ruby /usr/local/pups/bin/pups "\$@"
fi
EOF
chmod +x /usr/local/bin/pups
popd
