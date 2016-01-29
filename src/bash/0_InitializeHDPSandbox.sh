#!/usr/bin/env bash


source conf.sh

echo "";
echo "Initialize Atlas in the HDP Sandbox";

echo ""
echo "Get Docker Ambari"
rm -rf /tmp/dockerAmbari
mkdir /tmp/dockerAmbari
cd /tmp/dockerAmbari
git clone https://github.com/sequenceiq/docker-ambari.git

docker stop amb1
docker stop amb2
docker stop amb-server
docker stop amb-consul

docker rm amb1
docker rm amb2
docker rm amb-server
docker rm amb-consul

#Sous docker ambari dans ambari-server§shell/install-cluster.sh rajouter
#blueprint add --url https://raw.githubusercontent.com/sequenceiq/ambari-rest-client/2.2.0/src/main/resources/blueprints/multi-node-hive



echo ""
echo "Start docker Ambari"
cd docker-ambari
source ambari-functions
#amb-settings
#amb-deploy-cluster 3 multi-node-hive
amb-deploy-cluster 1 single-node-hdfs-yarn


amb-settings
# Go to http://172.17.0.3:8080/ admin/admin

echo "";
echo "Fin";

echo ""
echo "Modification hive-import ..."

return
#Modification import-hive.sh lecture /bridge/hive et /hook/hive (cf https://issues.apache.org/jira/browse/ATLAS-92)
ssh ${SSH_USER_NAME}@${SERVER_NAME} "wget https://issues.apache.org/jira/secure/attachment/12748786/ATLAS-92.000.patch /tmp/ATLAS-92.000.patch";
ssh ${SSH_USER_NAME}@${SERVER_NAME} "cp /usr/hdp/current/atlas-server/bin/import-hive.sh /usr/hdp/current/atlas-server/bin/import-hive.sh.orig";
ssh ${SSH_USER_NAME}@${SERVER_NAME} "patch /usr/hdp/current/atlas-server/bin/import-hive.sh /tmp/ATLAS-92.000.patch";

#Lancement de import-hive.sh
ssh ${SSH_USER_NAME}@${SERVER_NAME} "./usr/hdp/current/atlas-server/bin/import-hive.sh";