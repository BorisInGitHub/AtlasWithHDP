#!/usr/bin/env bash

source conf.sh

echo "";
echo "Démarrage du docker Mysql";
docker stop ${DOCKER_MYSQL_CONTAINER_NAME}
docker rm ${DOCKER_MYSQL_CONTAINER_NAME}
docker run --name ${DOCKER_MYSQL_CONTAINER_NAME}\
 -e MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD}\
 -e MYSQL_DATABASE=${MYSQL_DATABASE} \
 -e MYSQL_USER=${MYSQL_USER} \
 -e MYSQL_PASSWORD=${MYSQL_PASSWORD} \
 -d -p 3306:3306 mysql:5.6

echo "";
echo "Waiting 30s for Mysql is up";
sleep 30;
