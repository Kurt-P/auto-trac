About
=====
This is a little side project I'm working on to automate the deployment of a 
Trac bug tracking host. This script is for deployting a single trac host, 
however I have two `*.wsgi` files; `trac_single.wsgi` if for a single project on
the Trac host, and `trac_multi.wsgi` if for having multiple projects on a 
single Trac host. For my own needs, this will deploy a single project on the new
Trac host.

As a quick note, you may want to edit the line in `trac_deploy.sh` that has the 
`PROJECT` variable to whatever you would like your project to be named. The 
default value is "MyProject"


What We Assume
==============
When this scrip was made, it is assumed that the server that is going to be used
is a freshly installed server OS (Ubunut 12.04.2) and Apache has not be 
configured yet.

*NOTE: If you have already configured Apache comment out the line in the script 
that moves and replaces `/etc/apache2/httpd.conf` you will need to then 
configure that manually until I figure out a better why of adding that entry to 
that config file*

What it Does
=============
1. The script will install a series of programs and libs (sqlite, apache2, etc.)
2. Create a series of directories in `/var/` where the Trac sites will be stored
3. Initiate your first Trac environment
4. Copy two configs to `/etc/apache2/` and `$TRAC_ROOT/apache/`
5. Create your first Trac admin user w/ passwd
6. Make `www-data` the owner of `$TRAC_ROOT`
7. Restart Apache

Resources
=========
* http://trac.edgewall.org/wiki/TracInstall
* http://robertbasic.com/blog/trac-on-ubuntu
* http://trac.edgewall.org/wiki/Ubuntu-11.10
* http://trac.edgewall.org/wiki/TracOnUbuntu
