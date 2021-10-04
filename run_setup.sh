#!/bin/bash
if [ ! -d /var/Website ] ; then
  cd /var
  git clone https://github.com/CCHits/Website.git
  cd Website/CLI
  cp /vagrant/config_local.php .
fi
