#!/bin/bash

function deployCustomizations() {
	SOURCE_REPO_ID="$1"
	DEV_REPO_ID="$2"

	# Repository customizations
	sudo cp -vpR "${SOURCE_REPO_ID}"/* "/usr/share/eprints3/archives/${DEV_REPO_ID}/"
	sudo chown -R "eprints" "/usr/share/eprints3/archives/${DEV_REPO_ID}"
	# System wide customizations
	sudo cp -vpR "eprints3-customizations/cgi/users/lookup/"* "/usr/share/eprints3/cgi/users/lookup/"
	#sudo cp -ivpR "eprints3-customizations/perl_lib/"* "/usr/share/eprints3/perl_lib/"
	sudo cp -vpR "eprints3-customizations/perl_lib/"* "/usr/share/eprints3/perl_lib/"
	sudo chown -R "eprints" "/usr/share/eprints3"
}

if [ "$#" != "2" ]; then
	cat <<EOF
USAGE: $(basename "$0") SOURCE_REPO_ID DEV_REPO_ID

EOF
	exit 1
fi

deployCustomizations "$1" "$2"
cat <<EOF

Now will likely need to run the following from your vagrant session:

    sudo su eprints
    /usr/share/eprints3/bin/epadmin update ${DEV_REPO_ID}
    /usr/share/eprints3/bin/epadmin reload ${DEV_REPO_ID}
    exit
    sudo /etc/init.d/apache2 restart

EOF

