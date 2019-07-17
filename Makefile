.PHONY: all dependencies precompiled

VERSION = 3.15.6

all: dependencies precompiled

dependencies:
	docker build dependencies -t ipeddocker/dependencies:$(VERSION)

precompiled:
	docker build precompiled -t ipeddocker/iped:$(VERSION)
