#!/bin/bash

#
# Setup OS level service account.
#
sudo adduser --disabled-login eprints
sudo adduser www-data eprints

#
# Fetch and install EPrints via source in /coda
#
sudo mkdir /coda
git clone https://github.com/eprints/eprints3.4.git src/eprints3.4
cd src/eprints3.4
autoreconf -i
./configure --prefix=/coda/eprints3-4
make
sudo make install

#
# Setup EPrints user in MariaDB
#
read -p "MariaDB: eprints user password [changeme] " PWORD
if [[ "${PWORD}" = "" ]]; then
    PWORD="changeme"
fi
sudo mysql mysql <<EOF
CREATE USER 'eprints'@'localhost' IDENTIFIED by '${PWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'eprints'@'localhost' WITH GRANT OPTION;
UPDATE user SET Password = PASSWORD('${PWORD}') WHERE User = 'eprints';
FLUSH PRIVILEGES;
EOF
unset PWORD
