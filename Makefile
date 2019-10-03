NAME = phusion/passenger
VERSION = 1.0.8
# Extra flags for docker build, usable via environment variable.
# Example: `export EXTRA_BUILD_FLAGS=--no-cache; make build_all`
EXTRA_BUILD_FLAGS?=

.PHONY: all release clean clean_images

all: build_all

build_all: \
	build_customizable \
	build_ruby23 \
	build_ruby24 \
	build_ruby25 \
	build_ruby26 \
	build_jruby92 \
	build_nodejs \
	build_full

# Docker doesn't support sharing files between different Dockerfiles. -_-
# So we copy things around.
build_customizable:
	rm -rf customizable_image
	cp -pR image customizable_image
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-customizable:$(VERSION) --rm customizable_image --no-cache

build_ruby23:
	rm -rf ruby23_image
	cp -pR image ruby23_image
	echo ruby23=1 >> ruby23_image/buildconfig
	echo final=1 >> ruby23_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby23:$(VERSION) --rm ruby23_image --no-cache

build_ruby24:
	rm -rf ruby24_image
	cp -pR image ruby24_image
	echo ruby24=1 >> ruby24_image/buildconfig
	echo final=1 >> ruby24_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby24:$(VERSION) --rm ruby24_image --no-cache

build_ruby25:
	rm -rf ruby25_image
	cp -pR image ruby25_image
	echo ruby25=1 >> ruby25_image/buildconfig
	echo final=1 >> ruby25_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby25:$(VERSION) --rm ruby25_image --no-cache

build_ruby26:
	rm -rf ruby26_image
	cp -pR image ruby26_image
	echo ruby26=1 >> ruby26_image/buildconfig
	echo final=1 >> ruby26_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby26:$(VERSION) --rm ruby26_image --no-cache

build_jruby92:
	rm -rf jruby92_image
	cp -pR image jruby92_image
	echo jruby92=1 >> jruby92_image/buildconfig
	echo final=1 >> jruby92_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-jruby92:$(VERSION) --rm jruby92_image --no-cache

build_nodejs:
	rm -rf nodejs_image
	cp -pR image nodejs_image
	echo nodejs=1 >> nodejs_image/buildconfig
	echo final=1 >> nodejs_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-nodejs:$(VERSION) --rm nodejs_image --no-cache

build_full:
	rm -rf full_image
	cp -pR image full_image
	echo ruby23=1 >> full_image/buildconfig
	echo ruby24=1 >> full_image/buildconfig
	echo ruby25=1 >> full_image/buildconfig
	echo ruby26=1 >> full_image/buildconfig
	echo jruby92=1 >> full_image/buildconfig
	echo python=1 >> full_image/buildconfig
	echo nodejs=1 >> full_image/buildconfig
	echo redis=1 >> full_image/buildconfig
	echo memcached=1 >> full_image/buildconfig
	echo final=1 >> full_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-full:$(VERSION) --rm full_image --no-cache

tag_latest:
	docker tag $(NAME)-customizable:$(VERSION) $(NAME)-customizable:latest
	docker tag $(NAME)-ruby23:$(VERSION) $(NAME)-ruby23:latest
	docker tag $(NAME)-ruby24:$(VERSION) $(NAME)-ruby24:latest
	docker tag $(NAME)-ruby25:$(VERSION) $(NAME)-ruby25:latest
	docker tag $(NAME)-ruby26:$(VERSION) $(NAME)-ruby26:latest
	docker tag $(NAME)-jruby92:$(VERSION) $(NAME)-jruby92:latest
	docker tag $(NAME)-nodejs:$(VERSION) $(NAME)-nodejs:latest
	docker tag $(NAME)-full:$(VERSION) $(NAME)-full:latest

release: tag_latest
	@if ! docker images $(NAME)-customizable | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-customizable version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby23 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby23 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby24 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby24 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby25 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby25 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby26 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby26 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-jruby92 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-jruby92 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-nodejs | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-nodejs version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-full | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-full version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)-customizable:latest
	docker push $(NAME)-customizable:$(VERSION)
	docker push $(NAME)-ruby23:latest
	docker push $(NAME)-ruby23:$(VERSION)
	docker push $(NAME)-ruby24:latest
	docker push $(NAME)-ruby24:$(VERSION)
	docker push $(NAME)-ruby25:latest
	docker push $(NAME)-ruby25:$(VERSION)
	docker push $(NAME)-ruby26:latest
	docker push $(NAME)-ruby26:$(VERSION)
	docker push $(NAME)-jruby92:latest
	docker push $(NAME)-jruby92:$(VERSION)
	docker push $(NAME)-nodejs:latest
	docker push $(NAME)-nodejs:$(VERSION)
	docker push $(NAME)-full:latest
	docker push $(NAME)-full:$(VERSION)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

clean:
	rm -rf customizable_image
	rm -rf ruby23_image
	rm -rf ruby24_image
	rm -rf ruby25_image
	rm -rf ruby26_image
	rm -rf jruby92_image
	rm -rf nodejs_image
	rm -rf full_image

clean_images:
	docker rmi $(NAME)-customizable:latest $(NAME)-customizable:$(VERSION) || true
	docker rmi $(NAME)-ruby23:latest $(NAME)-ruby23:$(VERSION) || true
	docker rmi $(NAME)-ruby24:latest $(NAME)-ruby24:$(VERSION) || true
	docker rmi $(NAME)-ruby25:latest $(NAME)-ruby25:$(VERSION) || true
	docker rmi $(NAME)-ruby26:latest $(NAME)-ruby26:$(VERSION) || true
	docker rmi $(NAME)-jruby92:latest $(NAME)-jruby92:$(VERSION) || true
	docker rmi $(NAME)-nodejs:latest $(NAME)-nodejs:$(VERSION) || true
	docker rmi $(NAME)-full:latest $(NAME)-full:$(VERSION) || true
