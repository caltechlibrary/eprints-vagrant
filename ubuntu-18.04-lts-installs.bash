#!/bin/bash

#
# The following are run after you've create the VM and done
# vagrant ssh
#

#
# Basic Ubuntu setup
#
sudo apt update
sudo apt upgrade
sudo apt install build-essential autoconf automake libtool
sudo apt autoremove
sudo apt autoclean

#
# Minimal Requirements for LAMP
#
sudo apt install apache2 \
    letsencrypt \
    libapache2-mod-perl2 \
    libdbi-perl \
    libjson-pp-perl \
    libcgi-fast-perl libcgi-pm-perl \
    libcgi-test-perl libfcgi-perl \
    libxml-libxml-perl \
    libclass-dbi-mysql-perl \
    libcrypt-mysql-perl \
    libdatetime-format-mysql-perl \
    libdbd-mysql-perl \
    libtime-piece-mysql-perl \
    mariadb-server mariadb-client
sudo a2enmod cgid
sudo systemctl restart apache2

#
# Required for EPrints specific LAMP setup
#
sudo apt install perl libncurses5 libselinux1 libsepol1 apache2 \
    libapache2-mod-perl2 libxml-libxml-perl libunicode-string-perl \
    libterm-readkey-perl libmime-lite-perl libmime-types-perl \
    libdigest-sha-perl libdbd-mysql-perl libxml-parser-perl libxml2-dev \
    libxml-twig-perl libarchive-any-perl libjson-perl lynx wget \
    ghostscript xpdf antiword elinks texlive-base texlive-base-bin \
    psutils imagemagick adduser tar gzip \
    unzip libsearch-xapian-perl

#
# Required for common EPrints plugins
#
sudo apt install libbiblio-citation-parser-perl libdate-calc-perl \
    libgeo-ip-perl libgeo-ipfree-perl \
    libdigest-hmac-perl perl-doc


#
# Cleanup system
#
sudo apt autoremove
sudo apt autoclean

