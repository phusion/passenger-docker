NAME = phusion/passenger
VERSION = 0.9.3

.PHONY: all build build_minimal build_full create_minimal_image_dir tag_latest release clean

all: build

build: build_full build_minimal

build_full: create_minimal_image_dir
	docker build -t $(NAME)-full:$(VERSION) -rm image

build_minimal: create_minimal_image_dir
	docker build -t $(NAME)-minimal:$(VERSION) -rm minimal_image

# Docker doesn't support sharing files between different Dockerfiles. -_-
# So we copy things around.
create_minimal_image_dir:
	rm -rf minimal_image
	cp -pR image minimal_image
	echo minimal=1 >> minimal_image/buildconfig

tag_latest:
	docker tag $(NAME)-full:$(VERSION) $(NAME)-full:latest
	docker tag $(NAME)-minimal:$(VERSION) $(NAME)-minimal:latest

release: tag_latest
	@if ! docker images $(NAME)-full | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-full version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-minimal | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-minimal version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)-full
	docker push $(NAME)-minimal
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

clean:
	rm -rf minimal_image
