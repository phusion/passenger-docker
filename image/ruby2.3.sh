#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

minimal_apt_get_install ruby2.3 ruby2.3-dev
update-alternatives --install /usr/bin/gem gem /usr/bin/gem2.3 191
update-alternatives \
	--install /usr/bin/ruby ruby /usr/bin/ruby2.3 61 \
	--slave /usr/bin/erb erb /usr/bin/erb2.3 \
	--slave /usr/bin/testrb testrb /usr/bin/testrb2.3 \
	--slave /usr/bin/rake rake /usr/bin/rake2.3 \
	--slave /usr/bin/irb irb /usr/bin/irb2.3 \
	--slave /usr/bin/rdoc rdoc /usr/bin/rdoc2.3 \
	--slave /usr/bin/ri ri /usr/bin/ri2.3 \
	--slave /usr/share/man/man1/ruby.1.gz ruby.1.gz /usr/share/man/man1/ruby2.3.*.gz \
	--slave /usr/share/man/man1/erb.1.gz erb.1.gz /usr/share/man/man1/erb2.3.*.gz \
	--slave /usr/share/man/man1/irb.1.gz irb.1.gz /usr/share/man/man1/irb2.3.*.gz \
	--slave /usr/share/man/man1/rake.1.gz rake.1.gz /usr/share/man/man1/rake2.3.*.gz \
	--slave /usr/share/man/man1/ri.1.gz ri.1.gz /usr/share/man/man1/ri2.3.*.gz
gem2.3 install rake bundler --no-rdoc --no-ri
/pd_build/ruby-finalize.sh
