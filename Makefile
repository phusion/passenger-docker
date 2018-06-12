NAME = phusion/passenger
VERSION = 0.9.33
# Extra flags for docker build, usable via environment variable.
# Example: `export EXTRA_BUILD_FLAGS=--no-cache; make build_all`
EXTRA_BUILD_FLAGS?=

.PHONY: all build_all \
	build_customizable \
	build_ruby20 build_ruby21 build_ruby22 build_ruby23 build_ruby24 build_ruby25 build_jruby91 \
	build_nodejs build_full \
	tag_latest release clean clean_images

all: build_all

build_all: \
	build_customizable \
	build_ruby20 \
	build_ruby21 \
	build_ruby22 \
	build_ruby23 \
	build_ruby24 \
	build_ruby25 \
	build_jruby91 \
	build_nodejs \
	build_full

# Docker doesn't support sharing files between different Dockerfiles. -_-
# So we copy things around.
build_customizable:
	rm -rf customizable_image
	cp -pR image customizable_image
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-customizable:$(VERSION) --rm customizable_image --no-cache

build_ruby20:
	rm -rf ruby20_image
	cp -pR image ruby20_image
	echo ruby20=1 >> ruby20_image/buildconfig
	echo final=1 >> ruby20_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby20:$(VERSION) --rm ruby20_image --no-cache

build_ruby21:
	rm -rf ruby21_image
	cp -pR image ruby21_image
	echo ruby21=1 >> ruby21_image/buildconfig
	echo final=1 >> ruby21_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby21:$(VERSION) --rm ruby21_image --no-cache

build_ruby22:
	rm -rf ruby22_image
	cp -pR image ruby22_image
	echo ruby22=1 >> ruby22_image/buildconfig
	echo final=1 >> ruby22_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby22:$(VERSION) --rm ruby22_image --no-cache

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

build_jruby91:
	rm -rf jruby91_image
	cp -pR image jruby91_image
	echo jruby91=1 >> jruby91_image/buildconfig
	echo final=1 >> jruby91_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-jruby91:$(VERSION) --rm jruby91_image --no-cache

build_nodejs:
	rm -rf nodejs_image
	cp -pR image nodejs_image
	echo nodejs=1 >> nodejs_image/buildconfig
	echo final=1 >> nodejs_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-nodejs:$(VERSION) --rm nodejs_image --no-cache

build_full:
	rm -rf full_image
	cp -pR image full_image
	echo ruby20=1 >> full_image/buildconfig
	echo ruby21=1 >> full_image/buildconfig
	echo ruby22=1 >> full_image/buildconfig
	echo ruby23=1 >> full_image/buildconfig
	echo ruby24=1 >> full_image/buildconfig
	echo ruby25=1 >> full_image/buildconfig
	echo jruby91=1 >> full_image/buildconfig
	echo python=1 >> full_image/buildconfig
	echo nodejs=1 >> full_image/buildconfig
	echo redis=1 >> full_image/buildconfig
	echo memcached=1 >> full_image/buildconfig
	echo final=1 >> full_image/buildconfig
	docker build $(EXTRA_BUILD_FLAGS) -t $(NAME)-full:$(VERSION) --rm full_image --no-cache

tag_latest:
	docker tag $(NAME)-customizable:$(VERSION) $(NAME)-customizable:latest
	docker tag $(NAME)-ruby20:$(VERSION) $(NAME)-ruby20:latest
	docker tag $(NAME)-ruby21:$(VERSION) $(NAME)-ruby21:latest
	docker tag $(NAME)-ruby22:$(VERSION) $(NAME)-ruby22:latest
	docker tag $(NAME)-ruby23:$(VERSION) $(NAME)-ruby23:latest
	docker tag $(NAME)-ruby24:$(VERSION) $(NAME)-ruby24:latest
	docker tag $(NAME)-ruby25:$(VERSION) $(NAME)-ruby25:latest
	docker tag $(NAME)-jruby91:$(VERSION) $(NAME)-jruby91:latest
	docker tag $(NAME)-nodejs:$(VERSION) $(NAME)-nodejs:latest
	docker tag $(NAME)-full:$(VERSION) $(NAME)-full:latest

release: tag_latest
	@if ! docker images $(NAME)-customizable | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-customizable version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby20 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby20 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby21 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby21 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby22 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby22 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby23 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby23 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby24 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby24 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby25 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-ruby25 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-jruby91 | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-jruby91 version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-nodejs | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-nodejs version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-full | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-full version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)-customizable:latest
	docker push $(NAME)-customizable:$(VERSION)
	docker push $(NAME)-ruby20:latest
	docker push $(NAME)-ruby20:$(VERSION)
	docker push $(NAME)-ruby21:latest
	docker push $(NAME)-ruby21:$(VERSION)
	docker push $(NAME)-ruby22:latest
	docker push $(NAME)-ruby22:$(VERSION)
	docker push $(NAME)-ruby23:latest
	docker push $(NAME)-ruby23:$(VERSION)
	docker push $(NAME)-ruby24:latest
	docker push $(NAME)-ruby24:$(VERSION)
	docker push $(NAME)-ruby25:latest
	docker push $(NAME)-ruby25:$(VERSION)
	docker push $(NAME)-jruby91:latest
	docker push $(NAME)-jruby91:$(VERSION)
	docker push $(NAME)-nodejs:latest
	docker push $(NAME)-nodejs:$(VERSION)
	docker push $(NAME)-full:latest
	docker push $(NAME)-full:$(VERSION)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

clean:
	rm -rf customizable_image
	rm -rf ruby20_image
	rm -rf ruby21_image
	rm -rf ruby22_image
	rm -rf ruby23_image
	rm -rf ruby24_image
	rm -rf ruby25_image
	rm -rf jruby91_image
	rm -rf nodejs_image
	rm -rf full_image

clean_images:
	docker rmi $(NAME)-customizable:latest $(NAME)-customizable:$(VERSION) || true
	docker rmi $(NAME)-ruby20:latest $(NAME)-ruby20:$(VERSION) || true
	docker rmi $(NAME)-ruby21:latest $(NAME)-ruby21:$(VERSION) || true
	docker rmi $(NAME)-ruby22:latest $(NAME)-ruby22:$(VERSION) || true
	docker rmi $(NAME)-ruby23:latest $(NAME)-ruby23:$(VERSION) || true
	docker rmi $(NAME)-ruby24:latest $(NAME)-ruby24:$(VERSION) || true
	docker rmi $(NAME)-ruby25:latest $(NAME)-ruby25:$(VERSION) || true
	docker rmi $(NAME)-jruby91:latest $(NAME)-jruby91:$(VERSION) || true
	docker rmi $(NAME)-nodejs:latest $(NAME)-nodejs:$(VERSION) || true
	docker rmi $(NAME)-full:latest $(NAME)-full:$(VERSION) || true
