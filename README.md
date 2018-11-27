
# An EPrints 3.4.x Development VM

This is the Vagrant instance describing who Caltech Library's
programming staff brings up EPrints running under Ubuntu 18.04 LTS. 
It includes some Caltech Library specific assumptions (e.g. 
a non-standard installation directory of `/coda`).


## Requirements

+ Vagrant 2.x or better

## Quick version

1. Install [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
2. Install [Vagrant](https://www.virtualbox.org/wiki/Downloads)
3. Clone https://github.com/caltechlibrary/eprints-vagrant
4. From the cloned directory bring up your new EPrints Virtual box
5. SSH into your EPrints Virtual box
6. run /vagrant/ubuntu-18.04-lts-installs.bash
7. run /vagrant/account-and-directory.bash
8. Follow EPrints' instruction for creating and configuring EPrints

```shell
    git clone https://github.com/caltechlibrary/eprints-vagrant
    cd eprints-vagrant
    vagrant up
    vagrant ssh
    # You should now be in your VM
    /vagrant/ubuntu-18.04-lts-installs.bash
    /vagrant/account-and-directory.bash
    # When you're ready to setup and configure EPrints
    cd /coda/eprints3-4
    sudo su eprints
    ./bin/epadmin create pub
```

At this point you should follow the standard EPrints installation
instructions at https://wiki.eprints.org.

## Customize version

On my development box

```
    git clone https://github.com/caltechlibrary/eprints-vagrant
    cd eprints-vagrant
    vagrant up 
    vagrant ssh
    # Follow the steps as needed 
    more /vagrant/Final-Install-Steps.md
```

Then follow the instructions in [final install steps](Final-Install-Steps.md)

