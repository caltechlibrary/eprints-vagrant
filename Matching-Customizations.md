
# Matching field customization

In our various EPrint repositories we have customized fields (e.g. CaltechAUTHORS, CaltechTHESIS). If you are bringing up
a development instance of an existing EPrints Repository you need to bring that customizations along with you.  Mostly customizations
are found under the REPO_ID's cfg but if you have an old EPrints repository things might also be changed in the `perl_lib` directory
tree as well. This document is about handling the later scenarios. It assumes the production instance is the same version of the
development instance (e.g. production is v3.3.15 and development is setup as v3.3.15).

Normal process:

1. Copy the following to your Vagrant instance to your development vagrant directory (usually under your REPO ID)
    + `<archivepath>/archives/<archivename>/cfg/cfg.d/eprint_fields.pl` (this defines your fields) 
    + `<archivepath>/archives/<archivename>/cfg/cfg.d/eprint_fields_default.pl` (this defines default values for custom fields)
    + `<archivepath>/archives/<archivename>/cfg/cfg.d/eprint_validate.pl` (this defines custom field validation)
    + `<archivepath>/archives/<archivename>/cfg/lang/en/phrases/eprint_fields.xml` (this defines display values for some custom fields)
    + `<archivepath>/archives/<archivename>/cfg/workflows/eprint/default.xml` (this defines how the field workflows are handled)
    + `<archivepath>/cgi/users/lookup/` (this sets the "Ajax" auto complete for fields)
    + `<archivepath>/archives/<archivename>/cfg/cfg.d/eprint_render.pl` (this defines how fields behave in the abstract)
    + `<archivepath>/archives/<archivename>/cfg/cfg.d/search.pl` (this defines search behaviors for your custom fields)
2. Bring up your vagrant EPrints instance
3. Copy from `/vagrant/<archivename>/*` to where EPrints is setup in the vagrant instance (e.g. `/usr/shared/eprints/archives/`)
4. Reload the customization, WARNING: This triggers changes to the MySQL table schema!!!!
    + `<archivepath>/bin/epadmin reload <archivename>` (run this command)

Extended process:

In our extended case we need to also copy the files in `<archivepath>/perl_lib/EPrints/Plugin` so we pickup customizations in unsual places.
The import/deploy scripts referenced below will do their best to include this.

Here is a general example for an "authors" style repository.

+ Production EPrints is installed in /production/eprints3 on a machine called authors.example.edu.
+ Our development copy running under vagrant has EPrints3 running from /usr/shared/eprints3
+ Our repository id is "authors"

```shell
    bash import-customizations.bash authors.example.edu /production/eprints3 authors
```

Start up Vagrant with EPrints and ssh into it

```shell
    vagrant up
    vagrant ssh
```

Now copy the customizations into place (I've assumed here the dev instances' repo id is authorsdev). 

```shell
    bash deploy-customizations.bash authors authorsdev
```

Now you need to make sure any added schema or other changes from vanilla EPrints  are made

```shell
    sudo su eprints
    /usr/share/eprints3/bin/epadmin update authorsdev
    /usr/share/eprints3/bin/epadmin reload authorsdev
    exit
    sudo /etc/init.d/apache2 stop
    sudo /etc/init.d/apache2 start
```

Test and debug any missing customization from here.

## Optional configurations

+ [REST Access](REST-Access.md)
+ [Test Data](Importing-Test-Data.html)

