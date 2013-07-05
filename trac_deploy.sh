#!/bin/bash

if [[ $EUID -ne 0 ]] then
    echo "          !! INFO !!          "
    echo "You must run this as root user"
    exit 1
fi


PROJECT='MyProject'
TRAC_ROOT='/var/trac'
TRAC_INSTALL='Trac==1.0'

##Install the packages you need
apt-get install sqlite3 python-sqlite python-setuptools python-genshi python-pygments apache2 sendmail git subversion python-subversion libapache2-mod-wsgi libapache2-mod-python

##Install Trac
easy_install $TRAC_INSTALL

##mkdir /var/trac /var/trac/sites /var/trac/eggs /var/trac/apache
mkdir -p $TRAC_ROOT/sites $TRAC_ROOT/eggs $TRAC_ROOT/apache

##Creat your first project
trac-admin $TRAC_ROOT/sites/$PROJECT initenv

##Copy the premade WSGI file to the trac root apache folder
cp ./trac.wsgi -t $TRAC_ROOT/apache

##Make a backup of the existing httpd.conf file and copy the new one to the 
##/etc/apache2 folder
mv /etc/apache2/httpd.conf /etc/apache2/httpd.conf.bak
cp ./httpd.conf -t /etc/apache2/

echo "\n"

##User infor the TRAC_ADMIN
echo "Creat your first user and admim"
echo -n "New User: "
read USER
echo -n "Password: "
read -s PASSWD

##Creat the .htpasswd file for Trac
htpasswd -bcm $TRAC_ROOT/.htpasswd $USER $PASSWD

##Give your new user privilages on Trac
trac-admin $TRAC_ROOT/sites/$PROJECT permission add $USER TRAC_ADMIN

chown -R www-data $TRAC_ROOT
service apache2 restart

