#!/usr/bin/env bash


source conf.sh

echo "";
echo "Initialize Atlas in the HDP Sandbox";



#Modification import-hive.sh lectur /bridge/hive et /hook/hive (cf https://issues.apache.org/jira/browse/ATLAS-92)
ssh ${SSH_USER_NAME}@${SERVER_NAME} "wget https://issues.apache.org/jira/secure/attachment/12748786/ATLAS-92.000.patch /tmp/ATLAS-92.000.patch";
ssh ${SSH_USER_NAME}@${SERVER_NAME} "cp /usr/hdp/current/atlas-server/bin/import-hive.sh /usr/hdp/current/atlas-server/bin/import-hive.sh.orig";
ssh ${SSH_USER_NAME}@${SERVER_NAME} "patch /usr/hdp/current/atlas-server/bin/import-hive.sh /tmp/ATLAS-92.000.patch";

#Lancement de import-hive.sh
ssh ${SSH_USER_NAME}@${SERVER_NAME} "./usr/hdp/current/atlas-server/bin/import-hive.sh";