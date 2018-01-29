#!/bin/bash

function deployCustomizations() {
	SOURCE_REPO_ID="$1"
	DEV_REPO_ID="$2"
	cat <<EOF
copying ${SOURCE_REPO_ID} to /usr/share/eprints3/archives/${DEV_REPO_ID}
EOF
	sudo cp -vpR "${SOURCE_REPO_ID}"/* "/usr/share/eprints3/archives/${DEV_REPO_ID}/"
	sudo chown -R "eprints" "/usr/share/eprints3/archives/${DEV_REPO_ID}"
}
if [ "$#" != "2" ]; then
	cat <<EOF
USAGE: $(basename "$0") SOURCE_REPO_ID DEV_REPO_ID

EOF
	exit 1
fi
deployCustomizations "$1" "$2"
echo "Now you should be ready to use epadmin reload on the repository"
