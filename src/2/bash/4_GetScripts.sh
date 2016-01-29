#!/usr/bin/env bash

source conf.sh

echo ""
echo "Gettings scripts on the ${HORTON_HOSTNAME} server (we've make a copy in the archive directory)";


#ssh ${HORTON_ROOT_NAME}@${HORTON_HOSTNAME} "rm -rf /tmp/demo2;\
#mkdir /tmp/demo2;\
#cd /tmp/demo2;\
#wget https://www.dropbox.com/s/s50nuf6i73uw4gt/atlasInstallScripts.tar.gz?dl=0 -O atlasInstallScripts.tar.gz;\
#gzip -d atlasInstallScripts.tar.gz;\
#tar -xvf atlasInstallScripts.tar;\
#cd atlas_install_scripts;\
#./install;"


# Méthode plus rapide ...
ssh ${HORTON_ROOT_NAME}@${HORTON_HOSTNAME} "rm -rf /tmp/demo2;mkdir -p /tmp/demo2;"
scp -r ../archive/atlas_install_scripts/* ${HORTON_ROOT_NAME}@${HORTON_HOSTNAME}:/tmp/demo2