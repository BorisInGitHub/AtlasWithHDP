#!/usr/bin/env bash

source conf.sh

# Création d'une table Hive externe
SCRIPT_HIVE="CREATE EXTERNAL TABLE IF NOT EXISTS Personnes(
        Id INT,
        Nom STRING,
        Prenom String)
    COMMENT 'Data about person from a public database'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    location 'hdfs:///${EXT_DATA_PATH}/people';";
echo ""
echo "Création d'une table externe dans Hive"

ssh ${SSH_USER_NAME}@${SERVER_NAME} "echo \"${SCRIPT_HIVE}\" > /tmp/scriptHive1.sql"
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HIVE_USER} -c \"hive -f /tmp/scriptHive1.sql\"";

echo "Hive : http://${SERVER_NAME}:8080/#/main/views/HIVE/1.0.0/Hive";
echo "Requête d'exemple : SELECT * FROM personnes LIMIT 100;";



# Création d'une table Hive interne
SCRIPT_HIVE_2="CREATE TABLE IF NOT EXISTS PersonnesHive(
        Id INT,
        Nom STRING,
        Prenom String)
    COMMENT 'Data about person from a public database'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS ORC;";

echo ""
echo "Création d'une table interne dans Hive"

ssh ${SSH_USER_NAME}@${SERVER_NAME} "echo \"${SCRIPT_HIVE_2}\" >> /tmp/scriptHive2.sql"
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HIVE_USER} -c \"hive -f /tmp/scriptHive2.sql\"";

# Copie des données de la table externe dans la table interne
echo ""
echo "Copie des données dans la table interne dans Hive"
ssh ${SSH_USER_NAME}@${SERVER_NAME} "su ${HIVE_USER} -c \"hive -e 'INSERT OVERWRITE TABLE PersonnesHive SELECT * FROM Personnes;'\"";

echo "UI HIVE : http://${SERVER_NAME}:8080/#/main/views/HIVE/1.0.0/Hive"