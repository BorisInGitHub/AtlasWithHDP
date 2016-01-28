#!/usr/bin/env bash

# Paramètre pour la connection SSH sur le serveur contenant HDFS
SERVER_NAME="sandbox.hortonworks.com";
#SERVER_NAME="192.168.1.246";
SSH_USER_NAME="root";
HDFS_USER="hdfs";
HIVE_USER="hive";

EXT_DATA_PATH="/atlasWithHDPDemo";

#----------------------------------------------------------------------------------------------------------------------
# Pré-requis
#
# Connection automatique pour USER_NAME@SERVER_NAME automatique (sans mot de passe)

# Rappel : Pour se connecter en SSH sans mot de passe faire :
# ssh-keygen
# puis
# ssh-copy-id USER_NAME@SERVER_NAME
# Le ssh-keygen est à faire une fois (sur votre machine)
# Le ssh-copy-id doit être fait pour chaque machine
#----------------------------------------------------------------------------------------------------------------------
