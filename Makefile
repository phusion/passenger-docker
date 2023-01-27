NAME = phusion/passenger
VERSION = 2.5.0
# Extra flags for docker build, usable via environment variable.
# Example: `export EXTRA_BUILD_FLAGS=--no-cache; make build_all`
EXTRA_BUILD_FLAGS?=

.PHONY: all build_all release clean clean_images labels tag_latest push build_customizable build_ruby27 build_ruby30 build_ruby31 build_ruby32 build_jruby93 build_jruby94 build_nodejs build_full

all: build_all

build_all: \
	build_customizable \
	build_ruby27 \
	build_ruby30 \
	build_ruby31 \
	build_ruby32 \
	build_jruby93 \
	build_jruby94 \
	build_nodejs \
	build_full

labels:
	@echo $(NAME)-customizable:$(VERSION)-amd64 $(NAME)-customizable:latest-amd64
	@echo $(NAME)-customizable:$(VERSION)-arm64 $(NAME)-customizable:latest-arm64
	@echo $(NAME)-ruby27:$(VERSION)-amd64 $(NAME)-ruby27:latest-amd64
	@echo $(NAME)-ruby27:$(VERSION)-arm64 $(NAME)-ruby27:latest-arm64
	@echo $(NAME)-ruby30:$(VERSION)-amd64 $(NAME)-ruby30:latest-amd64
	@echo $(NAME)-ruby30:$(VERSION)-arm64 $(NAME)-ruby30:latest-arm64
	@echo $(NAME)-ruby31:$(VERSION)-amd64 $(NAME)-ruby31:latest-amd64
	@echo $(NAME)-ruby31:$(VERSION)-arm64 $(NAME)-ruby31:latest-arm64
	@echo $(NAME)-ruby32:$(VERSION)-amd64 $(NAME)-ruby32:latest-amd64
	@echo $(NAME)-ruby32:$(VERSION)-arm64 $(NAME)-ruby32:latest-arm64
	@echo $(NAME)-jruby93:$(VERSION)-amd64 $(NAME)-jruby93:latest-amd64
	@echo $(NAME)-jruby93:$(VERSION)-arm64 $(NAME)-jruby93:latest-arm64
	@echo $(NAME)-jruby94:$(VERSION)-amd64 $(NAME)-jruby94:latest-amd64
	@echo $(NAME)-jruby94:$(VERSION)-arm64 $(NAME)-jruby94:latest-arm64
	@echo $(NAME)-nodejs:$(VERSION)-amd64 $(NAME)-nodejs:latest-amd64
	@echo $(NAME)-nodejs:$(VERSION)-arm64 $(NAME)-nodejs:latest-arm64
	@echo $(NAME)-full:$(VERSION)-amd64 $(NAME)-full:latest-amd64
	@echo $(NAME)-full:$(VERSION)-arm64 $(NAME)-full:latest-arm64

# Docker doesn't support sharing files between different Dockerfiles. -_-
# So we copy things around.
build_customizable:
	rm -rf customizable_image
	cp -pR image customizable_image
	docker buildx build --progress=plain --platform linux/amd64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-customizable:$(VERSION)-amd64 --rm customizable_image --no-cache
	docker buildx build --progress=plain --platform linux/arm64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-customizable:$(VERSION)-arm64 --rm customizable_image --no-cache

build_ruby27:
	rm -rf ruby27_image
	cp -pR image ruby27_image
	echo ruby27=1 >> ruby27_image/buildconfig
	echo final=1 >> ruby27_image/buildconfig
	docker buildx build --progress=plain --platform linux/amd64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby27:$(VERSION)-amd64 --rm ruby27_image --no-cache
	docker buildx build --progress=plain --platform linux/arm64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby27:$(VERSION)-arm64 --rm ruby27_image --no-cache

build_ruby30:
	rm -rf ruby30_image
	cp -pR image ruby30_image
	echo ruby30=1 >> ruby30_image/buildconfig
	echo final=1 >> ruby30_image/buildconfig
	docker buildx build --progress=plain --platform linux/amd64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby30:$(VERSION)-amd64 --rm ruby30_image --no-cache
	docker buildx build --progress=plain --platform linux/arm64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby30:$(VERSION)-arm64 --rm ruby30_image --no-cache

build_ruby31:
	rm -rf ruby31_image
	cp -pR image ruby31_image
	echo ruby31=1 >> ruby31_image/buildconfig
	echo final=1 >> ruby31_image/buildconfig
	docker buildx build --progress=plain --platform linux/amd64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby31:$(VERSION)-amd64 --rm ruby31_image --no-cache
	docker buildx build --progress=plain --platform linux/arm64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby31:$(VERSION)-arm64 --rm ruby31_image --no-cache

build_ruby32:
	rm -rf ruby32_image
	cp -pR image ruby32_image
	echo ruby32=1 >> ruby32_image/buildconfig
	echo final=1 >> ruby32_image/buildconfig
	docker buildx build --progress=plain --platform linux/amd64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby32:$(VERSION)-amd64 --rm ruby32_image --no-cache
	docker buildx build --progress=plain --platform linux/arm64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-ruby32:$(VERSION)-arm64 --rm ruby32_image --no-cache

build_jruby93:
	rm -rf jruby93_image
	cp -pR image jruby93_image
	echo jruby93=1 >> jruby93_image/buildconfig
	echo final=1 >> jruby93_image/buildconfig
	docker buildx build --progress=plain --platform linux/amd64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-jruby93:$(VERSION)-amd64 --rm jruby93_image --no-cache
	docker buildx build --progress=plain --platform linux/arm64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-jruby93:$(VERSION)-arm64 --rm jruby93_image --no-cache

build_jruby94:
	rm -rf jruby94_image
	cp -pR image jruby94_image
	echo jruby94=1 >> jruby94_image/buildconfig
	echo final=1 >> jruby94_image/buildconfig
	docker buildx build --progress=plain --platform linux/amd64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-jruby94:$(VERSION)-amd64 --rm jruby94_image --no-cache
	docker buildx build --progress=plain --platform linux/arm64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-jruby94:$(VERSION)-arm64 --rm jruby94_image --no-cache

build_nodejs:
	rm -rf nodejs_image
	cp -pR image nodejs_image
	echo nodejs=1 >> nodejs_image/buildconfig
	echo final=1 >> nodejs_image/buildconfig
	docker buildx build --progress=plain --platform linux/amd64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-nodejs:$(VERSION)-amd64 --rm nodejs_image --no-cache
	docker buildx build --progress=plain --platform linux/arm64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-nodejs:$(VERSION)-arm64 --rm nodejs_image --no-cache

build_full:
	rm -rf full_image
	cp -pR image full_image
	echo ruby27=1 >> full_image/buildconfig
	echo ruby30=1 >> full_image/buildconfig
	echo ruby31=1 >> full_image/buildconfig
	echo ruby32=1 >> full_image/buildconfig
	echo jruby93=1 >> full_image/buildconfig
	echo jruby94=1 >> full_image/buildconfig
	echo python=1 >> full_image/buildconfig
	echo nodejs=1 >> full_image/buildconfig
	echo redis=1 >> full_image/buildconfig
	echo memcached=1 >> full_image/buildconfig
	echo final=1 >> full_image/buildconfig
	docker buildx build  --platform linux/amd64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-full:$(VERSION)-amd64 --rm full_image --no-cache
	docker buildx build  --platform linux/arm64 $(EXTRA_BUILD_FLAGS) -t $(NAME)-full:$(VERSION)-arm64 --rm full_image --no-cache

tag_latest:
	@if ! docker images $(NAME)-customizable | awk '{ print $$2 }' | grep -q -F $(VERSION)-amd64; then echo "$(NAME)-customizable version $(VERSION)-amd64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-customizable | awk '{ print $$2 }' | grep -q -F $(VERSION)-arm64; then echo "$(NAME)-customizable version $(VERSION)-arm64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby27 | awk '{ print $$2 }' | grep -q -F $(VERSION)-amd64; then echo "$(NAME)-ruby27 version $(VERSION)-amd64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby27 | awk '{ print $$2 }' | grep -q -F $(VERSION)-arm64; then echo "$(NAME)-ruby27 version $(VERSION)-arm64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby30 | awk '{ print $$2 }' | grep -q -F $(VERSION)-amd64; then echo "$(NAME)-ruby30 version $(VERSION)-amd64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby30 | awk '{ print $$2 }' | grep -q -F $(VERSION)-arm64; then echo "$(NAME)-ruby30 version $(VERSION)-arm64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby31 | awk '{ print $$2 }' | grep -q -F $(VERSION)-amd64; then echo "$(NAME)-ruby31 version $(VERSION)-amd64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby31 | awk '{ print $$2 }' | grep -q -F $(VERSION)-arm64; then echo "$(NAME)-ruby31 version $(VERSION)-arm64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby32 | awk '{ print $$2 }' | grep -q -F $(VERSION)-amd64; then echo "$(NAME)-ruby32 version $(VERSION)-amd64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-ruby32 | awk '{ print $$2 }' | grep -q -F $(VERSION)-arm64; then echo "$(NAME)-ruby32 version $(VERSION)-arm64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-jruby93 | awk '{ print $$2 }' | grep -q -F $(VERSION)-amd64; then echo "$(NAME)-jruby93 version $(VERSION)-amd64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-jruby93 | awk '{ print $$2 }' | grep -q -F $(VERSION)-arm64; then echo "$(NAME)-jruby93 version $(VERSION)-arm64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-jruby94 | awk '{ print $$2 }' | grep -q -F $(VERSION)-amd64; then echo "$(NAME)-jruby94 version $(VERSION)-amd64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-jruby94 | awk '{ print $$2 }' | grep -q -F $(VERSION)-arm64; then echo "$(NAME)-jruby94 version $(VERSION)-arm64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-nodejs | awk '{ print $$2 }' | grep -q -F $(VERSION)-amd64; then echo "$(NAME)-nodejs version $(VERSION)-amd64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-nodejs | awk '{ print $$2 }' | grep -q -F $(VERSION)-arm64; then echo "$(NAME)-nodejs version $(VERSION)-arm64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-full | awk '{ print $$2 }' | grep -q -F $(VERSION)-amd64; then echo "$(NAME)-full version $(VERSION)-amd64 is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-full | awk '{ print $$2 }' | grep -q -F $(VERSION)-arm64; then echo "$(NAME)-full version $(VERSION)-arm64 is not yet built. Please run 'make build'"; false; fi
	docker tag $(NAME)-customizable:$(VERSION)-amd64 $(NAME)-customizable:latest-amd64
	docker tag $(NAME)-customizable:$(VERSION)-arm64 $(NAME)-customizable:latest-arm64
	docker tag $(NAME)-ruby27:$(VERSION)-amd64 $(NAME)-ruby27:latest-amd64
	docker tag $(NAME)-ruby27:$(VERSION)-arm64 $(NAME)-ruby27:latest-arm64
	docker tag $(NAME)-ruby30:$(VERSION)-amd64 $(NAME)-ruby30:latest-amd64
	docker tag $(NAME)-ruby30:$(VERSION)-arm64 $(NAME)-ruby30:latest-arm64
	docker tag $(NAME)-ruby31:$(VERSION)-amd64 $(NAME)-ruby31:latest-amd64
	docker tag $(NAME)-ruby31:$(VERSION)-arm64 $(NAME)-ruby31:latest-arm64
	docker tag $(NAME)-ruby32:$(VERSION)-amd64 $(NAME)-ruby32:latest-amd64
	docker tag $(NAME)-ruby32:$(VERSION)-arm64 $(NAME)-ruby32:latest-arm64
	docker tag $(NAME)-jruby93:$(VERSION)-amd64 $(NAME)-jruby93:latest-amd64
	docker tag $(NAME)-jruby93:$(VERSION)-arm64 $(NAME)-jruby93:latest-arm64
	docker tag $(NAME)-jruby94:$(VERSION)-amd64 $(NAME)-jruby94:latest-amd64
	docker tag $(NAME)-jruby94:$(VERSION)-arm64 $(NAME)-jruby94:latest-arm64
	docker tag $(NAME)-nodejs:$(VERSION)-amd64 $(NAME)-nodejs:latest-amd64
	docker tag $(NAME)-nodejs:$(VERSION)-arm64 $(NAME)-nodejs:latest-arm64
	docker tag $(NAME)-full:$(VERSION)-amd64 $(NAME)-full:latest-amd64
	docker tag $(NAME)-full:$(VERSION)-arm64 $(NAME)-full:latest-arm64

push: tag_latest
	docker push $(NAME)-customizable:latest-amd64
	docker push $(NAME)-customizable:latest-arm64
	docker push $(NAME)-customizable:$(VERSION)-amd64
	docker push $(NAME)-customizable:$(VERSION)-arm64
	docker push $(NAME)-ruby27:latest-amd64
	docker push $(NAME)-ruby27:latest-arm64
	docker push $(NAME)-ruby27:$(VERSION)-amd64
	docker push $(NAME)-ruby27:$(VERSION)-arm64
	docker push $(NAME)-ruby30:latest-amd64
	docker push $(NAME)-ruby30:latest-arm64
	docker push $(NAME)-ruby30:$(VERSION)-amd64
	docker push $(NAME)-ruby30:$(VERSION)-arm64
	docker push $(NAME)-ruby31:latest-amd64
	docker push $(NAME)-ruby31:latest-arm64
	docker push $(NAME)-ruby31:$(VERSION)-amd64
	docker push $(NAME)-ruby31:$(VERSION)-arm64
	docker push $(NAME)-ruby32:latest-amd64
	docker push $(NAME)-ruby32:latest-arm64
	docker push $(NAME)-ruby32:$(VERSION)-amd64
	docker push $(NAME)-ruby32:$(VERSION)-arm64
	docker push $(NAME)-jruby93:latest-amd64
	docker push $(NAME)-jruby93:latest-arm64
	docker push $(NAME)-jruby93:$(VERSION)-amd64
	docker push $(NAME)-jruby93:$(VERSION)-arm64
	docker push $(NAME)-jruby94:latest-amd64
	docker push $(NAME)-jruby94:latest-arm64
	docker push $(NAME)-jruby94:$(VERSION)-amd64
	docker push $(NAME)-jruby94:$(VERSION)-arm64
	docker push $(NAME)-nodejs:latest-amd64
	docker push $(NAME)-nodejs:latest-arm64
	docker push $(NAME)-nodejs:$(VERSION)-amd64
	docker push $(NAME)-nodejs:$(VERSION)-arm64
	docker push $(NAME)-full:latest-amd64
	docker push $(NAME)-full:latest-arm64
	docker push $(NAME)-full:$(VERSION)-amd64
	docker push $(NAME)-full:$(VERSION)-arm64

release: push
	docker manifest rm $(NAME)-full:latest || true
	docker manifest create $(NAME)-full:$(VERSION) $(NAME)-full:$(VERSION)-amd64 $(NAME)-full:$(VERSION)-arm64
	docker manifest create $(NAME)-full:latest     $(NAME)-full:latest-amd64     $(NAME)-full:latest-arm64
	docker manifest push $(NAME)-full:$(VERSION)
	docker manifest push $(NAME)-full:latest
	docker manifest rm $(NAME)-customizable:latest || true
	docker manifest create $(NAME)-customizable:$(VERSION) $(NAME)-customizable:$(VERSION)-amd64 $(NAME)-customizable:$(VERSION)-arm64
	docker manifest create $(NAME)-customizable:latest     $(NAME)-customizable:latest-amd64     $(NAME)-customizable:latest-arm64
	docker manifest push $(NAME)-customizable:$(VERSION)
	docker manifest push $(NAME)-customizable:latest
	docker manifest rm $(NAME)-jruby93:latest || true
	docker manifest create $(NAME)-jruby93:$(VERSION) $(NAME)-jruby93:$(VERSION)-amd64 $(NAME)-jruby93:$(VERSION)-arm64
	docker manifest create $(NAME)-jruby93:latest	  $(NAME)-jruby93:latest-amd64	   $(NAME)-jruby93:latest-arm64
	docker manifest push $(NAME)-jruby93:$(VERSION)
	docker manifest push $(NAME)-jruby93:latest
	docker manifest rm $(NAME)-jruby94:latest || true
	docker manifest create $(NAME)-jruby94:$(VERSION) $(NAME)-jruby94:$(VERSION)-amd64 $(NAME)-jruby94:$(VERSION)-arm64
	docker manifest create $(NAME)-jruby94:latest	  $(NAME)-jruby94:latest-amd64	   $(NAME)-jruby94:latest-arm64
	docker manifest push $(NAME)-jruby94:$(VERSION)
	docker manifest push $(NAME)-jruby94:latest
	docker manifest rm $(NAME)-nodejs:latest || true
	docker manifest create $(NAME)-nodejs:$(VERSION) $(NAME)-nodejs:$(VERSION)-amd64 $(NAME)-nodejs:$(VERSION)-arm64
	docker manifest create $(NAME)-nodejs:latest	 $(NAME)-nodejs:latest-amd64	 $(NAME)-nodejs:latest-arm64
	docker manifest push $(NAME)-nodejs:$(VERSION)
	docker manifest push $(NAME)-nodejs:latest
	docker manifest rm $(NAME)-ruby32:latest || true
	docker manifest create $(NAME)-ruby32:$(VERSION) $(NAME)-ruby32:$(VERSION)-amd64 $(NAME)-ruby32:$(VERSION)-arm64
	docker manifest create $(NAME)-ruby32:latest	 $(NAME)-ruby32:latest-amd64	 $(NAME)-ruby32:latest-arm64
	docker manifest push $(NAME)-ruby32:$(VERSION)
	docker manifest push $(NAME)-ruby32:latest
	docker manifest rm $(NAME)-ruby31:latest || true
	docker manifest create $(NAME)-ruby31:$(VERSION) $(NAME)-ruby31:$(VERSION)-amd64 $(NAME)-ruby31:$(VERSION)-arm64
	docker manifest create $(NAME)-ruby31:latest	 $(NAME)-ruby31:latest-amd64	 $(NAME)-ruby31:latest-arm64
	docker manifest push $(NAME)-ruby31:$(VERSION)
	docker manifest push $(NAME)-ruby31:latest
	docker manifest rm $(NAME)-ruby30:latest || true
	docker manifest create $(NAME)-ruby30:$(VERSION) $(NAME)-ruby30:$(VERSION)-amd64 $(NAME)-ruby30:$(VERSION)-arm64
	docker manifest create $(NAME)-ruby30:latest	 $(NAME)-ruby30:latest-amd64	 $(NAME)-ruby30:latest-arm64
	docker manifest push $(NAME)-ruby30:$(VERSION)
	docker manifest push $(NAME)-ruby30:latest
	docker manifest rm $(NAME)-ruby27:latest || true
	docker manifest create $(NAME)-ruby27:$(VERSION) $(NAME)-ruby27:$(VERSION)-amd64 $(NAME)-ruby27:$(VERSION)-arm64
	docker manifest create $(NAME)-ruby27:latest	 $(NAME)-ruby27:latest-amd64	 $(NAME)-ruby27:latest-arm64
	docker manifest push $(NAME)-ruby27:$(VERSION)
	docker manifest push $(NAME)-ruby27:latest
	test -z "$$(git status --porcelain)" && git commit -am "$(VERSION)" && git tag "rel-$(VERSION)" && git push origin "rel-$(VERSION)"

clean:
	rm -rf customizable_image
	rm -rf ruby27_image
	rm -rf ruby30_image
	rm -rf ruby31_image
	rm -rf ruby32_image
	rm -rf jruby93_image
	rm -rf jruby94_image
	rm -rf nodejs_image
	rm -rf full_image

clean_images:
	docker rmi $(NAME)-customizable:latest-amd64 $(NAME)-customizable:$(VERSION)-amd64 || true
	docker rmi $(NAME)-customizable:latest-arm64 $(NAME)-customizable:$(VERSION)-arm64 || true
	docker rmi $(NAME)-ruby26:latest-amd64 $(NAME)-ruby26:$(VERSION)-amd64 || true
	docker rmi $(NAME)-ruby26:latest-arm64 $(NAME)-ruby26:$(VERSION)-arm64 || true
	docker rmi $(NAME)-ruby27:latest-amd64 $(NAME)-ruby27:$(VERSION)-amd64 || true
	docker rmi $(NAME)-ruby27:latest-arm64 $(NAME)-ruby27:$(VERSION)-arm64 || true
	docker rmi $(NAME)-ruby30:latest-amd64 $(NAME)-ruby30:$(VERSION)-amd64 || true
	docker rmi $(NAME)-ruby30:latest-arm64 $(NAME)-ruby30:$(VERSION)-arm64 || true
	docker rmi $(NAME)-ruby31:latest-amd64 $(NAME)-ruby31:$(VERSION)-amd64 || true
	docker rmi $(NAME)-ruby31:latest-arm64 $(NAME)-ruby31:$(VERSION)-arm64 || true
	docker rmi $(NAME)-ruby32:latest-amd64 $(NAME)-ruby32:$(VERSION)-amd64 || true
	docker rmi $(NAME)-ruby32:latest-arm64 $(NAME)-ruby32:$(VERSION)-arm64 || true
	docker rmi $(NAME)-jruby93:latest-amd64 $(NAME)-jruby93:$(VERSION)-amd64 || true
	docker rmi $(NAME)-jruby93:latest-arm64 $(NAME)-jruby93:$(VERSION)-arm64 || true
	docker rmi $(NAME)-jruby94:latest-amd64 $(NAME)-jruby94:$(VERSION)-amd64 || true
	docker rmi $(NAME)-jruby94:latest-arm64 $(NAME)-jruby94:$(VERSION)-arm64 || true
	docker rmi $(NAME)-nodejs:latest-amd64 $(NAME)-nodejs:$(VERSION)-amd64 || true
	docker rmi $(NAME)-nodejs:latest-arm64 $(NAME)-nodejs:$(VERSION)-arm64 || true
	docker rmi $(NAME)-full:latest-amd64 $(NAME)-full:$(VERSION)-amd64 || true
	docker rmi $(NAME)-full:latest-arm64 $(NAME)-full:$(VERSION)-arm64 || true
