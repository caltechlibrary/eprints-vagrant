
# EPrints v3.3.15 Install Notes

## Inline steps taken by the Vagrant file

The following are done by the `vagrant up` command via in-line shell directive in Vagrantfile. 
They are provided here as reference.  You could perform them on manually if you needed.

### Install required software

```shell
    sudo apt-get install perl libncurses5 libselinux1 libsepol1 apache2 libapache2-mod-perl2 libxml-libxml-perl libunicode-string-perl \
        libterm-readkey-perl libmime-lite-perl libmime-types-perl libdigest-sha-perl libdbd-mysql-perl libxml-parser-perl libxml2-dev \
        libxml-twig-perl libarchive-any-perl libjson-perl lynx wget ghostscript xpdf antiword elinks pdftk texlive-base texlive-base-bin \
        psutils imagemagick adduser tar gzip mysql-server mysql-client unzip libsearch-xapian-perl \
        autoconf autoconf-archive git -y
```

### Create EPrints user/group

```shell
    sudo useradd --system --create-home --user-group eprints
```        

Now you should be ready for the final manual bits.

## The Final Steps

### Configure MySQL access

The EPrints create script will expect to use an account (e.g. root)
for setting and install its database.  It expects a password so
you need to setup before proceeding to install EPrints from source.

In the example SQL statement below the DB Admin account is assumed to be
root and password SOME_MIGHTY_SECRET. These are ONLY examples
and you should pick what is appropriate for your machine. The sql command
can usually be run from the SQL shell (e.g. mysql client) from a privileged
account like _root_.

```
    USE mysql;
    UPDATE user SET Password = PASSWORD('SOME_MIGHTY_SECRET') WHERE User = 'root' AND Host = 'localhost';
    FLUSH PRIVILEGES;
```



### Now install EPrints from source

These steps are run as root (e.g. `sudo su`).

```shell
    # NOTE: Stop to setup MySQL access from eprints account
    # Usually you need to set password for the admin user of MySQL
    # and note it for when you are prompted in the script on
    # epadmin create.
    git clone https://github.com/eprints/eprints.git /opt/eprints3
    cd /opt/eprints3
    git checkout tags/v3.3.15
    autoreconf
    automake --add-missing
    autoconf
    ./configure --prefix=$PWD
    chown -R eprints:eprints .
    su eprints
    ./bin/epadmin create
    exit
    echo 'Include /opt/eprints3/cfg/apache.conf' > /etc/apache2/sites-available/eprints.conf
    a2ensite eprints
```

Note the hostname info you created when setting up the repository. Add it
to both your dev machines /etc/hosts and the vagrant /etc/hosts if needed.

After creating an E-Prints repository and updating /etc/hosts file restart apache

```shell
    systemctl restart apache2.service
```

The EPrints configuration still interact with your MySQL install. Makesure
it is still up.

```shell
    systemctl restart mysql.service
```

Point your browser at your EPrints and install for testing/development.

