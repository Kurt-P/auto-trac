#!/bin/bash

if [[ $EUID -ne 0 ]] then
    echo "You must run this as root user"
    exit 1
fi

##Install the packages you need
apt-get install trac trac-accountmanager trac-graphviz trac-icalviewplugin trac-mastertickets trac-wysiwyg trac-wikitablemacro trac-tags trac-customfieldadmin trac-datefieldplugin sqlite3 python-sqlite sendmail python-setuptools python-genshi python-pygments apache2 sendmail

##Add the Trac user
adduser --system --shell /bin/sh --gecos 'trac project managment' --group --disabled-password --home /var/trac trac

##Add the Trac user to the www-data group
adduser www-data trac

##Change user to trac to do setup
su trac
bash
cd


