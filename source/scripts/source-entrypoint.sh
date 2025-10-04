#!/bin/bash
set -e

# Substitute environment variables in the SQL template
sed -e "s|\${MYSQL_USER_REPLICATION_USER}|$MYSQL_USER_REPLICATION_USER|g" \
    -e "s|\${MYSQL_USER_REPLICATION_PASSWORD}|$MYSQL_USER_REPLICATION_PASSWORD|g" \
    -e "s|\${MYSQL_USER_MONITOR_USER}|$MYSQL_USER_MONITOR_USER|g" \
    -e "s|\${MYSQL_USER_MONITOR_PASSWORD}|$MYSQL_USER_MONITOR_PASSWORD|g" \
    -e "s|\${MYSQL_USER_ROOT_PASSWORD}|$MYSQL_USER_ROOT_PASSWORD|g" \
    /source/conf/setup_replication_source.sql.template > /docker-entrypoint-initdb.d/setup_replication_source.sql

#envsubst < /source/conf/setup_replication_source.sql.template > /docker-entrypoint-initdb.d/setup_replication_source.sql

# Start MySQL
exec docker-entrypoint.sh mysqld

