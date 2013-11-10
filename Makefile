VERSION = 1.0

.PHONY: all build tag_latest

all: build

build:
	docker build -t phusion/passenger:$(VERSION) -rm nginx-ruby

tag_latest:
	docker tag phusion/passenger:$(VERSION) phusion/passenger:latest
