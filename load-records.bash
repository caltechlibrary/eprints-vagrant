#!/bin/bash

if [[ "$#" != "3" ]]; then
	echo "USAGE: $(basename "$0") REPO_ID EPRINT_USER_NO PATH_TO_EPRINT_XML_FILES"
	exit 1
fi

if [[ "$USER" != "eprints" ]]; then
	echo "Must run as the eprints user"
	exit 1
fi

REPO_ID="$1"
USER_NO="$2"
DOC_PATH="$3"

if [[ -d "${DOC_PATH}" ]]; then
	find "${DOC_PATH}" -type f | grep -E ".xml$" |  while read FNAME; do
		echo -n "Importing $FNAME"
		/usr/share/eprints3/bin/import --verbose --user "${USER_NO}" "${REPO_ID}" eprint XML "${FNAME}"
		if [[ "$?" = "0" ]]; then
			echo " OK"
			mv "${FNAME}" "${FNAME}.imported"
			if [[ "$?" != "0" ]]; then
				echo "Can't rename ${FNAME}, stopping"
				exit 1
			fi
		else
			echo "ERROR: Can't import ${FNAME}"
		fi
	done
fi
if [[ -f "${DOC_PATH}" ]]; then
	echo -n "Importing ${DOC_PATH}"
	/usr/share/eprints3/bin/import --verbose --user "${USER_NO}" "${REPO_ID}" eprint XML "${DOC_PATH}"
	if [[ "$?" = "0" ]]; then
		echo " OK"
		mv "${DOC_PATH}" "${DOC_PATH}.imported"
		if [[ "$?" != "0" ]]; then
			echo "Can't rename ${DOC_PATH}, stopping"
			exit 1
		fi
	else
		echo " ERROR, stopped"
		exit 1
	fi
fi
