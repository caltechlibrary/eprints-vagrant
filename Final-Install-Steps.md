
# EPrints v3.4 Install Notes

This vagrant file setups up Ubuntu 18.04 LTS in preparation to install EPrints v3.4.x.
Make sure you running the latest Vagrant. Clear out any stale cached boxes if
necessary.


## After your vagrant instance is up and running

Install the following Debian packages to support EPrints

### Development tools needed 

```
    sudo apt update
    sudo apt upgrade
    sudo apt install build-essential autoconf automake libtool
    sudo apt autoremove
    sudo apt autoclean
```

### EPrints required and suggested packages

These were ones I found I needed to add to get things working.

```
    sudo apt install apache2 \
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
```


The following I found in the EPrints Wiki

    https://wiki.eprints.org/w/Installing_EPrints_on_Debian/Ubuntu

NOTE: I've removed the MySQL server/client install from the list because I 
have already installed MariaDB instead.

```
    sudo apt install perl libncurses5 libselinux1 libsepol1 apache2 \
        libapache2-mod-perl2 libxml-libxml-perl libunicode-string-perl \
        libterm-readkey-perl libmime-lite-perl libmime-types-perl \
        libdigest-sha-perl libdbd-mysql-perl libxml-parser-perl libxml2-dev \
        libxml-twig-perl libarchive-any-perl libjson-perl lynx wget \
        ghostscript xpdf antiword elinks texlive-base texlive-base-bin \
        psutils imagemagick adduser tar gzip \
        unzip libsearch-xapian-perl 
```

Depending on the EPrints plugins you want, you may need to install.

```
    sudo apt install libbiblio-citation-parser-perl libdate-calc-perl \
        libgeo-ip-perl libgeo-ipfree-perl \
        libdigest-hmac-perl perl-doc
```

EPrints specific configuration

+ Clone EPrints v3.4 from the Github repository
+ Change directory into your cloned repository
+ Check out v3.4.0
+ Create a target deployment directory (e.g. /coda at Caltech Library)
+ Make sure an eprints user is created before building EPrints
+ Run `autoreconf -i` and generate the ./configure script by running 
+ Run `./configure` with the options for your target deployment
+ Run `make`
+ Run `sudo make install`

```
    sudo adduser --disabled-login eprints
    git clone https://github.com/eprints/eprints3.4.git src/eprints3.4
    cd src/eprints3.4
    autoreconf -i
    ./configure --prefix=/coda/eprints3-4
    make
    sudo make install
```

NOTE: bin/epadmin will fail under Ubuntu 18.04 LTS's Perl environment. You 
MUST follow the instructions in the Wiki for Ubuntu 18.04 LTS 
to fix bin/epadmin as well as setup DB access for configuring the database.

+ Fix bin/epadmin lines per Wiki: https://wiki.eprints.org/w/Installing_EPrints_on_Debian/Ubuntu
+ Add `eprints` user to MariaDB, set password, grant permissions
    + NOTE: You must change the "changeme" strings to an appropraite password!!!

```sql
    CREATE USER 'eprints'@'localhost' IDENTIFIED by 'changeme';
    GRANT ALL PRIVILEGES ON *.* TO 'eprints'@'localhost' WITH GRANT OPTION;
    UPDATE User SET Password = PASSWORD('changeme') WHERE User = 'eprints';
    FLUSH PRIVILEGES;
```


## EPrints Configuration

Make a note of the usernames/password setup during the installation process
for your MySQL and EPrints installation.

In a development environment isolated from the rest of the internet you can
also leverage setting up sudousers and a local .my.cnf for moving around the
system without getting prompted for passwords at every turn.

### Additional Options for your vagrant Host machine

In the _epadmin create_ process you'll create the MariaDB database setup but
also generate the Apache Virtual Host include information. It is important that
these be visible on your network.  On my dev box I needed to add the IP address
assigned by Virtual Box to my /etc/hosts on both the vagrant instance and my
development machine. In my case the ip address was 172.28.128.3 and I had
named my repository host lemurprints.local. On my vagrant host I did

```shell
    sudo su
    echo "172.28.128.3 lemurprints.local lemurprints" >> /etc/hosts
    exit
```

Then on my local development I also did

```shell
    sudo su
    echo "172.28.128.3 lemurprints.local lemurprints" >> /etc/hosts
    exit
```

At this point I could point my web browser at http://lemurprints.local and
start working with E-Prints.

#### And Finally ...

Per the console message when you did `apt-get` you'll need to do the following
and create your development EPrints repository.

```shell
    ###################################################################
    ##                                                               ##
    ##                    Welcome to EPrints 3                       ##
    ##                                                               ##
    ###################################################################
    ##                                                               ##
    ## For known issues please check:                                ##
    ##     http://wiki.eprints.org/w/Debian_Known_Issues             ##
    ##                                                               ##
    ## Getting Started:                                              ##
    ##        Before you can start using eprints you need to         ##
    ## configure your install, follow these simple steps:            ##
    ##                                                               ##
    ##  # su eprints                                                 ##
    ##        You have to logged in as the eprints user to operate   ##
    ##        with eprints                                           ##
    ##  # cd                                                         ##
    ##        To the eprints home directory (/usr/share/eprints3)    ##
    ##                                                               ##
    ##  # ./bin/epadmin create                                       ##
    ##        Follow the instruction to create your archive.         ##
    ##                                                               ##
    ##  # exit                                                       ##
    ##                                                               ##
    ##  # a2ensite eprints                                           ##
    ##                                                               ##
    ##  # apache2ctl restart                                         ##
    ##                                                               ##
    ##                         ##### DONE #####                      ##
    ##                                                               ##
    ##  For more documentation please see the eprints wiki:          ##
    ##           http://wiki.eprints.org/w/Documentation             ##
    ##                                                               ##
    ###################################################################
```

Check and see everything is running as expected. 

## Optional configurations

+ [Customizations](Matching-Customizations.md)
+ [REST Access](REST-Access.md)
+ [Test Data](Importing-Test-Data.html)

