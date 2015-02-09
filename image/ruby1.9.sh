#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

minimal_apt_get_install ruby1.9.1 ruby1.9.1-dev
update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.1 161
update-alternatives \
	--install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 31 \
	--slave /usr/bin/erb erb /usr/bin/erb1.9.1 \
	--slave /usr/bin/testrb testrb /usr/bin/testrb1.9.1 \
	--slave /usr/bin/rake rake /usr/bin/rake1.9.1 \
	--slave /usr/bin/irb irb /usr/bin/irb1.9.1 \
	--slave /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1 \
	--slave /usr/bin/ri ri /usr/bin/ri1.9.1 \
	--slave /usr/share/man/man1/ruby.1.gz ruby.1.gz /usr/share/man/man1/ruby1.9.*.gz \
	--slave /usr/share/man/man1/erb.1.gz erb.1.gz /usr/share/man/man1/erb1.9.*.gz \
	--slave /usr/share/man/man1/irb.1.gz irb.1.gz /usr/share/man/man1/irb1.9.*.gz \
	--slave /usr/share/man/man1/rake.1.gz rake.1.gz /usr/share/man/man1/rake1.9.*.gz \
	--slave /usr/share/man/man1/ri.1.gz ri.1.gz /usr/share/man/man1/ri1.9.*.gz
gem1.9.1 install rake bundler --no-rdoc --no-ri
/pd_build/ruby-finalize.sh
