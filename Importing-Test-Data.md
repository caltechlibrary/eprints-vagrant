
# Importing Test Data

## EPrints' import tool

+ [bin/import](https://wiki.eprints.org/w/API:bin/import)

### Importing a single record

Example assumes the EPrint repository id is "lemurprint", you are importing
EPrintXML documents from "PATH_TO_SINGLE_EPRINT_XML_DOC"

```shell
    cd /usr/share/eprints
    sudo su eprints
    bin/import lemurprints eprint XML PATH_TO_SINGLE_EPRINT_XML_DOC
```

### Importing a directory of EPrintXML documents

Example assumes the EPrint repository id is "lemurprint", you are importing
a directory of EPrintXML documents from "PATH_TO_EPRINT_XML_DOCS"


```shell
    cd /usr/share/eprints
    sudo su eprints
    bin/import lemurprints eprint XML PATH_TO_EPRINT_XML_DOCS
```

## Importing records via REST API

## Optional configurations

+ [Customizations](Matching-Customizations.md)
+ [REST Access](REST-Access.md)

