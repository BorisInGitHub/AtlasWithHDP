#!/usr/bin/env bash

source conf.sh

echo "";
echo "Affichage des databases Mysql";
docker run -it --link ${DOCKER_MYSQL_CONTAINER_NAME}:mysql mysql sh -c "exec mysql -h\"\$MYSQL_PORT_3306_TCP_ADDR\" -P\"\$MYSQL_PORT_3306_TCP_PORT\" -uroot -p\"\$MYSQL_ENV_MYSQL_ROOT_PASSWORD\" -e \"show databases;\""

echo "";
echo "Affichage des tables dans la base de données";
docker run -it --link ${DOCKER_MYSQL_CONTAINER_NAME}:mysql mysql sh -c "exec mysql -h\"\$MYSQL_PORT_3306_TCP_ADDR\" -P\"\$MYSQL_PORT_3306_TCP_PORT\" -uroot -p\"\$MYSQL_ENV_MYSQL_ROOT_PASSWORD\" ${MYSQL_DATABASE} -e \"show tables;\""


echo "";
echo "Affichage des données (DRIVERS) dans la base de données";
docker run -it --link ${DOCKER_MYSQL_CONTAINER_NAME}:mysql mysql sh -c "exec mysql -h\"\$MYSQL_PORT_3306_TCP_ADDR\" -P\"\$MYSQL_PORT_3306_TCP_PORT\" -uroot -p\"\$MYSQL_ENV_MYSQL_ROOT_PASSWORD\" ${MYSQL_DATABASE} -e \"Select * from DRIVERS;\""

echo "";
echo "Affichage des données (TIMESHIFT) dans la base de données";
docker run -it --link ${DOCKER_MYSQL_CONTAINER_NAME}:mysql mysql sh -c "exec mysql -h\"\$MYSQL_PORT_3306_TCP_ADDR\" -P\"\$MYSQL_PORT_3306_TCP_PORT\" -uroot -p\"\$MYSQL_ENV_MYSQL_ROOT_PASSWORD\" ${MYSQL_DATABASE} -e \"Select * from TIMESHEET LIMIT 20;\""