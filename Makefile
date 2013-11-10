VERSION = 1.0

.PHONY: all build

all: build

build:
	docker build -t phusion/passenger:$(VERSION) -rm nginx-ruby
