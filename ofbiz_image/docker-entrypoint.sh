#!/bin/bash
set -eo pipefail

echo $PWD

# if command starts with an option, prepend the run command
if [ "${1:0:1}" = '-' ]; then
    set -- ./ant "$@"
fi

# Add local user;
# Either use the 
# - OFBIZ_USER_ID and
# - OFBIZ_GROUP_ID
# if passed in at runtime or fallback.
USER_ID=${OFBIZ_USER_ID:-9001}
GROUP_ID=${OFBIZ_GROUP_ID:-9001}
echo "Starting with UID and GID: $USER_ID:$GROUP_ID"
usermod -u $USER_ID www-data
groupmod -g $GROUP_ID www-data

# install Apache Ofbiz
if ! [ -e build.xml ]; then
    tar cf - --one-file-system -C /usr/src/apache-ofbiz . | tar xf -
fi

# update permissions
chown -R www-data.www-data /var/www/html/apache-ofbiz

# run command
exec "$@"
