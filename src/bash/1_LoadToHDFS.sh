#!/usr/bin/env bash

source conf.sh

# Chargement du fichier dans Hadoop
echo ""
echo "Chargement du CSV"
ssh ${SSH_USER_NAME}@${SERVER_NAME} "rm -f /tmp/personnes.csv"
scp "../resources/personnes.csv" ${SSH_USER_NAME}@${SERVER_NAME}:/tmp/personnes.csv

ssh ${SSH_USER_NAME}@${SERVER_NAME} "head /tmp/personnes.csv"

# Remove headers from CSV
ssh ${SSH_USER_NAME}@${SERVER_NAME} "sed -i 1d /tmp/personnes.csv"


# HDFS : https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/FileSystemShell.html

# Copie to HDFS
ssh ${SSH_USER_NAME}@${SERVER_NAME} "sed -i 1d /tmp/personnes.csv"

echo ""
echo ""
echo "Préparation des répertoires dans Hadoop"
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HDFS_USER} -c \"hdfs dfs -mkdir ${EXT_DATA_PATH}\""
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HDFS_USER} -c \"hdfs dfs -chown -R ${HIVE_USER} ${EXT_DATA_PATH}\""
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HDFS_USER} -c \"hdfs dfs -ls /\""

echo ""
echo "Copie dans Hadoop"
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HIVE_USER} -c \"hdfs dfs -mkdir ${EXT_DATA_PATH}/people\""
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HIVE_USER} -c \"hdfs dfs -copyFromLocal -f /tmp/personnes.csv ${EXT_DATA_PATH}/people/personnes.csv\""
# Mise en place des droits pour le groupe hdfs
#ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HIVE_USER} -c \"hdfs dfs -chown -R :hdfs ${EXT_DATA_PATH}/people/personnes.csv\""
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su hdfs -c \"hdfs dfs -chown -R ${HIVE_USER} ${EXT_DATA_PATH}/people/personnes.csv\""
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HIVE_USER} -c \"hdfs dfs -ls ${EXT_DATA_PATH}/\""
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HIVE_USER} -c \"hdfs dfs -ls ${EXT_DATA_PATH}/people/\""

echo ""
echo "UI HDFS : http://${SERVER_NAME}:8080/#/main/views/FILES/1.0.0/Files"