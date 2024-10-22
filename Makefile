SHELL := /bin/bash

ifeq ($(GITHUB_ACTIONS),true)
REGISTRY = ghcr.io
else
REGISTRY = docker.io
endif

NAME ?= $(REGISTRY)/phusion/passenger
VERSION ?= 3.1.0

# NAME and/or VERSION can be overriden during build if you are building locally to push to your own repository
# example:
#   login to your ECR repo, then
#   NAME="YOURID.dkr.ecr.us-west-2.amazonaws.com/passenger" VERSION=2.5.1.4 BUILD_ARM64=0 make -j1 build_ruby32 push_ruby32
#     This will build and push YOURID.dkr.ecr.us-west-2.amazonaws.com/passenger-ruby32:2.5.1.4-amd64
#     and YOURID.dkr.ecr.us-west-2.amazonaws.com/passenger-ruby32:2.5.1.4:latest-amd64

# Extra flags for docker build, usable via environment variable.
# Example: `export EXTRA_BUILD_FLAGS=--no-cache; make build_all`
EXTRA_BUILD_FLAGS?=

# Allow conditionally building multiple architectures
# example: BUILD_ARM64=0 make build_customizable ; only builds amd64 image
# defaults to building all specified images for both amd64 and arm64
ifeq ($(BUILD_AMD64),0)
_build_amd64 := 0
else
_build_amd64 := 1
endif

ifeq ($(BUILD_ARM64),0)
_build_arm64 := 0
else
_build_arm64 := 1
endif

.PHONY: all build_base build_all tag_latest cross_tag push release labels clean clean_images

FORCE:

# when adding a cRuby image, also update image/nginx-passenger.sh and image/ruby-support/finalize.sh
SPECIAL_IMAGES := customizable full
CRUBY_IMAGES := ruby31 ruby32 ruby33
PYTHON_IMAGES := python39 python310 python311 python312 python313
MISC_IMAGES := jruby93 jruby94 nodejs

ALL_IMAGES := $(SPECIAL_IMAGES) $(MISC_IMAGES) $(CRUBY_IMAGES) $(PYTHON_IMAGES)

all: build_all

# waits are to ensure that we only compile each version of ruby once per arch even if running in parallel
build_all: \
	build_customizable \
	.WAIT \
	$(foreach image, $(CRUBY_IMAGES), build_${image}) \
	.WAIT \
	$(foreach image, $(MISC_IMAGES), build_${image}) \
	.WAIT \
	$(foreach image, $(PYTHON_IMAGES), build_${image}) \
	build_full

build_base:
	rm -rf base_image
	cp -pR image base_image
ifeq ($(_build_amd64),1)
	docker rmi $(NAME)-base:current-amd64 || true
	docker buildx build --progress=plain --platform linux/amd64 $(EXTRA_BUILD_FLAGS) --build-arg ARCH=amd64 -t $(REGISTRY)/phusion/passenger-base:current-amd64 -f image/Dockerfile.base base_image --no-cache
endif
ifeq ($(_build_arm64),1)
	docker rmi $(NAME)-base:current-arm64 || true
	docker buildx build --progress=plain --platform linux/arm64 $(EXTRA_BUILD_FLAGS) --build-arg ARCH=arm64 -t $(REGISTRY)/phusion/passenger-base:current-arm64 -f image/Dockerfile.base base_image --no-cache
endif
	rm -rf base_image

build_%: build_base
	rm -rf $*_image
	cp -pR image $*_image
	@if [ "${*}" != "full" ] && [ "${*}" != "customizable" ]; then \
	    echo "${*}=1" >> ${*}_image/buildconfig; \
	fi
	@if [ "${*}" == "full" ]; then \
	    for i in ${CRUBY_IMAGES}; do echo "$${i}=1" >> ${*}_image/buildconfig; done; \
	    for i in ${MISC_IMAGES}; do echo "$${i}=1" >> ${*}_image/buildconfig; done; \
	    echo python312=1 >> ${*}_image/buildconfig; \
	    echo redis=1 >> ${*}_image/buildconfig; \
	    echo memcached=1 >> ${*}_image/buildconfig; \
	fi
	@if [ "${*}" != "customizable" ]; then \
	    echo final=1 >> ${*}_image/buildconfig; \
	fi
ifeq ($(_build_amd64),1)
	docker buildx build --progress=plain --platform linux/amd64 $(EXTRA_BUILD_FLAGS) --build-arg REGISTRY=$(REGISTRY) --build-arg ARCH=amd64 -t $(NAME)-$*:$(VERSION)-amd64 --rm $*_image
endif
ifeq ($(_build_arm64),1)
	docker buildx build --progress=plain --platform linux/arm64 $(EXTRA_BUILD_FLAGS) --build-arg REGISTRY=$(REGISTRY) --build-arg ARCH=arm64 -t $(NAME)-$*:$(VERSION)-arm64 --rm $*_image
endif

labels: $(foreach image, $(ALL_IMAGES), label_${image})

label_%: FORCE
ifeq ($(_build_amd64),1)
	@echo $(NAME)-$*:$(VERSION)-amd64 $(NAME)-$*:latest-amd64
endif
ifeq ($(_build_arm64),1)
	@echo $(NAME)-$*:$(VERSION)-arm64 $(NAME)-$*:latest-arm64
endif

pull: $(foreach image, $(ALL_IMAGES), pull_${image})

pull_%: FORCE
ifeq ($(_build_amd64),1)
	docker pull $(NAME)-$*:$(VERSION)-amd64
endif
ifeq ($(_build_arm64),1)
	docker pull $(NAME)-$*:$(VERSION)-arm64
endif

cross_tag: $(foreach image, $(ALL_IMAGES), cross_tag_${image})

cross_tag_%: FORCE
ifeq ($(_build_amd64),1)
	docker tag ghcr.io/phusion/passenger-$*:$(VERSION)-amd64 $(NAME)-$*:$(VERSION)-amd64
endif
ifeq ($(_build_arm64),1)
	docker tag ghcr.io/phusion/passenger-$*:$(VERSION)-arm64 $(NAME)-$*:$(VERSION)-arm64
endif

tag_latest: $(foreach image, $(ALL_IMAGES), tag_latest_${image})

tag_latest_%: FORCE
ifeq ($(_build_amd64),1)
	docker tag $(NAME)-$*:$(VERSION)-amd64 $(NAME)-$*:latest-amd64
endif
ifeq ($(_build_arm64),1)
	docker tag $(NAME)-$*:$(VERSION)-arm64 $(NAME)-$*:latest-arm64
endif

push: $(foreach image, $(ALL_IMAGES), push_${image})

push_%: tag_latest_%
ifeq ($(_build_amd64),1)
	docker push $(NAME)-$*:latest-amd64
	docker push $(NAME)-$*:$(VERSION)-amd64
endif
ifeq ($(_build_arm64),1)
	docker push $(NAME)-$*:latest-arm64
	docker push $(NAME)-$*:$(VERSION)-arm64
endif

release: $(foreach image, $(ALL_IMAGES), release_${image})
	test -z "$$(git status --porcelain)" || git commit -am "$(VERSION)" && git tag "rel-$(VERSION)" && git push origin "rel-$(VERSION)"

release_%: push_%
	docker manifest rm $(NAME)-$*:latest || true
	docker manifest create $(NAME)-$*:$(VERSION) $(NAME)-$*:$(VERSION)-amd64 $(NAME)-$*:$(VERSION)-arm64
	docker manifest create $(NAME)-$*:latest     $(NAME)-$*:latest-amd64     $(NAME)-$*:latest-arm64
	docker manifest push $(NAME)-$*:$(VERSION)
	docker manifest push $(NAME)-$*:latest

clean:
	rm -rf *_image

clean_images: $(foreach image, $(ALL_IMAGES), clean_image_${image}) FORCE
	docker rmi $(REGISTRY)/phusion/passenger-base:current-amd64 phusion/passenger-base:current-amd64 || true
	docker rmi $(REGISTRY)/phusion/passenger-base:current-arm64 phusion/passenger-base:current-arm64 || true

clean_image_%: FORCE
	docker rmi $(NAME)-$*:latest-amd64 $(NAME)-$*:$(VERSION)-amd64 || true
	docker rmi $(NAME)-$*:latest-arm64 $(NAME)-$*:$(VERSION)-arm64 || true
