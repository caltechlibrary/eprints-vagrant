#!/bin/bash
#
#
wget http://cpan.uwinnipeg.ca/cpan/authors/id/T/TJ/TJMATHER/XML-GDOME-0.86.tar.gz
tar xzvf XML-GDOME-0.86.tar.gz
cd XML-GDOME-0.86/
 perl Makefile.PL
 make
 sudo make install
# Install E-Prints
sudo rpm -ivh http://rpm.eprints.org/rpm-eprints-org-key-1-1.noarch.rpm
sudo rpm -ivh http://rpm.eprints.org/eprints/noarch/rpm-eprints-org-1-1.noarch.rpm
sudo yum install eprints # 3.3.x and later

