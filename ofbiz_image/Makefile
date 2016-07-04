REPOSITORY := erwinnttdata
NAME := apache-ofbiz-embedded
BUILD ?= 004
VERSION ?= 13.07.03-build_$(BUILD)

build:
	$(call check_defined, BUILD, Build number)
build: _build ##@targets Builds the docker image.

clean: _clean ##@targets Removes the local docker image.

deploy:
	$(call check_defined, BUILD, Build number)
deploy: _deploy ##@targets Deployes the docker image to the repository.

include ../docker_make_utils/Makefile.help
include ../docker_make_utils/Makefile.functions
include ../docker_make_utils/Makefile.image

.PHONY +: build clean deploy
