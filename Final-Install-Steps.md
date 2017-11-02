
# EPrints v3.3.15 Install Notes

This vagrant file setups up Ubuntu 14.04 LTS because that is the last one that has clear install instructions for EPrints v3.3.15.
When testing Ubuntu 16.04 problems were not resolved by the linked version on the [wiki instruction page](http://wiki.eprints.org/w/Installing_EPrints_on_Debian/Ubuntu).

Make sure you running the latest Vagrant. Clear out any stale cached boxes if necessary.


## Inline steps taken by the Vagrant file

The following are done by the `vagrant up` command via in-line shell directive in Vagrantfile. 
They are provided here as reference.  You could perform them on manually if you needed.

### Install required software

```shell
    sudo apt-get install perl libncurses5 libselinux1 libsepol1 apache2 libapache2-mod-perl2 libxml-libxml-perl libunicode-string-perl \
        libterm-readkey-perl libmime-lite-perl libmime-types-perl libdigest-sha-perl libdbd-mysql-perl libxml-parser-perl libxml2-dev \
        libxml-twig-perl libarchive-any-perl libjson-perl lynx wget ghostscript xpdf antiword elinks pdftk texlive-base texlive-base-bin \
        psutils imagemagick adduser tar gzip mysql-server mysql-client unzip libsearch-xapian-perl \
        autoconf autoconf-archive git curl -y
```

## The Final Steps

These are the steps you need to take after VM is running.

### Create EPrints user/group

```shell
    sudo useradd eprints
```        

Now you should be ready for the final manual bits.

1. Add the debian repo to /etc/apt/source.list.d/eprints.list
2. apt-get update
3. apt-get install eprints

This is a transcript of the steps after `vagrant ssh`

```shell
    sudo su
    echo "deb http://deb.eprints.org/ stable/" > /etc/apt/sources.list.d/eprints.list
    apt-get update
    apt-get install eprints
```

### Additional Options for your vagrant Host machine

In the _epadmin create_ process you'll create the MariaDB database setup but
also generate the Apache Virtual Host include information. It is important that
these be visible on your network.  On my dev box I needed to add the IP address
assigned by Virtual Box to my /etc/hosts on both the vagrant instance and my
development machine. In my case the ip address was 172.28.128.3 and I had
named my repository host lemurprints.local. On my vagrant host I did

```
    sudo su
    echo "172.28.128.3 lemurprints.local lemurprints" >> /etc/hosts
    exit
```

Then on my local development I also did

```
    sudo su
    echo "172.28.128.3 lemurprints.local lemurprints" >> /etc/hosts
    exit
```

At this point I could point my web browser at http://lemurprints.local and
start working with E-Prints.

