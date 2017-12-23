#!/bin/bash

cd /var/Website/CLI
cp -f /vagrant/config_local.php .
rm -Rf /var/Website/CLI/TEMP/*

git pull

FROM=show@cchits.net
TO=show@cchits.net
SERVER=mailserver
USER=admin
PASS=admin
OWNER=Mine

#V1=monthly
#V2=20161231
#V3=historic
#V4=debug

if [ -n "$1" ]; then
  V1="$1"
fi

if [ -n "$2" ]; then
  V2="$2"
fi

if [ -n "$3" ]; then
  V3="$3"
fi

if [ -n "$4" ]; then
  V4="$4"
fi

if [ -f /vagrant/mailconfig ]; then
  source /vagrant/mailconfig
  EXECUTE="sudo php showmaker.php $V1 $V2 $V3 $V4 | sendemail -f '$FROM' -t '$TO' -u 'Running ShowMaker ($OWNER)' -s '$SERVER' -xu '$USER' -xp '$PASS' -o timeout=0 -o tls=auto"
else
  EXECUTE="sudo php showmaker.php $V1 $V2 $V3 $V4"
fi
echo "Running showmaker.php $V1 $V2 $V3 $V4"
bash -c "$EXECUTE"
if [ "$NOSHUT" == "" ]; then
  sudo shutdown -h 10
fi
