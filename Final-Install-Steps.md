
# EPrints v3.3.15 Install Notes

## Inline steps taken by the Vagrant file

The following are done by the `vagrant up` command via in-line shell directive in Vagrantfile. 
They are provided here as reference.  You could perform them on manually if you needed.

### Install required software

```shell
    sudo apt-get install perl libncurses5 libselinux1 libsepol1 apache2 libapache2-mod-perl2 libxml-libxml-perl libunicode-string-perl \
        libterm-readkey-perl libmime-lite-perl libmime-types-perl libdigest-sha-perl libdbd-mysql-perl libxml-parser-perl libxml2-dev \
        libxml-twig-perl libarchive-any-perl libjson-perl lynx wget ghostscript xpdf antiword elinks pdftk texlive-base texlive-base-bin \
        psutils imagemagick adduser tar gzip mariadb-server mariadb-client unzip libsearch-xapian-perl git -y
```

### Create EPrints user/group

```shell
    sudo useradd --system --create-home --user-group eprints
```        

Now you should be ready for the final manual bits.

## The Final Steps

### Now install EPrints from source

This steps are run as root (e.g. `sudo su`).

```shell
    git clone https://github.com/eprints/eprints.git /opt/eprints3
    cd /opt/eprints3
    git checkout v3.3.15
    chown -R eprints:eprints .
    export APACHE_RUN_USER=eprints
    export APACHE_RUN_GROUP=eprints
    echo 'Include /opt/eprints3/cfg/apache.conf' > /etc/apache2/sites-available/eprints.conf
    a2ensite eprints
    systemctl restart apache2.service
    su eprints
    ./bin/epadmin create
    exit
```

Note the hostname info you created when setting up the repository. Add it
to both your dev machines /etc/hosts and the vagrant /etc/hosts if needed.

After creating an E-Prints repository and updating /etc/hosts file restart apache

```shell
    systemctl restart httpd.service
```

The EPrints configuration still interact with your MariaDB install. Makesure
it is still up.

```shell
    systemctl restart mariadb.service
```

Point your browser at your EPrints and install for testing/development.

