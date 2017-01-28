#!/bin/bash

#######################
#
# Name: install.sh
# Description: sets up your Azure Active Directory Authentication on your ubuntu machine
# Author: chvugrin@microsoft.com
#
#######################

# OS Check
if [ ! -f /etc/lsb-release ]
then
  echo "Only tested on debian like systems"
  exit 1
else
  id=$(cat /etc/lsb-release | grep DISTRIB_ID | sed 's/^.*[=]//')
  if [[ $id -ne "Ubuntu" ]]
  then
    echo "Only tested on Ubuntu"
    exit 1
  fi
fi
# are you root
id=$(whoami)
if [ $id != "root" ]
then
  echo "you need to be root"
  exit 1
fi
clear
echo ""
echo ""
echo "starting setting up your Azure Active Directory Authentication on your ubuntu machine"
echo ""
echo ""
echo "Please provide your Azure Active Directory Name, for eg: datalinks.onmicrosoft.com "
read aadDirName
echo "Please provide your Azure Active Directory clientID...this is the ID of your native client you configured in AAD earlier"
read aadClientID
cp -f aad-login.js.orig aad-login.js
apt-get update
apt-get install npm
apt-get install nodejs
apt-get --purge remove node
if [ ! -f /usr/bin/node ] 
then
  ln -s /usr/bin/nodejs /usr/bin/node
fi

sed -i 's/aadDirName/'$aadDirName'/' aad-login.js
sed -i 's/aadClientID/'$aadClientID'/' aad-login.js
mkdir -p /opt/aad-login
cp aad-login.js package.json /opt/aad-login/
cp aad-login /usr/local/bin/

cd /opt/aad-login
npm install

sed -i '1s/.*/auth sufficient pam_exec.so expose_authtok \/usr\/local\/bin\/aad-login/' /etc/pam.d/common-auth
