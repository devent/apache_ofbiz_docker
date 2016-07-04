SHELL := /bin/bash
.PHONY: setup weave convoy db ofbiz
.DEFAULT_GOAL := help

include docker_make_utils/Makefile.help

setup: weave ##@default Setups the weave network.

weave: ##@targets Installs and setups the weave network.
	cd docker_utils/weave && $(MAKE)

convoy: ##@targets Installs and setups the convoy volumes.
	cd docker_utils/convoy && $(MAKE)

db: setup ##@targets Installs and setups the database.
	cd mysql_container && $(MAKE)

ofbiz: setup ##@targets Installs and setups Apache Ofbiz.
	cd ofbiz_container && $(MAKE)
