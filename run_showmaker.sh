#!/bin/bash

cd /var/Website/CLI
cp -f /vagrant/config_local.php .

git pull

FROM=show@cchits.net
TO=show@cchits.net
SERVER=mailserver
USER=admin
PASS=admin

#V1=monthly
#V2=20171130
#V3=historic

if [ -n "$1" ]; then
  V1="$1"
fi

if [ -n "$2" ]; then
  V2="$2"
fi

if [ -n "$3" ]; then
  V3="$3"
fi

if [ -f /vagrant/mailconfig ]; then
  source /vagrant/mailconfig
  EXECUTE="sudo php showmaker.php $V1 $V2 $V3 | sendemail -f '$FROM' -t '$TO' -u 'Running ShowMaker' -s '$SERVER' -xu '$USER' -xp '$PASS' -o timeout=0 -o tls=auto"
else
  EXECUTE="sudo php showmaker.php $V1 $V2 $V3"
fi
echo "Running showmaker.php $V1 $V2 $V3"
bash -c "$EXECUTE"
sudo shutdown -h 10
