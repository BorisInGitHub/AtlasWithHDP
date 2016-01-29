#!/usr/bin/env bash

source conf.sh

# mysql client
# Installation from sudo apt-get install mysql-client-core-5.6
# sudo add-apt-repository ppa:ondrej/mysql-5.7

echo "";
echo "Création des tables dans MySQL";
docker run -it --volume `pwd`/../mysql:/data  --link ${DOCKER_MYSQL_CONTAINER_NAME}:mysql mysql sh -c "exec mysql -h\"\$MYSQL_PORT_3306_TCP_ADDR\" -P\"\$MYSQL_PORT_3306_TCP_PORT\" -uroot -p\"\$MYSQL_ENV_MYSQL_ROOT_PASSWORD\" ${MYSQL_DATABASE} -v < /data/MySQLSourceSystem.ddl"
#mysql -h ${HOSTNAME} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < ../mysql/MySQLSourceSystem.ddl

echo "";
echo "Chargement des données dans MySQL";
CMD1="LOAD DATA LOCAL INFILE 'data/drivers.csv' into table DRIVERS FIELDS TERMINATED BY ','  LINES TERMINATEd BY '\n' (DRIVER_ID, DRIVER_NAME, CERTIFIED, WAGE_PLAN);";
CMD2="LOAD DATA LOCAL INFILE 'data/timesheet.csv' into table TIMESHEET FIELDS TERMINATED BY ','  LINES TERMINATEd BY '\n' (DRIVER_ID, DRIVER_WEEK, HOURS_LOGGED, MILES_LOGGED);";
#mysql -h ${HOSTNAME} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -e "${CMD1}" -v
#mysql -h ${HOSTNAME} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -e "${CMD2}" -v

#mysqlimport --local -h ${HOSTNAME} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} ../resources/drivers.csv
docker run -it --volume `pwd`/../resources:/data  --link ${DOCKER_MYSQL_CONTAINER_NAME}:mysql mysql sh -c "exec mysql -h\"\$MYSQL_PORT_3306_TCP_ADDR\" -P\"\$MYSQL_PORT_3306_TCP_PORT\" -uroot -p\"\$MYSQL_ENV_MYSQL_ROOT_PASSWORD\" ${MYSQL_DATABASE} -e \"${CMD1}\" -v"
docker run -it --volume `pwd`/../resources:/data  --link ${DOCKER_MYSQL_CONTAINER_NAME}:mysql mysql sh -c "exec mysql -h\"\$MYSQL_PORT_3306_TCP_ADDR\" -P\"\$MYSQL_PORT_3306_TCP_PORT\" -uroot -p\"\$MYSQL_ENV_MYSQL_ROOT_PASSWORD\" ${MYSQL_DATABASE} -e \"${CMD2}\" -v"