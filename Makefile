VERSION = 1.0

.PHONY: all build tag_latest

all: build tag_latest

build:
	docker build -t phusion/passenger:$(VERSION) -rm nginx-ruby

tag_latest:
	sh -c 'ID=`docker run -d phusion/passenger:$(VERSION) true` && docker wait $$ID && docker commit $$ID phusion/passenger:latest'
