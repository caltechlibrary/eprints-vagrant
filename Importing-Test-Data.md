
# Importing Test Data

## EPrints' import tool

+ /usr/share/eprints3/[bin/import](https://wiki.eprints.org/w/API:bin/import)

### Importing a single record

Example assumes the EPrint repository id is "lemurprint", you are importing
EPrintXML documents from "PATH_TO_SINGLE_EPRINT_XML_DOC"

This is the basic command structure

```shell
    sudo su eprints
    /usr/share/eprints3/bin/import --verbose lemurprints eprint XML PATH_TO_SINGLE_EPRINT_XML_DOC
```

If you were loading document 1225.xml as username named "John Doe" whos user number (id) was 2 then
you could load that document with the following command.

```shell
    sudo su eprints
    /usr/share/eprints3/bin/import --verbose -user 2 lemurprints eprint XML 1225.xml
```

### Importing a directory of EPrintXML documents

Example assumes the EPrint repository id is "lemurprint", you are importing
a directory of EPrintXML documents from "PATH_TO_EPRINT_XML_DOCS"


```shell
    sudo su eprints
    /usr/share/eprints3/bin/import --verbose lemurprints eprint XML PATH_TO_EPRINT_XML_DOCS
```

If the EPrint XML documents are in a folder called "testdata", the user number you want to load
the documents as is "2" then the following command would look like--

```shell
    sudo su eprints
    /usr/share/eprints3/bin/import --verbose -user 2 lemurprints eprint XML testdata
```

## Importing records via REST API

## Optional configurations

+ [Customizations](Matching-Customizations.md)
+ [REST Access](REST-Access.md)

