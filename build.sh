#!/bin/bash

export $(xargs <.env)
export $(xargs <proxy/proxy.env)

envsubst < source/conf/setup_replication_source.sql.template > source/conf/setup_replication_source.sql
envsubst < proxy/conf/proxysql.cnf.template > proxy/conf/proxysql.cnf

docker-compose down -v
rm -rf ./source/data/*
rm -rf ./replica/data/*
rm -rf ./proxysql
docker-compose up --build -d

until docker exec mysql_source sh -c 'export MYSQL_PWD=111; mysql -u root -e ";"'
do
    echo "Waiting for mysql_source database connection..."
    sleep 4
done

# Wait for all replicas to be ready
declare -a REPLICAS
REPLICAS=( $(docker ps --format '{{.Names}}' | grep '^mysql_replica') )

for REPLICA in "${REPLICAS[@]}"; do
    until docker exec "$REPLICA" sh -c 'export MYSQL_PWD=111; mysql -u root -e ";"'
    do
        echo "Waiting for $REPLICA database connection..."
        sleep 4
    done

done


MS_STATUS=$(docker exec mysql_source sh -c 'export MYSQL_PWD=111; mysql -u root -e "SHOW BINARY LOG STATUS"')
CURRENT_LOG=$(echo "$MS_STATUS" | awk '{print $6}')
CURRENT_POS=$(echo "$MS_STATUS" | awk '{print $7}')

start_replica_stmt="CHANGE REPLICATION SOURCE TO SOURCE_HOST='mysql_source',SOURCE_USER='mydb_replica_user',SOURCE_PASSWORD='mydb_replica_pwd', SOURCE_AUTO_POSITION=1, GET_SOURCE_PUBLIC_KEY=1; START REPLICA;"

for REPLICA in "${REPLICAS[@]}"; do
    start_replica_cmd='export MYSQL_PWD=111; mysql -u root -e "'
    start_replica_cmd+="$start_replica_stmt"
    start_replica_cmd+='"'
    docker exec "$REPLICA" sh -c "$start_replica_cmd"
    docker exec "$REPLICA" sh -c "export MYSQL_PWD=111; mysql -u root -e 'SHOW REPLICA STATUS \\G'"
done
