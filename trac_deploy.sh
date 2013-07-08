#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "          !! INFO !!          "
    echo "You must run this as root user"
    exit 1
fi

##Define the fist project's name
PROJECT='MyProject'
##Where to put the Trac environment
TRAC_ROOT='/var/trac'
##Which version of Trac to install; only one should be uncommented
TRAC_INSTALL='Trac==1.0'
#TRAC_INSATLL='Trac==dev'

##Install the packages you need
apt-get install sqlite3 python-sqlite python-setuptools python-genshi python-pygments apache2 sendmail subversion python-subversion libapache2-mod-wsgi libapache2-mod-python

##Install Trac
easy_install $TRAC_INSTALL

##Make the containing folders for Trac
mkdir -p $TRAC_ROOT/sites/ $TRAC_ROOT/eggs/ $TRAC_ROOT/apache/

##Create your first project
trac-admin $TRAC_ROOT/sites/$PROJECT initenv

##Copy the pre-made WSGI file to the trac root Apache folder
##There are two wsgi files that can be made, one for making trac use multiple 
##projects, and one the uses only a single project. Configure accordantly.
##NOTE: Only one (1) should be uncommented.

##wsgi for single project (default)
cp ./trac_single.wsgi $TRAC_ROOT/apache/trac.wsgi
##wsgi for multiple projects
##cp ./trac_multi.wsgi $TRAC_ROOT/apache/trac.wsgi

##Make a backup of the existing httpd.conf file and copy the new one to the 
##/etc/apache2 folder
mv /etc/apache2/httpd.conf /etc/apache2/httpd.conf.bak
cp ./httpd.conf -t /etc/apache2/

##User info for the TRAC_ADMIN
echo "Create your first user and administrator"
echo -n "New User: "
read USER
echo -n "Password: "
read -s PASSWD

##Create the .htpasswd file for Trac
htpasswd -bcm $TRAC_ROOT/.htpasswd $USER $PASSWD

##Unset the PASSWD
unset PASSWD

##Give your new user privileges on Trac
trac-admin $TRAC_ROOT/sites/$PROJECT permission add $USER TRAC_ADMIN

##Own the $TRAC_ROOT
chown -R www-data $TRAC_ROOT
##Restart Apache
service apache2 restart
