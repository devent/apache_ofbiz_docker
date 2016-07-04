VERSION := latest
NAME := ofbiz
CONTAINER_USER ?= www-data
# Set the option PORTS='-p 8080:8080 -p 8443:8443' to visit Apache Ofbiz on localhost.
PORTS ?=
# DNS Server
DNS_SERVER :=

define DOCKER_CMD :=
docker run \
--name $(NAME) \
$(DNS_SERVER) \
-e OFBIZ_USER_ID=`id -u $(CONTAINER_USER)` \
-e OFBIZ_GROUP_ID=`id -g $(CONTAINER_USER)` \
$(PORTS) \
-d \
erwinnttdata/apache-ofbiz-embedded:$(VERSION)
endef

include ../docker_make_utils/Makefile.help
include ../docker_make_utils/Makefile.functions
include ../docker_make_utils/Makefile.container

.PHONY +: run rerun rm clean test restart bash

run: _localuser _run ##@default Starts the container. Set the option PORTS='-p 8080:8080' to visit Apache Ofbiz on localhost.

rerun: _rerun ##@targets Stops and starts the container.

rm: _rm ##@targets Stops and removes the container.

clean: _clean ##@targets Stops and removes the container and removes all created files.

test: _test ##@targets Tests if the container is running.
	
restart: _restart ##@targets Restarts the container.

bash: test _bash ##@targets Executes the bash inside the running container.
