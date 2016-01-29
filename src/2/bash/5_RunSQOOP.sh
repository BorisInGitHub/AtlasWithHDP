#!/usr/bin/env bash

source conf.sh

echo ""
echo "Run sqoop on ${HORTON_HOSTNAME}";

#I've modify the sqoop_job.sh to sqoop_job2.sh
ssh ${HORTON_ROOT_NAME}@${HORTON_HOSTNAME} "cd /tmp/demo2/atlasClient;\
/tmp/demo2/atlasClient/sqoop_job2.sh ${HOSTNAME} 3306 trucker1 trucker ${MYSQL_DATABASE} demo2"

echo "We can go to ATLAS UI http://${HORTON_HOSTNAME}:21000/"
echo "We can go to Ambari UI http://${HORTON_HOSTNAME}:8080/ (admin/admin)"

echo "Go to hive http://${HORTON_HOSTNAME}:8080/#/main/views/HIVE/1.0.0/Hive"
echo "show tables;"
echo "select * from drivers;"
echo "select * from timesheet;"

echo ""
echo "Go to atlas http://sandbox.hortonworks.com:21000/#!/search"
echo "Table where name=”DRIVERS";