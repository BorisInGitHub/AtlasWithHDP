#!/usr/bin/env bash


source conf.sh

echo "";
echo "Initialize Atlas in the HDP Sandbox";

NODE_PREFIX="BORISamb"

echo ""
echo "Get Docker Ambari"
rm -rf /tmp/dockerAmbari
mkdir /tmp/dockerAmbari
cd /tmp/dockerAmbari
git clone https://github.com/sequenceiq/docker-ambari.git


echo "";
echo "Arrêt des anciennes machines Docker";


docker stop ${NODE_PREFIX}1
docker stop ${NODE_PREFIX}2
docker stop ${NODE_PREFIX}-server
docker stop ${NODE_PREFIX}-consul

docker rm ${NODE_PREFIX}1
docker rm ${NODE_PREFIX}2
docker rm ${NODE_PREFIX}-server
docker rm ${NODE_PREFIX}-consul

#Sous docker ambari dans ambari-server§shell/install-cluster.sh rajouter
#blueprint add --url https://raw.githubusercontent.com/sequenceiq/ambari-rest-client/2.2.0/src/main/resources/blueprints/multi-node-hive



echo ""
echo "Start docker Ambari"
cd docker-ambari
source ambari-functions NODE_PREFIX=${NODE_PREFIX} EXPOSE_DNS=true

amb-settings

#amb-deploy-cluster 3 multi-node-hive
amb-start-cluster 3

echo "";
echo "After amb-shell type help";
exit;
amb-shell


# Add blueprint https://raw.githubusercontent.com/michaelzhou999/ambari-blueprints/master/sandbox-hdp-2.3.1.json
#blueprint add --url https://raw.githubusercontent.com/michaelzhou999/ambari-blueprints/master/sandbox-hdp-2.3.1.json
#cluster build --blueprint sandbox
#cluster assign --hostGroup host_group_1 --host server.ambari.com
#cluster create
#tasks
#exit
# hostname : BORISamb-server.service.consul
#cluster autoAssign



amb-settings


#curl -Lo .amb j.mp/docker-ambari && source .amb &&




amb-deploy-cluster

amb-settings
# Go to http://172.17.0.3:8080/ admin/admin

echo "";
echo "UI on http://AMBARI_SERVER_IP:8080/ (admin/admin)";
echo "UI (default) on http://172.17.0.3:8080/ (admin/admin)";

# TODO : Virer le exit et faire le code dessous ...
exit;
echo ""
echo "Modification hive-import ..."

#Modification import-hive.sh lecture /bridge/hive et /hook/hive (cf https://issues.apache.org/jira/browse/ATLAS-92)
ssh ${SSH_USER_NAME}@${SERVER_NAME} "wget https://issues.apache.org/jira/secure/attachment/12748786/ATLAS-92.000.patch /tmp/ATLAS-92.000.patch";
ssh ${SSH_USER_NAME}@${SERVER_NAME} "cp /usr/hdp/current/atlas-server/bin/import-hive.sh /usr/hdp/current/atlas-server/bin/import-hive.sh.orig";
ssh ${SSH_USER_NAME}@${SERVER_NAME} "patch /usr/hdp/current/atlas-server/bin/import-hive.sh /tmp/ATLAS-92.000.patch";

#Lancement de import-hive.sh (ne faire qu'une seule fois pour initialiser les systemTypes de metadonnées.
ssh ${SSH_USER_NAME}@${SERVER_NAME} "./usr/hdp/current/atlas-server/bin/import-hive.sh";