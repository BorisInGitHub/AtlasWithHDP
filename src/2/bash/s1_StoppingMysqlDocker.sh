#!/usr/bin/env bash

source conf.sh

echo "";
echo "Arrêt du docker Mysql";
docker stop ${DOCKER_MYSQL_CONTAINER_NAME}