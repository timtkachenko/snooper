#!/bin/sh

set -e

ls -al /docker-entrypoint-initdb.d

INIT=/docker-entrypoint-initdb.d/002-init.sql

sed -i "s/\$MYSQL_USER/${MYSQL_USER}/g" $INIT
sed -i "s/\$MYSQL_PASSWORD/${MYSQL_PASSWORD}/g" $INIT
sed -i "s/\$MYSQL_ROOT_PASSWORD/${MYSQL_ROOT_PASSWORD}/g" $INIT

