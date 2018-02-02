
# REST Access

## Setting Up Roles and permissions for REST Access

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


## Optional configurations

+ [Customizations](Matching-Customizations.md)
+ [Test Data](Importing-Test-Data.html)

