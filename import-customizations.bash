#!/bin/bash

function importCustomization() {
	HOST="$1"
	EPRINT_PATH="$2"
	REPO_ID="$3"
	TARGET="$4"
	mkdir -p "${REPO_ID}/cfg/cfg.d"
	mkdir -p "${REPO_ID}/cfg/lang/en/phrases"
	mkdir -p "${REPO_ID}/cfg/workflows/eprint"
	cat <<EOF
scp -r "${HOST}:${EPRINT_PATH}/archives/${REPO_ID}/${TARGET}" "${REPO_ID}/${TARGET}"
EOF
	scp -r "${HOST}:${EPRINT_PATH}/archives/${REPO_ID}/${TARGET}" "${REPO_ID}/${TARGET}"
}

function importCGICustomizations() {
	HOST="$1"
	EPRINT_PATH="$2"
    TARGET="$3"
	mkdir -p "eprints3-cgi/${TARGET}"
	cat <<EOF
scp -r "${HOST}:${EPRINT_PATH}/${TARGET}" "eprints3-cgi/${TARGET}"
EOF
    DNAME=$(dirname "${TARGET}")
	scp -r "${HOST}:${EPRINT_PATH}/${TARGET}" "eprints3-cgi/${DNAME}/"
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
importCustomization "$1" "$2" "$3" "cfg/lang/en/phrases/eprint_fields.xml"
importCustomization "$1" "$2" "$3" "cfg/workflows/eprint/default.xml"
importCustomization "$1" "$2" "$3" "cfg/cfg.d/eprint_render.pl"
importCustomization "$1" "$2" "$3" "cfg/cfg.d/search.pl"
importCGICustomizations "$1" "$2" "cgi/users/lookup"
