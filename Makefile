NAME = phusion/passenger
VERSION = 0.9.0

.PHONY: all build minimal_image tag_latest clean

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
	docker tag $(NAME):$(VERSION) $(NAME):latest

clean:
	rm -rf minimal_image