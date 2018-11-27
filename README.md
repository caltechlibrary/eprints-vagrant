
# An EPrints 3.4.x Development VM

## Requirement

+ Vagrant 2.x or better

## Outline

1. Install [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
2. Install [Vagrant](https://www.virtualbox.org/wiki/Downloads)
3. Bring up vagrant in the usual way (e.g. _vagrant up_)
4. Follow the extra steps in the output to creating a new Vagrant instance to finish setting up the EPrints repository
5. Make sure that the hosts defined in the "bin/epadmin create" process is defined in /etc/hosts in vagrant instance
6. Make sure that the hosts defined in the "bin/epadmin create" process is defined on your local machine
7. If all is well, point your web browser at the eprints dev host address defined

## Example steps I take to bring up a fresh vagrant instance

On my development box

```
    git clone git@github.com:rsdoiel/eprints-vagrant
    cd eprints-vagrant
    vagrant up 
    vagrant ssh
```

Then follow the instructions in [final install steps](Final-Install-Steps.md)

