#!/bin/bash

# Modify Script from sqoop_job.sh
MYSQL_HOSTNAME=$1
MYSQL_PORT=$2
MYSQL_USER=$3
MYSQL_PASSWORD=$4
MYSQL_DATABASE=$5
TARGET_DIR=demo$6

############################################################################
# This shell file is to emulate a sqoop handler process.
# Version- 1.0
# Date - July 9th, 2015
# Note - The paths in the scripts are specific to the hortonworks sandbox - 2.3
###############################################################################


#
# The below line executes the sqoop process to import the drivers table
#

sqoop import --connect jdbc:mysql://${MYSQL_HOSTNAME}:${MYSQL_PORT}/${MYSQL_DATABASE} --username ${MYSQL_USER} --password ${MYSQL_PASSWORD} --table DRIVERS -m 1 --target-dir ${TARGET_DIR} --hive-import --hive-overwrite --hive-table DRIVERS

#
# The below line emulates the import of the timesheet table
#

sqoop import --connect jdbc:mysql://${MYSQL_HOSTNAME}:${MYSQL_PORT}/${MYSQL_DATABASE} --username ${MYSQL_USER} --password ${MYSQL_PASSWORD} --table TIMESHEET -m 1 --target-dir ${TARGET_DIR} --hive-import --hive-overwrite --hive-table TIMESHEET

#
# The below code create the entities in atlas for Drivers and Timesheet table.
#

bin/atlasclient --c=importmysql --mysqlhost=${MYSQL_HOSTNAME} --password=${MYSQL_PASSWORD} --username=${MYSQL_USER} --db=${MYSQL_DATABASE}  -createHiveTables -genLineage --ambariClusterName=Sandbox --suppress

