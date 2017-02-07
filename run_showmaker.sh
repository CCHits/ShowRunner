#!/bin/bash

cd /var/Website/CLI
cp -f /vagrant/config_local.php .

git pull

FROM=show@cchits.net
TO=show@cchits.net
SERVER=mailserver
USER=admin
PASS=admin

if [ -n "$1" ]; then
  V1="$1"
fi

if [ -n "$2" ]; then
  V2="$2"
fi

if [ -f /vagrant/mailconfig ]; then
  source /vagrant/mailconfig
  EXECUTE="sudo php showmaker.php $V1 $V2 | sendemail -f '$FROM' -t '$TO' -u 'Running ShowMaker' -s '$SERVER' -xu '$USER' -xp '$PASS' -o timeout=0 -o tls=auto"
else
  EXECUTE="sudo php showmaker.php $V1 $V2"
fi
echo "Running showmaker.php $V1 $V2"
bash -c "$EXECUTE"
sudo shutdown -h now
