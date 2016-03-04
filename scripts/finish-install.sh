#!/bin/bash
#
#

# Install E-Prints
sudo rpm -ivh http://rpm.eprints.org/rpm-eprints-org-key-1-1.noarch.rpm
sudo rpm -ivh http://rpm.eprints.org/eprints/noarch/rpm-eprints-org-1-1.noarch.rpm
sudo yum install eprints # 3.3.x and later

