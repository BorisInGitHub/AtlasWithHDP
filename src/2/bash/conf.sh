#!/usr/bin/env bash


#Mysql
DOCKER_MYSQL_CONTAINER_NAME="mysqlDocker";
MYSQL_ROOT_PASSWORD="mysqlRootPWD";
MYSQL_DATABASE="demo2";
MYSQL_USER="userDemo2";
MYSQL_PASSWORD="userPassword";

# La plateforme HORTON SANDBOX ne connait pas les hostname, on mets donc directement l'IP.
#HOSTNAME=`hostname`.semsoft-corp.local
#HOSTNAME=`hostname`
HOSTNAME=`hostname -I | cut -d' ' -f1`

# HORTON SANDBOX
#HORTON_HOSTNAME="sandbox.hortonworks.com";
HORTON_HOSTNAME="192.168.1.246";
# IP : 192.168.1.246
HORTON_ROOT_NAME="root";
HORTON_ROOT_PASSWORD="uMee7oov";
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
