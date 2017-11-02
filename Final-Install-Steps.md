
# EPrints v3.3.15 Install Notes

This vagrant file setups up Ubuntu 14.04 LTS because that is the last one that
has clear install instructions for EPrints v3.3.15. When testing Ubuntu 16.04
problems were not resolved by the linked version on the [wiki instruction page](http://wiki.eprints.org/w/Installing_EPrints_on_Debian/Ubuntu).

Make sure you running the latest Vagrant. Clear out any stale cached boxes if
necessary.


## Inline steps taken by the Vagrant file

Installs a vanilla Ubuntu 14.04 LTS machine. Additionall it does add the eprints
debian repository to /etc/apt/sources.lists.d/eprints.list
and runs `apt-get update`. This could be done manually.


## The Final Steps

These are the steps you need to take after VM is running.

### Create EPrints user/group

```shell
    sudo useradd eprints
```        

Now you should be ready to install eprints v3.3.15 and its required software.
After `vagrant ssh` run `sudo apt-get install eprints`. Answer 'Y' when prompted
about installing software and accepting an unsigned package.

This will install a bunch of software. Some, like MySQL, will prompt for
additional inputs. Accept the defaults. Then proceed to update your local
/etc/hosts on both your dev box and vagrant VM so the rest of EPrints'
install process will work easily.

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
