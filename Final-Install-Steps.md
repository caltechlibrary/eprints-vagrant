
# EPrints v3.3.15 Install Notes

This vagrant file setups up Ubuntu 14.04 LTS because that is the last one that
has clear install instructions for EPrints v3.3.15. When testing Ubuntu 16.04
problems were not resolved by the linked version on the [wiki instruction page](http://wiki.eprints.org/w/Installing_EPrints_on_Debian/Ubuntu).

Make sure you running the latest Vagrant. Clear out any stale cached boxes if
necessary.


## Inline steps taken by the Vagrant file

Installs a vanilla Ubuntu 14.04 LTS machine. Additionall it does add the eprints
debian repository to /etc/apt/sources.lists.d/eprints.list
and runs `apt update`. This could be done manually.


## The Final Steps

These are the steps you need to take after VM is running.

### Install Eprints 

FIXME: This useradd probably should include options to prevent eprints as a login account...

```shell
    vagrant ssh
    sudo useradd eprints
    sudo apt update
    sudo apt upgrade
    sudo apt install eprints
```        

Now you should be ready to install eprints v3.3.15 and its required software.
After `vagrant ssh` run `sudo apt-get install eprints`. Answer 'Y' when prompted
about installing software and accepting an unsigned package.

This will install a bunch of software. Some, like MySQL, will prompt for
additional inputs. Accept the defaults. Then proceed to update your local
/etc/hosts on both your dev box and vagrant VM so the rest of EPrints'
install process will work easily.

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

## Next steps

+ Check to see everything is running as expected, create any service accounts you need (E.g. epautomation)
+ Customize the fields for the EPrints installation per development needs (e.g. our AUTHORS and THESIS repository have extra fields)

## Setting Up REST Access

Steps:

1. Switch to the *eprints* user
2. Find *user_roles.pl* for your specific repository 
3. Make a backup copy
4. Update user_roles.pl
5. Change back to where EPrints is installed (e.g. /usr/share/eprints)
6. Reload eprints using epadmin and exit *eprints* user
7. Restart Apache2

In this example you should set REPO_ID to the development repository id (e.g. repotest in this example).

```shell
    # Step 1
	sudo su eprints`
	REPO_ID="repotest"
    # Step 2
	cd "/usr/share/eprint3/archives/${REPO_ID}/cfg/cfg.d/"
    # Step 3
	cp -p user_roles.pl "user_roles.pl$(date +%Y%m%d)"
    # Step 4 - Edit file as needed to add role options below
	vi user_roles.pl
    # Step 5
	cd /usr/share/eprints3
    # Step 6
	./bin/epadmin reload "${REPO_ID}"
    exit
    # Step 7
    sudo /etc/init.d/apache2 restart
```

Depending on your goals you take the following approach to updating *user_roles.pl*

+ add `rest` to the appropriate role (e.g. admin)
+ for public REST access add the following to public role
	+ `+/archives/rest/get`
	+ `+/subjects/rest/get`
+ or create a "hat" with the specific settings needed
	+ `+/archives/rest/get`
	+ `+/archives/rest/put`
	+ `+/subjects/rest/get`
	+ `+/subjects/rest/put`

## Next Steps


See [Matching-Customization.md](Matching-Customization.md) if are trying to re-create a customized EPrints instance

See [Importing-Test-Data.md](Importing-Test-Data.html) for strategies on importing test data for testing EPrints


