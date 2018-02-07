#!/bin/bash

function importCustomization() {
	HOST="$1"
	EPRINT_PATH="$2"
	REPO_ID="$3"
	TARGET="$4"
	mkdir -p "${REPO_ID}/cfg/cfg.d"
	mkdir -p "${REPO_ID}/cfg/lang/en/phrases"
	mkdir -p "${REPO_ID}/cfg/workflows/eprint"
	mkdir -p "${REPO_ID}/cfg/workflows/metafield"
	mkdir -p "${REPO_ID}/cfg/workflows/user"
	mkdir -p "${REPO_ID}/cfg/namedsets/"
	cat <<EOF
scp -r "${HOST}:${EPRINT_PATH}/archives/${REPO_ID}/${TARGET}" "${REPO_ID}/${TARGET}"
EOF
	scp -r "${HOST}:${EPRINT_PATH}/archives/${REPO_ID}/${TARGET}" "${REPO_ID}/${TARGET}"
}

function importCustomizationDir() {
	HOST="$1"
	EPRINT_PATH="$2"
	REPO_ID="$3"
	TARGET="$4"
    DEST="$(dirname "$4")"
	mkdir -p "${REPO_ID}/cfg/cfg.d"
	mkdir -p "${REPO_ID}/cfg/lang/en/phrases"
	mkdir -p "${REPO_ID}/cfg/workflows/eprint"
	mkdir -p "${REPO_ID}/cfg/workflows/metafield"
	mkdir -p "${REPO_ID}/cfg/workflows/user"
	mkdir -p "${REPO_ID}/cfg/namedsets/"
	cat <<EOF
scp -r "${HOST}:${EPRINT_PATH}/archives/${REPO_ID}/${TARGET}" "${REPO_ID}/${DEST}"
EOF
	scp -r "${HOST}:${EPRINT_PATH}/archives/${REPO_ID}/${TARGET}" "${REPO_ID}/${DEST}"
}

function importInCommonCustomizations() {
	HOST="$1"
	EPRINT_PATH="$2"

	# Copy Ajax auto completes and lookups
	TARGET="cgi/users/lookup"
	mkdir -p "eprints3-customizations/${TARGET}"
	DNAME=$(dirname "${TARGET}")
	scp -r "${HOST}:${EPRINT_PATH}/${TARGET}" "eprints3-customizations/${DNAME}/"

	# Copy missing Literaltext.pm (based on tests with CaltechAUTHORS) into our dev site_lib directory
	mkdir -p "eprints3-customizations/perl_lib/EPrints/MetaField"
	scp -r "${HOST}:${EPRINT_PATH}/perl_lib/EPrints/MetaField/Literaltext.pm" "eprints3-customizations/perl_lib/EPrints/MetaField/Literaltext.pm"
    #if [ "$?" = "0" ]; then
    #    scp -r "${HOST}:${EPRINT_PATH}/perl_lib/EPrints/MetaField.pm" "eprints3-cusotmizations/perl_lib/EPrints/"
    #fi
}

function importPlugins() {
	HOST="$1"
	EPRINT_PATH="$2"
	REPO_ID="$3"

	# Copy any local repo plugins that override system plugins
	# Copy the plugins.pl
	for TARGET in "${REPO_ID}/cfg/plugins" "${REPO_ID}/cfg/cfg.d/plugins.pl"; do
		DNAME=$(dirname "${TARGET}")
		mkdir -p "${DNAME}"
		scp -r "${HOST}:${EPRINT_PATH}/archives/${TARGET}" "${DNAME}/"
	done

    # Copy system wide plugins (test based on CaltechAUTHORS)
    for TARGET in "perl_lib/EPrints/Plugin/Screen"; do
		DNAME=$(dirname "${TARGET}")
		mkdir -p "eprints3-customizations/${DNAME}"
		scp -r "${HOST}:${EPRINT_PATH}/${TARGET}" "eprints3-customizations/${DNAME}/"
    done
}

if [ "$#" != "3" ]; then
	cat <<EOF
USAGE: $(basename "$0") PRODUCTION_HOSTNAME PRODUCTION_EPRINTS_PATH REPO_ID

EOF
	exit 1

fi

importCustomization "$1" "$2" "$3" "cfg/cfg.d/eprint_fields.pl"
importCustomization "$1" "$2" "$3" "cfg/cfg.d/eprint_fields_default.pl"
importCustomization "$1" "$2" "$3" "cfg/cfg.d/eprint_validate.pl"
importCustomization "$1" "$2" "$3" "cfg/workflows/eprint/default.xml"
importCustomization "$1" "$2" "$3" "cfg/workflows/metafield/default.xml"
importCustomization "$1" "$2" "$3" "cfg/workflows/user/default.xml"
importCustomizationDir "$1" "$2" "$3" "cfg/lang/en"
importCustomizationDir "$1" "$2" "$3" "cfg/namedsets"
importCustomization "$1" "$2" "$3" "cfg/cfg.d/eprint_render.pl"
importCustomization "$1" "$2" "$3" "cfg/cfg.d/search.pl"
importInCommonCustomizations "$1" "$2"
importPlugins "$1" "$2" "$3"
# Make an zip file of these customizations
zip -r "$3"-customizations.zip "$3" eprints3-customizations
