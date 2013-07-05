#!/bin/bash

if [[ $EUID -ne 0 ]] then
    echo "You must run this as root user"
    exit 1
fi

$PROJECT = MyProject

##Install the packages you need
apt-get install sqlite3 python-sqlite python-setuptools python-genshi python-pygments apache2 sendmail git subversion python-subversion libapache2-mod-wsgi libapache2-mod-python

##Install Trac
easy_install Trac==1.0

mkdir /var/trac /var/trac/sites /var/trac/eggs /var/trac/apache
chown -R www-data /var/trac

service apache2 restart

trac-admin /var/trac/sites/$PROJECT initenv