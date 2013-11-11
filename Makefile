VERSION = 0.9

.PHONY: all build tag_latest

all: build

build:
	docker build -t phusion/passenger:$(VERSION) -rm image

tag_latest:
	docker tag phusion/passenger:$(VERSION) phusion/passenger:latest
