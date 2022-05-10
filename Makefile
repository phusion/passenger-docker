NAME = phusion/passenger
VERSION = 2.3.0
# Extra flags for docker build, usable via environment variable.
# Example: `export EXTRA_BUILD_FLAGS=--no-cache; make build_all`
EXTRA_BUILD_FLAGS?=

.PHONY: all release clean clean_images

all: build_all

build_all: \
	build_customizable \
	build_ruby26 \
	build_ruby27 \
	build_ruby30 \
	build_ruby31 \
	build_jruby93 \
	build_nodejs \
	build_full

# Docker doesn't support sharing files between different Dockerfiles. -_-
# So we copy things around.
build_customizable:
	rm -rf customizable_image
	cp -pR image customizable_image
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-customizable:$(VERSION) --rm customizable_image --no-cache

build_ruby26:
	rm -rf ruby26_image
	cp -pR image ruby26_image
	echo ruby26=1 >> ruby26_image/buildconfig
	echo final=1 >> ruby26_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby26:$(VERSION) --rm ruby26_image --no-cache

build_ruby27:
	rm -rf ruby27_image
	cp -pR image ruby27_image
	echo ruby27=1 >> ruby27_image/buildconfig
	echo final=1 >> ruby27_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby27:$(VERSION) --rm ruby27_image --no-cache

build_ruby30:
	rm -rf ruby30_image
	cp -pR image ruby30_image
	echo ruby30=1 >> ruby30_image/buildconfig
	echo final=1 >> ruby30_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby30:$(VERSION) --rm ruby30_image --no-cache

build_ruby31:
	rm -rf ruby31_image
	cp -pR image ruby31_image
	echo ruby31=1 >> ruby31_image/buildconfig
	echo final=1 >> ruby31_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby31:$(VERSION) --rm ruby31_image --no-cache

build_jruby93:
	rm -rf jruby93_image
	cp -pR image jruby93_image
	echo jruby93=1 >> jruby93_image/buildconfig
	echo final=1 >> jruby93_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-jruby93:$(VERSION) --rm jruby93_image --no-cache

build_nodejs:
	rm -rf nodejs_image
	cp -pR image nodejs_image
	echo nodejs=1 >> nodejs_image/buildconfig
	echo final=1 >> nodejs_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-nodejs:$(VERSION) --rm nodejs_image --no-cache

build_full:
	rm -rf full_image
	cp -pR image full_image
	echo ruby26=1 >> full_image/buildconfig
	echo ruby27=1 >> full_image/buildconfig
	echo ruby30=1 >> full_image/buildconfig
	echo ruby31=1 >> full_image/buildconfig
	echo jruby93=1 >> full_image/buildconfig
	echo python=1 >> full_image/buildconfig
	echo nodejs=1 >> full_image/buildconfig
	echo redis=1 >> full_image/buildconfig
	echo memcached=1 >> full_image/buildconfig
	echo final=1 >> full_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-full:$(VERSION) --rm full_image --no-cache

tag_latest:
	docker tag $(NAME)-customizable:$(VERSION) $(NAME)-customizable:latest
	docker tag $(NAME)-ruby26:$(VERSION) $(NAME)-ruby26:latest
	docker tag $(NAME)-ruby27:$(VERSION) $(NAME)-ruby27:latest
	docker tag $(NAME)-ruby30:$(VERSION) $(NAME)-ruby30:latest
	docker tag $(NAME)-ruby31:$(VERSION) $(NAME)-ruby31:latest
	docker tag $(NAME)-jruby93:$(VERSION) $(NAME)-jruby93:latest
	docker tag $(NAME)-nodejs:$(VERSION) $(NAME)-nodejs:latest
	docker tag $(NAME)-full:$(VERSION) $(NAME)-full:latest

release: tag_latest
	@if ! docker images $(NAME)-customizable | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-customizable version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby26 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby26 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby27 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby27 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby30 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby30 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby31 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby31 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-jruby93 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-jruby93 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-nodejs | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-nodejs version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-full | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-full version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)-customizable:latest
	docker push $(NAME)-customizable:$(VERSION)
	docker push $(NAME)-ruby26:latest
	docker push $(NAME)-ruby26:$(VERSION)
	docker push $(NAME)-ruby27:latest
	docker push $(NAME)-ruby27:$(VERSION)
	docker push $(NAME)-ruby30:latest
	docker push $(NAME)-ruby30:$(VERSION)
	docker push $(NAME)-ruby31:latest
	docker push $(NAME)-ruby31:$(VERSION)
	docker push $(NAME)-jruby93:latest
	docker push $(NAME)-jruby93:$(VERSION)
	docker push $(NAME)-nodejs:latest
	docker push $(NAME)-nodejs:$(VERSION)
	docker push $(NAME)-full:latest
	docker push $(NAME)-full:$(VERSION)
	test -z "$(git status --porcelain)" || git commit -am "$(VERSION)"
	git tag "rel-$(VERSION)"
	git push origin "rel-$(VERSION)"

clean:
	rm -rf customizable_image
	rm -rf ruby26_image
	rm -rf ruby27_image
	rm -rf ruby30_image
	rm -rf ruby31_image
	rm -rf jruby93_image
	rm -rf nodejs_image
	rm -rf full_image

clean_images:
	docker rmi $(NAME)-customizable:latest $(NAME)-customizable:$(VERSION) || true
	docker rmi $(NAME)-ruby26:latest $(NAME)-ruby26:$(VERSION) || true
	docker rmi $(NAME)-ruby27:latest $(NAME)-ruby27:$(VERSION) || true
	docker rmi $(NAME)-ruby30:latest $(NAME)-ruby30:$(VERSION) || true
	docker rmi $(NAME)-ruby31:latest $(NAME)-ruby31:$(VERSION) || true
	docker rmi $(NAME)-jruby93:latest $(NAME)-jruby93:$(VERSION) || true
	docker rmi $(NAME)-nodejs:latest $(NAME)-nodejs:$(VERSION) || true
	docker rmi $(NAME)-full:latest $(NAME)-full:$(VERSION) || true
