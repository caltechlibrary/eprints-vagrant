#!/bin/bash
#
#

#sudo rpm -ivh http://rpm.eprints.org/rpm-eprints-org-key-1-1.noarch.rpm
#sudo rpm -ivh http://rpm.eprints.org/eprints/noarch/rpm-eprints-org-1-1.noarch.rpm
#sudo yum install eprints # 3.3.x and later

# Finish installing E-Prints
echo -n "What is your repository name? (e.g. lemurcode, lemurcode.local) "
read REPO_NAME
sudo chcon -R -h -t httpd_sys_script_rw_t /usr/share/eprints/archives/$REPO_NAME/documents/
sudo chcon -R -h -t httpd_sys_script_rw_t /usr/share/eprints/var/

