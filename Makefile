NAME = phusion/passenger
VERSION = 0.9.1

.PHONY: all build minimal_image tag_latest release clean

all: build

build: minimal_image
	docker build -t $(NAME)-full:$(VERSION) -rm image
	docker build -t $(NAME)-minimal:$(VERSION) -rm minimal_image

# Docker doesn't support sharing files between different Dockerfiles. -_-
# So we copy things around.
minimal_image:
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