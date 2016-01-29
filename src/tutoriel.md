# Petit Tutoriel


## Pré-requis
Téléchargement de Ambari <https://github.com/sequenceiq/docker-ambari>
>git clone https://github.com/sequenceiq/docker-ambari.git



dans le répertoire créé (docker-ambari)
>source ambari-functions

Voir la configuration actuelle
>amb-settings


## Lancement

Déploiement et démarrage du cluster avec 3 noeuds
>amb-deploy-cluster 3

Puis un ``amb-settings`` pour voir l'ip du serveur (champ AMBARI_SERVER_IP)

Allez avec un navigateur à l'URL <http://172.17.0.3:8080> (admin/admin)


### Ajout des services
On ajoute les services Hive, Atlas, Pig, Sqoop
On utilise les paramètres par défaut, il faut juste configuré :

HiveMetastore
Datasebase Host: amb2.service.consul
Database Name: hive
Database Username: hive
Database Password: hive



