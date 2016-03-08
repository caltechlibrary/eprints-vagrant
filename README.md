
# An E-Prints Development VM

## Outline

1. Install [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
2. Install [Vagrant](https://www.virtualbox.org/wiki/Downloads)
3. Bring up vagrant in the usual way (e.g. _vagrant up_)
4. Follow the extra steps in the output to creating a new Vagrant instance to finish setting up the E-Prints repository
5. Make sure that the hosts defined in the "bin/epadmin create" process is defined in /etc/hosts in vagrant instance
6. Make sure that the hosts defined in the "bin/epadmin create" process is defined on your local machine
7. If all is well, point your web browser at the eprints dev host address defined

## Example steps I take to bring up a fresh vagrant instance

On my development box

```
    git clone git@github.com:rsdoiel/eprints-vagrant
    cd eprints-vagrant
    vagrant up && vagrant ssh
```

After vagrant comes up the "vagrant ssh" logs me into the vagrant instance. I still need
to follow the steps displayed at the end of that process. Here's a more verbose version
of those steps.

From there make sure we start MySQL

```
    sudo systemctl start mysqld.service
```

Then finish the eprints install as you would on a non-vagrant setup.

```
      cd /usr/share/eprints
      sudo su eprints
      ./bin/epadmin create
      exit
```

In the _epadmin create_ process you'll create the MySQL database setup but
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
