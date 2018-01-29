
# Matching field customization

In our various EPrint repositories we have customized fields (e.g. CaltechAUTHORS, CaltechTHESIS). If you are bringing up
a development instance of EPrints you need to bring that customization along with you.  This can be done is several steps.

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

Now copy the customizations into place.

```shell
    bash deploy-customizations.bash authors
```

